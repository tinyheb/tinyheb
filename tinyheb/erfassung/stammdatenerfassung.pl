#!/usr/bin/perl -w
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

use lib "../";
#use Heb_stammdaten;
use Heb_krankenkassen;

my $q = new CGI;
#my $h = new Heb_stammdaten;
my $k = new Heb_krankenkassen;
my $debug=1;

my @aus = ('Anzeigen','Ändern','Neu','Löschen');
my @bund = ('NRW','Bayern','Rheinlandpfalz','Hessen');

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
my $id_krankenkasse = -1;
my $name_krankenkasse = '';
my $plz_krankenkasse = '';
my $ort_krankenkasse = '';
my $strasse_krankenkasse = '';
my $geb_kind = $q->param('geburtsdatum_kind') || '';
my $naechste_hebamme = $q->param('naechste_hebamme');
my $begruendung_nicht_nae_heb = $q->param('nicht_naechste_heb') || '';
my $datum = $q->param('datum') || '';
my $speichern = $q->param('Speichern');
my $auswahl = $q->param('auswahl') || 'Anzeigen';

print $q->header ( -type => "text/html", -expires => "-1d");
#print "Eingabe: $bezeichnung, $leistungstyp, $guelt_von, $guelt_bis, $speichern<br>\n" if $debug;


# Alle Felder zur Eingabe ausgeben
print '<head>';
print '<title>Stammdatenerfassung</title>';
print '</head>';
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Stammdatenerfassung</h1>';
print '<hr width="100%">';
print '</div><br>';
# Formular ausgeben
print '<form action="stammdatenerfassung.pl" method="get" target=_top>';
print '<table border="0" width="700" align="left">';

# Zeile Vorname, Nachname, Geburtsdatum
# z1 s1
print '<tr>';
print '<td>';
print_color('Vorname:',$vorname);
print '</td>';
# z1 s2
print '<td>';
print_color('Nachname:',$nachname);
print '</td>';
print '<td>';
# z1 s3
print_color('Geb.:',$geb_frau);
print '</td>';
print '</tr>';
print "\n";

# z2 s1
print '<tr>';
print '<td>';
print "<input type='text' name='vorname' value='$vorname' size='40'>";
print '</td>';
# z2 s2
print '<td>';
print "<input type='text' name='nachname' value='$nachname' size='40'>";
print '</td>';
# z2 s3
print '<td>';
print "<input type='text' name='geburtsdatum_frau' value='$geb_frau' size='10'>";
print '</td>';
print '</tr>';
print "\n";

# Zeile Telefonnumer
print '<tr>';
print '<td colspan=3>';
print '<b>Tel.:</b>';
print '</td>';
print '</tr>';
print '<tr>';
print '<td colspan=3>';
print "<input type='text' name='tel' value='$tel' size='40'>";
print '</td>';
print '</tr>';
print "\n";

# leere Zeile
print '<tr><td>&nbsp;</td></tr>';

# Zeile PLZ, Ort, Strasse, Entfernung
# z3 s1
print '<tr>';
print '<td colspan=3>';
print '<table border="0" align="left">';
# z3.1 s1
print '<tr>';
print '<td>';
print '<b>PLZ:</b>';
print '</td>';
# z3.1 s2
print '<td>';
print '<b>Ort:</b>';
print '</td>';
# z3.1 s3
print '<td>';
print '<b>Strasse:</b>';
print '</td>';
# z3.1 s4
print '<td>';
print '<b>Bundesland:</b>';
print '</td>';
print '</tr>';

# z3.2 s1
print '<tr>';
print '<td>';
print "<input type='text' name='plz' value='$plz' size='5'>";
print '</td>';
# z3.2 s2
print '<td>';
print "<input type='text' name='ort' value='$ort' size='40'>";
print '</td>';
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
print "<input type='text' name='kv_nummer' value='$kv_nummer' size='15'>";
print '</td>';
# z4.2 s2
print '<td>';
print "<input type='text' name='kv_gueltig' value='$kv_gueltig' size='10'>";
print '</td>';
# z4.2 s3
print '<td>';
print "<input type='text' name='versichertenstatus' value='$versichertenstatus' size='20'>";
print '</td>';
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
# zuerst Info w/ Krankenkasse holen
if ($ik_krankenkasse ne '') {
  ($id_krankenkasse,
   $name_krankenkasse,
   $plz_krankenkasse,
   $ort_krankenkasse,
   $strasse_krankenkasse) = $k->krankenkasse_sel('ID,NAME,PLZ,ORT,STRASSE',$ik_krankenkasse);
  $name_krankenkasse = 'nicht bekannte IK angegeben' unless defined ($name_krankenkasse);
  $ort_krankenkasse = '' unless defined ($ort_krankenkasse);
  $plz_krankenkasse = '' unless defined ($plz_krankenkasse);
  $strasse_krankenkasse = '' unless defined ($strasse_krankenkasse);
  $ik_krankenkasse = -1 unless defined ($name_krankenkasse);

} else {
  $name_krankenkasse = 'noch keine gültige Krankenkasse gewählt';
}
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
print "<input type='text' disabled value='$name_krankenkasse' size='28'>";
print "</td>";
print "<td>";
print "<input type='text' disabled value='$plz_krankenkasse&nbsp;$ort_krankenkasse' size='30'>";
print "</td>";
print "<td>";
print "<input type='text' disabled value='$strasse_krankenkasse' size='20'>";
print "</td>";
print '</tr>';
print '</table>';
print "\n";

# Zeile mit Geburtsdatum Kind
print '<tr>';
print '<td colspan 3>';
print '<table border="0" align="left">';
print '<tr>';
print '<td>';
print "<b>Geburtsdatum Kind</b>";
print '</td>';
print '</tr>';
print '<td>';
print "<input type='text' name='geburtsdatum_kind' value='$geb_kind' size='14'>";
print '</td>';
print '</tr>';
print '</table>';
print "\n";

# Zeile mit nächste Hebamme
print '<tr>';
print '<td colspan 3>';
print '<table border="0" align="left">';
print '<tr>';
print '<td>';
print "<b>nächste Hebamme&nbsp;</b>";
if (defined ($naechste_hebamme) ) {
  print "<input type='checkbox' name='naechste_hebamme' value='j' checked>";
} else {
  print "<input type='checkbox' name='naechste_hebamme' value='j'>";
}
print '</td>';
print '</tr>';
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
print '<input type="button" name="reset" value="Inhalt löschen" onClick="return loeschen()">';
print '<td>';
print '</tr>';
print '</table>';

print '</form>';
print '</tr>';
print '</table>';
# ---------- scripte
print "<script>";
print 'function loeschen() {open("stammdatenerfassung.pl","_top");}';
print "</script>";
print "</body>";
print "</html>";

sub print_color {
  my ($bezeichnung,$variable) = @_;
  
  print '<font color=red>' if ($variable eq '');
  print "<b>$bezeichnung</b>";
  print '<font color=black>';
}
