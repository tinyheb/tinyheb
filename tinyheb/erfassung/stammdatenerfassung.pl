#!/usr/bin/perl -wT
#-w
#-d:ptkdb
#-d:DProf  

sub BEGIN {
  $ENV{DISPLAY} = "schloesser:0.0";
}

# author: Thomas Baum
# 07.02.2004
# Stammdaten erfassen

use strict;
use CGI;
use Date::Calc qw(Today);

use lib "../";
use Heb_stammdaten;
use Heb_krankenkassen;
use Heb_datum;

my $q = new CGI;
my $s = new Heb_stammdaten;
my $k = new Heb_krankenkassen;
my $d = new Heb_datum;

my $debug=1;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();
my @aus = ('Anzeigen','Ändern','Neu','Löschen');
my @bund = ('NRW','Bayern','Rheinlandpfalz','Hessen');
my @verstatus = ('freiwillig','gesetzlich','privat');

my $frau_id = $q->param('frau_id') || '0';
my $vorname = $q->param('vorname') || '';
my $nachname = $q->param('nachname') || '';
my $geb_frau = $q->param('geburtsdatum_frau') || '';
my $tel = $q->param('tel') || '';
my $strasse = $q->param('strasse') || '';
my $plz = $q->param('plz') || '';
my $ort = $q->param('ort') || '';
my $entfernung = $q->param('entfernung') || '';
my $kv_nummer = $q->param('krankenversicherungsnummer') || '';
my $kv_gueltig = $q->param('krankenversicherungsnummer_gueltig') || '';
my $versichertenstatus = $q->param('versichertenstatus') || '';
my $ik_krankenkasse = $q->param('ik_krankenkasse') || '';
my $bundesland = $q->param('bundesland') || '';
my $fk_krankenkasse = -1;
my $name_krankenkasse = '';
my $plz_krankenkasse = '';
my $ort_krankenkasse = '';
my $strasse_krankenkasse = '';
my $geb_kind = $q->param('geburtsdatum_kind') || '';
my $naechste_hebamme = $q->param('naechste_hebamme');
my $begruendung_nicht_nae_heb = $q->param('nicht_naechste_heb') || '';
my $datum = $q->param('datum') || '';
my $speichern = $q->param('Speichern');
my $frau_suchen = $q->param('frau_suchen');
my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
my $func = $q->param('func') || 0;

hole_frau_daten() if ($func == 1 || $func == 2);

# Infos zur Krankenkasse holen
if ($ik_krankenkasse ne '') {
  ($fk_krankenkasse,
   $name_krankenkasse,
   $plz_krankenkasse,
   $ort_krankenkasse,
   $strasse_krankenkasse) = $k->krankenkasse_sel('ID,NAME,PLZ,ORT,STRASSE',$ik_krankenkasse);
  $name_krankenkasse = 'nicht bekannte IK angegeben' unless defined ($name_krankenkasse);
  $ort_krankenkasse = '' unless defined ($ort_krankenkasse);
  $plz_krankenkasse = '' unless defined ($plz_krankenkasse);
  $strasse_krankenkasse = '' unless defined ($strasse_krankenkasse);
  $fk_krankenkasse = -1 unless defined ($name_krankenkasse);

} else {
  $name_krankenkasse = 'noch keine gültige Krankenkasse gewählt';
}

print $q->header ( -type => "text/html", -expires => "-1d");

suche_frau() if (defined($frau_suchen) );
if (($auswahl eq 'Neu') && defined($abschicken)) {
  $frau_id = speichern();
  $auswahl = 'Anzeigen';
}
if (($auswahl eq 'Ändern') && defined($abschicken)) {
  aendern();
  $auswahl = 'Anzeigen';
}
print '<head>';
print '<title>Stammdatenerfassung</title>';
print '<script language="javascript" src="stammdaten.js"></script>';
print '</head>';

# style-sheet ausgeben
print <<STYLE;
  <style type="text/css">
  .disabled { color:black; background-color:gainsboro}
  </style>
STYLE

