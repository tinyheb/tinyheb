#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# author: Thomas Baum
# 09.04.2005
# Rechnungspositionen erfassen

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
my @aus = ('Anzeigen','Ändern','Neu','Löschen');

my $frau_id = $q->param('frau_id') || 0;
my $posnr = $q->param('posnr') || '';
my $begruendung = $q->param('begruendung') || '';
my $datum = $q->param('datum') || '';
my $zeit_von = $q->param('zeit_von') || '';
my $zeit_bis = $q->param('zeit_bis') || '';
my $entfernung = $q->param('entfernung') || 0;
my $anzahl_frauen = $q->param('anzahl_frauen') || '';

my $speichern = $q->param('Speichern');

my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
my $func = $q->param('func') || 0;

# zunächst daten der Frau holen
my ($vorname,$nachname,$geb_frau,$geb_kind,$plz,$ort,$tel,$strasse,
    $anz_kinder,$entfernung_frau,$kv_nummer,$kv_gueltig,$versichertenstatus,
    $ik_krankenkasse,$naechste_hebamme,
    $begruendung_nicht_nae_heb) = $s->stammdaten_frau_id($frau_id);
$entfernung = '0.0' unless defined($entfernung);
$entfernung =~ s/\./,/g;


print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>Rechnungen</title>';
#print '<script language="javascript" src="krankenkassen.js"></script>';
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
print '<body id="rechnung_window" bgcolor=white>';
print '<div align="center">';
print '<h1>Rechnungserfassung</h1>';
print '<hr width="100%">';
print '</div>';
# Formular ausgeben
print '<form name="rechnung" action="rechnungserfassung.pl" method="get" target=_top bgcolor=white>';
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
print "<td><input type='text' class='disabled' disabled name='frau_id' value='$frau_id' size='3'></td>";
print "<td><input type='text' class='disabled' disabled name='vorname' value='$vorname' size='40'></td>";
print "<td><input type='text' class='disabled' disabled name='nachname' value='$nachname' size='40'></td>";
print "<td><input type='text' class='disabled' disabled name='geburtsdatum_frau' value='$geb_frau' size='10'></td>";
print "<td><input type='text' class='disabled' disabled name='geburtsdatum_kind' value='$geb_kind' size='10'></td>";
print "<td><input type='button' name='frau_suchen' value='Suchen' onClick='open(\"../erfassung/frauenauswahl.pl\",\"frauenauswahl\",\"scrollbars=yes,innerwidth=750,innerheight=400\");'></td>";
print "</tr>";
print '</table>';
print "\n";

# leere Zeile
print '<tr><td>&nbsp;</td></tr>';

# bisher erfasste Positionen angezeigen
print '<tr><td><table style="margin-left: 0" border="0" width=800 align="left">';
print '<tr>';
print '<td style="width:4.3cm;text-align:right">Datum</td>';
print '<td style="width:1.6cm;text-align:center">Nr.</td>';
print '<td style="width:5.0cm;text-align:left">Gebühren Text</td>';
print '<td style="width:1.7cm;text-align:right">E. Preis</td>';
print '<td style="width:1.3cm;text-align:right">G. Preis</td>';
print '<td style="width:0.8cm;text-align:right">Anf.</td>';
print '<td style="width:0.8cm;text-align:right">Ende</td>';
print '<td style="width:0.8cm;text-align:right">Dauer</td>';
print '<td style="width:1.0cm;text-align:right">Begr.</td>';
print '<td style="width:0.8cm;text-align:right">kmT</td>';
print '<td style="width:0.8cm;text-align:right">kmN</td>';
print '<td style="width:0.6cm;text-align:right">Anz.</td>';
print '<td style="width:1.0cm;text-align:right">Stat</td>';
print "</tr>";
print '</table>';
print "\n";
# die wirklichen Infos kommen aus einem Programm
print "<iframe src='../blank.html' name='list_posnr' width='840' height='250' scrolling='yes' frameborder='1'>";
print "</iframe>";

# Formular für eigentliche Erfassung ausgeben
print "<iframe src='rechpos.pl?frau_id=$frau_id' name='rechpos' width='800' height='250' scrolling='auto' frameborder='0'>";
print "</iframe>";

print '</form>';
print '</tr>';
print '</table>';
print <<SCRIPTE;
<script>
//  set_focus(document.krankenkassen);
//  auswahl_wechsel(document.rechnungsdaten);
</script>
SCRIPTE
print "</body>";
print "</html>";


