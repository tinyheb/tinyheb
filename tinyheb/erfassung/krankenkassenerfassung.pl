#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

sub BEGIN {
  $ENV{DISPLAY} = "schloesser:0.0";
}

# author: Thomas Baum
# 24.03.2004
# Krankenkassen erfassen, ändern, löschen

use strict;
use CGI;
use Date::Calc qw(Today);

use lib "../";
use Heb_krankenkassen;
use Heb_datum;

my $q = new CGI;
my $k = new Heb_krankenkassen;
my $d = new Heb_datum;

my $debug=1;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();
my @aus = ('Anzeigen','Ändern','Neu','Löschen');
my @bund = ('NRW','Bayern','Rheinlandpfalz','Hessen');

my $krank_id = $q->param('krank_id') || '0';
my $name = $q->param('name_krankenkasse') || '';
my $tel = $q->param('tel_krankenkasse') || '';
my $strasse = $q->param('strasse_krankenkasse') || '';
my $plz = $q->param('plz_krankenkasse') || '';
my $ort = $q->param('ort_krankenkasse') || '';
my $ik = $q->param('ik_krankenkasse') || '';

my $speichern = $q->param('Speichern');

my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
my $func = $q->param('func') || 0;

hole_krank_daten() if ($func == 1 || $func == 2);
if (($auswahl eq 'Ändern') && defined($abschicken)) {
  aendern();
  $auswahl = 'Anzeigen';
}
if (($auswahl eq 'Neu') && defined($abschicken)) {
  $krank_id = speichern();
  $auswahl = 'Anzeigen';
}

print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>Krankenkassen</title>';
print '<script language="javascript" src="krankenkassen.js"></script>';
print '</head>';

# style-sheet ausgeben
print <<STYLE;
  <style type="text/css">
  .disabled { color:black; background-color:gainsboro}
  .invisible { color:white; background-color:white;border-style:none}
  </style>
STYLE

if (($auswahl eq 'Löschen') && defined($abschicken)) {
  loeschen();
  print '<script>loeschen();</script>';
}

# Alle Felder zur Eingabe ausgeben
print '<body id="krankenkassen_window" bgcolor=white>';
print '<div align="center">';
print '<h1>Krankenkassen</h1>';
print '<hr width="100%">';
print '</div><br>';
# Formular ausgeben
print '<form name="krankenkassen" action="krankenkassenerfassung.pl" method="get" target=_top bgcolor=white>';
print '<table border="0" width="700" align="left">';

# Zeile ID, Name
# z1 s1
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>ID</b></td>';
print '<td>';
print_color('Name:',$name);
print '</td>';
print '<td><b>IK</b></td>';
print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' class=disabled name='krank_id' value='$krank_id' size='6'></td>";
print "<td><input type='text' name='name_krankenkasse' value='$name' size='40'></td>";
print "<td><input type='text' name='ik_krankenkasse' value='$ik' size='14'></td>";
print "<td><input type='button' name='kasse_suchen' value='Suchen' onClick='return kassesuchen(name_krankenkasse,ik_krankenkasse,form);'></tr>";
print '</table>';
print "\n";

# Zeile Telefonnumer
print '<tr><td><b>Tel.:</b></td></tr>';
print "<tr><td><input type='text' name='tel_krankenkasse' value='$tel' size='40'></td></tr>";
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
print '</tr>';

# Eingabe Felder
print "<tr>";
print "<td><input type='text' name='plz_krankenkasse' value='$plz' size='5' onBlur='return plz_check(this)'></td>";
print "<td><input type='text' name='ort_krankenkasse' value='$ort' size='40'></td>";
print "<td><input type='text' name='strasse_krankenkasse' value='$strasse' size='40'></td>";
print '</tr>';
print '</table>';
print "\n";

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td colspan 3>';
print '<table border="0" align="left">';
print '<tr>';
print '<td>';
print "<select name='auswahl' size=1 onChange='auswahl_wechsel(document.krankenkassen)'>";
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
print '<input type="button" name="vorheriger" value="vorheriger Datensatz" onclick="prev_satz(document.krankenkassen)"';
print '</td>';
print '<td>';
print '<input type="button" name="naechster" value="nächster Datensatz" onclick="next_satz(document.krankenkassen)"';
print '</td>';
print '</tr>';
print '</table>';
print '</form>';
print '</tr>';
print '</table>';
print <<SCRIPTE;
<script>
  set_focus(document.krankenkassen);
  auswahl_wechsel(document.krankenkassen);
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

sub speichern {
  # Speichert die Daten in der Krankenkassen Datenbank
  my $erg = $k->krankenkassen_ins($name,$strasse,$plz,$ort,$tel,$ik);
  return $erg;
}

sub loeschen {
  # löscht Datensatz aus der Stammdaten Datenbank
  my $erg = $k->krankenkassen_delete($krank_id);
  return $erg;
}

sub aendern {
  # Ändert die Daten zur angegebenen Krankenkassen in der Datenbank
  my $erg = $k->krankenkassen_update($name,$strasse,$plz,$ort,$tel,$ik,$krank_id);
  return $erg;
}

sub hole_krank_daten {
  $krank_id = $k->max if ($krank_id > $k->max);
  $name='';
  while ($name eq '') {
    ($name,$plz,$ort,$tel,$strasse,$ik)= $k->krankenkassen_krank_id($krank_id);
    if (!defined($name)) {
      if ($krank_id <= 0) {
	$krank_id = 0;
	return;
      }
      $krank_id++ if ($func == 1);
      $krank_id-- if ($func == 2 && $krank_id > 1);
    }
  }
  return;
}