if (($auswahl eq 'Löschen') && defined($abschicken)) {
  loeschen();
  print '<script>loeschen();</script>';
}


# Alle Felder zur Eingabe ausgeben
print '<body id="stammdaten_window" bgcolor=white>';
print '<div align="center">';
print '<h1>Stammdatenerfassung</h1>';
print '<hr width="100%">';
print '</div><br>';
# Formular ausgeben
print '<form name="stammdaten" action="stammdatenerfassung.pl" method="get" target=_top bgcolor=white>';
print '<table border="0" width="700" align="left">';

# Zeile Vorname, Nachname, Geburtsdatum
# z1 s1
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>ID</b></td>';
print '<td>';print_color('Vorname:',$vorname);print '</td>';
print '<td>';print_color('Nachname:',$nachname);print '</td>';
print '<td>';print_color('Geb.:',$geb_frau);print '</td>';
print '</tr>';
print "\n";

# z2 s1
print '<tr>';
print "<td><input type='text' name='frau_id' value='$frau_id' size='5'></td>";
print "<td><input type='text' name='vorname' value='$vorname' size='40'></td>";
# z2 s2
print "<td><input type='text' name='nachname' value='$nachname' size='40'></td>";
# z2 s3
print "<td><input type='text' name='geburtsdatum_frau' value='$geb_frau' size='10' onBlur='datum_check(this)'></td>";
print "<td><input type='button' name='frau_suchen' value='Suchen' onClick='return frausuchen(stammdaten.vorname,stammdaten.nachname,stammdaten.geburtsdatum_frau,form);'></tr>";
print '</table>';
print "\n";

# Zeile Telefonnumer
print '<tr><td><b>Tel.:</b></td></tr>';
print "<tr><td><input type='text' name='tel' value='$tel' size='40'></td>";

print '</tr>';
print "\n";

# leere Zeile
print '<tr><td>&nbsp;</td></tr>';

# Zeile PLZ, Ort, Strasse, Entfernung
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><b>PLZ:</b></td>';
print '<td><b>Ort:</b></td>';
print '<td><b>Strasse:</b></td>';
print '<td><b>Bundesland:</b></td>';
print '</tr>';

# Eingabe Felder
print "<tr>";
print "<td><input type='text' name='plz' value='$plz' size='5' onBlur='return plz_check(this)'></td>";
print "<td><input type='text' name='ort' value='$ort' size='40'></td>";
# z3.2 s3
print '<td>';
print "<input type='text' name='strasse' value='$strasse' size='40'>";
print '</td>';
# z3.2 s4
print '<td>';
print "<select name='bundesland' size=1>";
my $j=0;
while ($j <= $#bund) {
  print '<option';
  print ' selected' if ($bund[$j] eq $bundesland);
  print '>';
  print $bund[$j];
  print '</option>';
  $j++;
}
print '</td>';
print '</tr>';
print '</table>';
print "\n";

print '<tr>';
print '<td colspan=3>';
print '<b>Entfernung:</b>';
print '</td>';
print '</tr>';

print '<tr>';
print '<td colspan=3>';
print "<input type='text' name='entfernung' value='$entfernung' size='10'>";
print '</td>';
print '</tr>';
print "\n";

# leere Zeile 
print '<tr><td>&nbsp;</td></tr>';
# Zeile Krankenversicherungsnummer, Versichertenstatus, IK Krankenkasse
print '<tr>';
print '<td colspan=3>';
print '<table border="0" align="left">';
# z4.1 s1
print '<tr>';
print '<td>';
print '<b>KV-Nummer:</b>';
print '</td>';
# z4.1 s2
print '<td>';
print '<b>Gültig bis:</b>';
print '</td>';
# z4.1 s3
print '<td>';
print '<b>Versichertenstatus:</b>';
print '</td>';
# z4.1 s4
print '<td>';
print '<b>IK Krankenkasse:</b>';
print '</td>';
print '</tr>';
print "\n";

