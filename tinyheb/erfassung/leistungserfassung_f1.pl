#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

sub BEGIN {
  $ENV{DISPLAY} = "schloesser:0.0";
}

# author: Thomas Baum
# 27.03.2004
# Leistungen erfassen

use strict;
use CGI;
use Date::Calc qw(Today);

use lib "../";
use Heb_stammdaten;
use Heb_datum;
#use Heb_leistungen;

my $q = new CGI;
my $k = new Heb_stammdaten;
my $d = new Heb_datum;

my $debug=1;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();
my @aus = ('Anzeigen','Ändern','Neu','Löschen');


my $leistung_id = $q->param('leistung_id') || '0';
my $posnr = $q->param('posnr') || '';
my $vorname = $q->param('vorname_frau') || '';
my $nachname = $q->param('nachname_frau') || '';
my $frau_id = $q->param('frau_id') || '0';
my $geb_frau = $q->param('geburtsdatum_fau') || '';
my $datum_leistung = $q->param('datum_leistung') || '';
my $uhrzeit_leistung = $q->param('uhrzeit_leistung') || '';
my $dauer_leistung = $q->param('dauer_leistung') || '';
#my $fk_stammdaten = $q->param('fk_stammdaten') || '';
#my $fk_leistungsart = $q->param('fk_leistungsart') || '';

my $speichern = $q->param('Speichern');

my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
my $func = $q->param('func') || 0;

print $q->header ( -type => "text/html", -expires => "-1d");

print '<head>';
print '<title>Leistungserfassung</title>';
print '<script language="javascript" src="leistungen.js"></script>';
print '<script language="javascript" src="stammdaten.js"></script>';
print '<script language="javascript" src="../Heb.js"></script>';
print '</head>';

# style-sheet ausgeben
print <<STYLE;
  <style type="text/css">
  .disabled { color:black; background-color:gainsboro}
  .invisible { color:white; background-color:white;border-style:none}
  </style>
STYLE

# Alle Felder zur Eingabe ausgeben
print '<body id="leistungen_window" bgcolor=white>';
print '<center>';
print '<h1>Leistungen</h1>';
print '<hr width="100%">';
print '</center>';
# Formular ausgeben
print '<form name="leistungen_f1" action="leistungserfassung_f1.pl" method="get" target=_top bgcolor=white onSubmit="return false">';
print '<table border="0" width="100%" align="left">';

# Zeile Vorname, Nachname, Geburtsdatum
print '<tr><td><table border="0">';
print '<tr>';
print '<td><b>ID</b>';
print '<td>';print_color('Vorname:',$vorname);print '</td>';
print '<td>';print_color('Nachname:',$nachname);print '</td>';
print '<td>';print_color('Geb.:',$geb_frau);print '</td>';
print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' class=disabled name='frau_id' value='$frau_id' size='5'></td>\n";
print "<td><input type='text' name='vorname' value='$vorname' size='40'></td>";
print "<td><input type='text' name='nachname' value='$nachname' size='40'></td>";
print "<td><input type='text' name='geburtsdatum_frau' value='$geb_frau' size='10' onBlur='datum_check(this)'></td>";
print "<td><input type='button' name='frau_suchen' value='Suchen' onClick='return frausuchen(vorname,nachname,geburtsdatum_frau,form);'></tr>";
print '</table>';
print "\n";

# Zeile Datum, Uhrzeit
print '<tr><td><table border="0">';
print '<tr>';
print '<td><b>Datum</b></td>';
print '<td><b>Uhrzeit</b></td>';
print '<td><b>Dauer</b></td>';
print '</tr>';
print '<tr>';
print "<td><input type='text' name='datum_leistung' value='$datum_leistung' size='12' onBlur='return datum_check(this)'></td>";
print "<td><input type='text' name='uhrzeit_leistung' value='$uhrzeit_leistung' size='5' onBlur='return uhrzeit_check(this)'></td>";
print "<td><input type='text' name='dauer_leistung' value='$dauer_leistung' size='5' onBlur='return uhrzeit_check(this)'></td>";
print "<td><input type='button' name='leistungen_bearbeiten' value='Leistungen Bearbeiten' onClick='return leistungenbearbeiten(form);'></tr>";
print "</tr>\n";
print "</table>\n";

print <<SCRIPTE;
<script>
  set_focus(document.leistungen_f1);
</script>
SCRIPTE
print "</body>";
print "</html>";

sub print_color {
  my ($bezeichnung,$variable) = @_;
  
  print '<font color=red>' if ($variable eq '');
  print "<b>$bezeichnung</b>";
  print '<font color=black>';
}

