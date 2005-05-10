#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# author: Thomas Baum
# 04.05.2005
# Rechnungen generieren und drucken

use strict;
use CGI;
use Date::Calc qw(Today);

use lib "../";
use Heb_stammdaten;
use Heb_datum;

my $q = new CGI;
my $s = new Heb_stammdaten;
my $d = new Heb_datum;

my $debug=1;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();

my $frau_id = $q->param('frau_id') || 0;

my $speichern = $q->param('Speichern');

my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
my $func = $q->param('func') || 0;

# zunächst daten der Frau holen
my ($vorname,$nachname,$geb_frau,$geb_kind,$plz,$ort,$tel,$strasse,
    $bundesland,$entfernung_frau,$kv_nummer,$kv_gueltig,$versichertenstatus,
    $ik_krankenkasse,$naechste_hebamme,
    $begruendung_nicht_nae_heb) = $s->stammdaten_frau_id($frau_id);


print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>Rechnungen generieren</title>';
print '<script language="javascript" src="../erfassung/stammdaten.js"></script>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="rechnung.js"></script>';
print '</head>';

# style-sheet ausgeben
print <<STYLE;
  <style type="text/css">
  .disabled { color:black; background-color:gainsboro}
  .invisible { color:white; background-color:white;border-style:none}
  </style>
STYLE

# Alle Felder zur Eingabe ausgeben
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Rechnungsgenerierung</h1>';
print '<hr width="100%">';
print '</div>';
# Formular ausgeben
print '<form name="rechnungen_gen" action="rechnung_generierung.pl" method="get" target=_top bgcolor=white>';
print '<table border="0" width="700" align="left">';

# Zeile mit Frauen Daten 
# z1 s1
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>ID</b></td>';
print '<td><b>Vorname:</b></td>';
print '<td><b>Nachname</b></td>';
print '<td><b>Geb.:</b></td>';
print '<td><b>Geb. Kind:</b></td>';
print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' class='disabled' disabled name='frau_id' value='$frau_id' size='3' onchange='open(\"ps2html?frau_id=\"+frau_id.value,\"rechnung\");'></td>";
$vorname = '' unless (defined($vorname));
$nachname = '' unless (defined($nachname));
$geb_frau = '' unless (defined($geb_frau));
$geb_kind = '' unless (defined($geb_kind));
print "<td><input type='text' class='disabled' disabled name='vorname' value='$vorname' size='40'></td>";
print "<td><input type='text' class='disabled' disabled name='nachname' value='$nachname' size='40'></td>";
print "<td><input type='text' class='disabled' disabled name='geburtsdatum_frau' value='$geb_frau' size='10'></td>";
print "<td><input type='text' class='disabled' disabled name='geburtsdatum_kind' value='$geb_kind' size='10'></td>";
print "<td><input type='button' name='frau_suchen' value='Suchen' onClick='open(\"../erfassung/frauenauswahl.pl\",\"frauenauswahl\",\"scrollbar=yes,innerwidth=700,innerheight=400\");'></td>";
print "</tr>";
print '</table>';

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print "<td><input type='button' name='pdruck' value='entgültig Drucken' onclick='druck_fertig(frau_id.value);'</td>";
print '<td><input type="button" name="hauptmenue" value="Hauptmenue" onClick="haupt();"></td>';
print '<td><input type="button" name="echnungerf" value="Rechnungserfassung" onClick="recherf(frau_id.value);"></td>';
print '</tr>';
print '</table>';

#rint '</table>';
print "\n";
print '</form>';
print '</td>';
print '</tr>';
print '</table>';

print "<iframe src='ps2html.pl?frau_id=$frau_id' name='rechnung' width='860' height='900' scrolling='auto' frameborder='1'>" if ($frau_id > 0);
print "<iframe src='../blank.html' name='rechnung' width='840' height='860' scrolling='yes' frameborder='1'>" if ($frau_id == 0);
print "</iframe>";



print <<SCRIPTE;
<script>
//  auswahl_wechsel(document.rechnungsdaten);
</script>
SCRIPTE
print "</body>";
print "</html>";