# z4.2 s1
print '<tr>';
print '<td>';
print "<input type='text' name='krankenversicherungsnummer' value='$kv_nummer' size='15' onBlur='return kvnr_check(this)'>";
print '</td>';
# z4.2 s2
print '<td>';
print "<input type='text' name='krankenversicherungsnummer_gueltig' value='$kv_gueltig' size='10' onBlur='return datum_check(this)'>";
print '</td>';
# z4.2 s3
print '<td>';
print "<select name='versichertenstatus' size=1>";
$j=0;
while ($j <= $#verstatus) {
  print '<option';
  print ' selected' if ($verstatus[$j] eq $versichertenstatus);
  print '>';
  print $verstatus[$j];
  print '</option>';
  $j++;
}
print "</td>\n";
# z4.2 s4
print '<td>';
print "<input type='text' name='ik_krankenkasse' value='$ik_krankenkasse' size='14'>";
print '</td>';
# z4.2 s5
print '<td>';
print "<input type='button' name='kasse_waehlen' value='Kasse auswählen' onClick='return kassen_auswahl();'>";
print '</td>';
print '</tr>';
print '</table>';
print "\n";

# zeile mit Krankenkasseninfos ausgeben
print '<tr>';
print '<td colspan=3>';
print '<table border="0" align="left">';
print '<tr>';
print '<td>';
print "<b>Name Krankenkasse</b>";
print '</td>';
print '<td>';
print '<b>Ort</b>';
print '</td>';
print '<td>';
print '<b>Straße</b>';
print '</td>';
print '</tr>';
print '<tr>';
print "<td>";
print "<input type='text' class=disabled disabled name='name_krankenkasse' value='$name_krankenkasse' size='28'>";
print "</td>";
print '<td>';
#print '<input style="color: green" type="text" disabled name="hugo" value="hugo">';
print "<input type='text' class=disabled disabled name='ort_krankenkasse' value='$plz_krankenkasse&nbsp;$ort_krankenkasse' size='30'>";
print "</td>";
print "<td>";
print "<input type='text' class=disabled disabled name='strasse_krankenkasse' value='$strasse_krankenkasse' size='20'>";
print "</td>";
print '</tr>';
print '</table>';
print "\n";

# Zeile mit Geburtsdatum Kind
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td>';
print "<b>Geburtsdatum Kind</b>";
print '</td>';
print '</tr>';
print '<td>';
print "<input type='text' name='geburtsdatum_kind' value='$geb_kind' size='14' onBlur='return datum_check(this)'>";
print '</td>';
print '</tr>';
print '</table>';
print "\n";

# Zeile mit nächste Hebamme
print '<tr>';
print '<td colspan=3>';
print '<table border="0" align="left">';
print '<tr>';
print '<td valign=top>';
print "<b>nächste Hebamme&nbsp;</b>";
if (defined ($naechste_hebamme) ) {
  print '<input type="checkbox" name="naechste_hebamme" value="j" checked onClick="check_begr(this,document.stammdaten)">';
} else {
  print '<input type="checkbox" name="naechste_hebamme" value="j" onClick="check_begr(this,document.stammdaten)">';
}
print '</td>';
print '<td valign=top>';
print '<b>Begründung falls nicht<br>nächste Hebamme</b>';
print '</td>';
print '<td valgin=bottom>';
print "<textarea ";
if (!defined ($naechste_hebamme) ) {
  print ' enabled ';
} else {
  print ' disabled ';
}
print "name='nicht_naechste_heb' rows='2' cols='50'>$begruendung_nicht_nae_heb</textarea>";
print '</td>';


print '</table>';
print "\n";

