#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# erfasste Rechnungsposten ausgeben

# Copyright (C) 2005,2006 Thomas Baum <thomas.baum@arcor.de>
# Thomas Baum, Rubensstr. 3, 42719 Solingen, Germany

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

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

my $frau_id = $q->param('frau_id') || 0;

print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>list_posnr</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="leistungen.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';


# Alle Felder zur Eingabe ausgeben 
print '<table rules=rows style="margin-left:0" border="2" width="100%" align="left">';

# jetzt Rechnungsposten ausgeben
my $i=0;
$l->leistungsdaten_such($frau_id);
while (my @erg=$l->leistungsdaten_such_next()) {
  $i++;
  print '<tr>';
  print "<td style='width:1cm;margin-left:0em'>";
  print "<input style='font-size:8pt' type='button' name='aendern$i' value='Ändern' onclick='aend($frau_id,$erg[0],$erg[11]);'></td>\n";

  print "<td style='width:1cm'><input style='padding:0;margin:0;font-size:8pt' type='button' name='loeschen1' value='Löschen' onclick='loe_leistdat($frau_id,$erg[0],$erg[11]);'></td>";
  print "<td style='width:1.3cm;text-align:left'>$erg[4]</td>"; # datum
  print "<td style='width:0.4cm;text-align:center'>$erg[1]</td>"; # posnr
  # Aus DB Gebührentext und E. Preis holen
  my($l_bezeichnung,$l_preis)=$l->leistungsart_such_posnr('KBEZ,EINZELPREIS',$erg[1],$d->convert($erg[4]));
  print "<td style='width:5.0cm;text-align:left'>$l_bezeichnung</td>";
  $l_preis =~ s/\./,/g;
  print "<td style='width:1.0cm;text-align:right'>$l_preis</td>"; # e preis
  my $g_preis = sprintf "%.2f",$erg[10];
  $g_preis =~ s/\./,/g;
  print "<td style='width:1.0cm;text-align:right'>$g_preis</td>"; # g preis
  my ($h1,$m1)= unpack('A2xA2',$erg[5]);
  $erg[5] =~ s/00:00//g if($erg[6] eq '00:00'); 
  print "<td style='width:1cm;text-align:right'>$erg[5]</td>"; # zeit von
  my ($h2,$m2)= unpack('A2xA2',$erg[6]);
  $erg[6] =~ s/00:00//g;
  print "<td style='width:0.8cm;text-align:right'>$erg[6]</td>"; # zeit bis
  # Dauer berechnen
  $h1 *=-1;
  $m1 *=-1;
  my ($y,$m,$d,$H,$M,$S) = Add_Delta_DHMS(1900,1,1,$h2,$m2,0,0,$h1,$m1,0);
  my $dauer=sprintf "%2.2u:%2.2u",$H,$M;
  $dauer =~ s/00:00//g;
  print "<td style='width:0.8cm;text-align:right'>$dauer</td>\n"; # Dauer
  my $beg='';
  $beg='ja' if (defined($erg[3]) && $erg[3] ne '');
  print "<td style='width:0.7cm;text-align:center'>$beg</td>"; # Begründung
  my $tag = sprintf "%.2f",$erg[7];$tag =~ s/\./,/g;$tag =~ s/^0,00//g;
  print "<td style='width:0.8cm;text-align:right'>$tag</td>"; # Entfernung Tag
  my $nacht = sprintf "%.2f",$erg[8];$nacht =~ s/\./,/g;$nacht =~ s/^0,00//g;
  print "<td style='width:0.8cm;text-align:right'>$nacht</td>"; # Entfernung Nacht
  $erg[9]='' if ($tag eq '' && $nacht eq '');
  print "<td style='width:0.5cm;text-align:right'>$erg[9]</td>"; # Anzahl Frauen

  my $status = $l->status_text($erg[11]);
  print "<td style='width:1.5cm;text-align:right'>$status</td>"; # Status der Position
  print '</tr>';
  print "\n";
}
  print '</table>';
print "\n";
print "<script>window.scrollByLines(1000);</script>";
print "</body>";
print "</html>";


