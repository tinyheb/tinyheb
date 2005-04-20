#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# author: Thomas Baum
# 09.04.2005
# erfasste Rechnungsposten ausgeben

use strict;
use CGI;
use Date::Calc qw(Today Add_Delta_DHMS);

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

my $frau_id = $q->param('frau_id') || 1;

print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>list_posnr</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="leistungen.js"></script>';
print '</head>';

# style-sheet ausgeben
print <<STYLE;
  <style type="text/css">
  .disabled { color:black; background-color:gainsboro}
  .invisible { color:white; background-color:white;border-style:none}
  </style>
STYLE



# Alle Felder zur Eingabe ausgeben 
print '<table style="margin-left:0" border="1" width="100%" align="left">';

# jetzt Rechnungsposten ausgeben
$l->leistungsdaten_such($frau_id);
while (my @erg=$l->leistungsdaten_such_next()) {
  print '<tr>';
  print "<td style='width:1cm;margin-left:0em'>";
  print "<input style='padding:0;margin:0;font-size:8pt' type='button' name='aendern1' value='Ändern' onclick='aend($frau_id,$erg[0]);'></td>\n";
  print "<td style='width:1cm'><input style='padding:0;margin:0;font-size:8pt' type='button' name='loeschen1' value='Löschen' onclick='loe_leistdat($frau_id,$erg[0]);'></td>";
  print "<td style='width:1.3cm;text-align:left'>$erg[4]</td>"; # datum
  print "<td style='width:0.4cm;text-align:center'>$erg[1]</td>"; # posnr
  # Aus DB Gebührentext und E. Preis holen
  my($l_bezeichnung,$l_preis)=$l->leistungsart_such_posnr('BEZEICHNUNG,EINZELPREIS',$erg[1],$d->convert($erg[4]));
  print "<td style='width:7cm;text-align:left'>$l_bezeichnung</td>";
  print "<td style='width:1.3cm;text-align:right'>$l_preis</td>"; # e preis
  print "<td style='width:1.3cm;text-align:right'>$erg[11]</td>"; # g preis
  print "<td style='width:2cm;text-align:right'>$erg[10]</td>"; # Anzahl Frauen
  my ($h1,$m1)= unpack('A2xA2',$erg[5]);
  print "<td style='width:1cm;text-align:right'>$erg[5]</td>"; # zeit von
  my ($h2,$m2)= unpack('A2xA2',$erg[6]);
  print "<td style='width:1cm;text-align:right'>$erg[6]</td>"; # zeit bis
  # Dauer berechnen
  $h1 *=-1;
  $m1 *=-1;
  my ($y,$m,$d,$H,$M,$S) = Add_Delta_DHMS(1900,1,1,$h2,$m2,0,0,$h1,$m1,0);
  my $dauer=sprintf "%2.2u:%2.2u",$H,$M;
  print "<td>$dauer</td>\n";
  print "<td>$erg[7]</td>";
  print "<td>$erg[8]</td>";
  print '</tr>';
  print "\n";
}
  print '</table>';
print "\n";
print "</body>";
print "</html>";