# leere Zeile
print '<tr><td>&nbsp;</td></tr>';
print "\n";

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td colspan 3>';
print '<table border="0" align="left">';
print '<tr>';
print '<td>';
print "<select name='auswahl' size=1>";
my $i=0;
while ($i <= $#aus) {
  print '<option';
  print ' selected' if ($aus[$i] eq $auswahl);
  print '>';
  print $aus[$i];
  print '</option>';
  $i++;
}
print '</select>';
print '</td>';
print '<td>';
print '<input type="button" name="reset" value="Inhalt löschen"';
print ' onClick="loeschen()">';
print '</td>';
print '<td>';
print '<input type="submit" name="abschicken" value="Speichern"';
print '</td>';
print '<td>';
print '<input type="button" name="vorheriger" value="vorheriger Datensatz" onclick="prev_satz(document.stammdaten)"';
print '</td>';
print '<td>';
print '<input type="button" name="naechster" value="nächster Datensatz" onclick="next_satz(document.stammdaten)"';
print '</td>';
print '</tr>';
print '</table>';
print '</form>';
print '</tr>';
print '</table>';
print <<SCRIPTE;
<script>
  set_focus(document.stammdaten);
</script>
SCRIPTE
print "</body>'";
print "</html>";

sub print_color {
  my ($bezeichnung,$variable) = @_;
  
  print '<font color=red>' if ($variable eq '');
  print "<b>$bezeichnung</b>";
  print '<font color=black>';
}

sub suche_frau {
  print "hallo suche Frau $vorname,$nachname,$geb_frau\n";
}

sub speichern {
  # Speichert die Daten in der Stammdaten Datenbank
  # print "Speichern in DB\n";
  # Datümer konvertierten
  my $geb_f = $d->convert($geb_frau);
  my $geb_k = $d->convert($geb_kind);
  my $kv_guelt = $d->convert($kv_gueltig);
  
  # jetzt speichern
  my $erg = $s->stammdaten_ins($vorname,$nachname,$geb_f,$strasse,$plz,$ort,$tel,
			       $entfernung,$kv_nummer,$kv_guelt,$versichertenstatus,
			       $fk_krankenkasse,$bundesland,$geb_k,$naechste_hebamme,
			       $begruendung_nicht_nae_heb,$TODAY);
  return $erg;
}

sub loeschen {
  # löscht Datensatz aus der Stammdaten Datenbank
  my $erg = $s->stammdaten_delete($frau_id);
  return $erg;
}

sub aendern {
  # Ändert die Daten zur angegebenen Frau in der Datenbank
  # print "Aendern $frau_id";
  # Datümer konvertierten
  my $geb_f = $d->convert($geb_frau);
  my $geb_k = $d->convert($geb_kind);
  my $kv_guelt = $d->convert($kv_gueltig);
  
  # jetzt speichern
  my $erg = $s->stammdaten_update($vorname,$nachname,$geb_f,$strasse,$plz,$ort,$tel,
			      $entfernung,$kv_nummer,$kv_guelt,$versichertenstatus,
			      $fk_krankenkasse,$bundesland,$geb_k,$naechste_hebamme,
			      $begruendung_nicht_nae_heb,$TODAY,$frau_id);
  return $erg;
}

sub hole_frau_daten {
  $frau_id = $s->max if ($frau_id > $s->max);
  $vorname='';
  while ($vorname eq '') {
    ($vorname,$nachname,$geb_frau,$geb_kind,$plz,$ort,$tel,$strasse,
     $bundesland,$entfernung,$kv_nummer,$kv_gueltig,$versichertenstatus,
     $fk_krankenkasse,$naechste_hebamme,
     $begruendung_nicht_nae_heb) = $s->stammdaten_frau_id($frau_id);
    
    if ($fk_krankenkasse ne '') {
      ($ik_krankenkasse,
       $name_krankenkasse,
       $plz_krankenkasse,
       $ort_krankenkasse,
       $strasse_krankenkasse) =
         $k->krankenkasse_id('IK,NAME,PLZ,ORT,STRASSE',$fk_krankenkasse);
    } else {
      ($ik_krankenkasse,
       $name_krankenkasse,
       $plz_krankenkasse,
       $ort_krankenkasse,
       $strasse_krankenkasse) = ('','','','','');
    }
    if (!defined($vorname)) {
      if ($frau_id <= 0) {
	$frau_id = 0;
	return;
      }
      $frau_id++ if ($func == 1);
      $frau_id-- if ($func == 2 && $frau_id > 1);
    }
  }
  return;
}
