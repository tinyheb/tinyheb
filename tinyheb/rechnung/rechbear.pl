#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# author: Thomas Baum
# 14.05.2005
# Rechnungen bearbeiten

use strict;
use CGI;
use Date::Calc qw(Today);

use lib "../";
use Heb_stammdaten;
use Heb_datum;
use Heb_leistung;

my $q = new CGI;
my $s = new Heb_stammdaten;
my $d = new Heb_datum;
my $l = new Heb_leistung;

my $debug=1;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();

my $speichern = $q->param('Speichern');

my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
my $func = $q->param('func') || 0;

print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>Rechnungen Bearbeiten</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '</head>';

# style-sheet ausgeben
print <<STYLE;
  <style type="text/css">
  .disabled { color:black; background-color:gainsboro}
  .invisible { color:white; background-color:white;border-style:none}
  </style>
STYLE

print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Rechnungsbearbeitung</h1>';
print '<hr width="100%">';
print '</div>';
# Formular ausgeben
print '<form name="rechbear" action="rechbear.pl" method="get" target=_top bgcolor=white>';

# bisher erfasste Rechnungen angezeigen
print '<table style="margin-left: 0" border="0" width=800 align="left">';
print '<tr>';
print '<td style="width:6.6cm;text-align:right">RechNr.</td>';
print '<td style="width:3.9cm;text-align:left">Name Frau</td>';
print '<td style="width:3.0cm;text-align:left">Krankenkasse</td>';
print '<td style="width:1.8cm;text-align:right">Rech. von</td>';
print '<td style="width:1.4cm;text-align:right">Betrag</td>';
print '<td style="width:1.6cm;text-align:right">Mahn.</td>';
print '<td style="width:1.6cm;text-align:right">Eingang</td>';
print '<td style="width:2.0cm;text-align:right">gez. Betrag</td>';
print '<td style="width:0.6cm;text-align:left">Stat</td>';
print "</tr>";
print '</table>';
print "\n";


# die wirklichen Infos kommen aus einem Programm
print "<iframe src='list_rech.pl' name='list_rech' width='840' height='250' scrolling='yes' frameborder='1' align='left'>";
print "</iframe>";
print '</form>';

# Formular für eigentliche Bearbeitung ausgeben
print "<iframe src='rechposbear.pl' name='rechposbear' width='800' height='250' scrolling='auto'
 frameborder='0'>";
print "</iframe>";



print <<SCRIPTE;
<script>
//  auswahl_wechsel(document.rechnungsdaten);
</script>
SCRIPTE
print "</body>";
print "</html>";




