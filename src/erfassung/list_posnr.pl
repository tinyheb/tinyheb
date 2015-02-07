#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf

# erfasste Rechnungsposten ausgeben

# Copyright (C) 2005 - 2010 Thomas Baum <thomas.baum@arcor.de>
# Thomas Baum, 42719 Solingen, Germany

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

use strict;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
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
print '<table rules=rows style="table-layout:fixed" border="1" width="870" align="left">';

# jetzt Rechnungsposten ausgeben
#my $i=0;
$l->leistungsdaten_such($frau_id);
while (my @erg=$l->leistungsdaten_such_next()) {
#  $i++;
  print '<tr>';
  print "<td style='width:43pt;margin-left:0em'>";
  print "<input style='font-size:8pt;padding-right:2pt;padding-left:2pt' type='button' name='aendern' value='Ändern' onclick='aend($frau_id,$erg[0],$erg[11]);'></td>\n";

  print "<td style='width:45pt;padding-left:0pt'><input style='font-size:8pt;padding-right:0pt;padding-left:1pt' type='button' name='loeschen1' value='Löschen' onclick='loe_leistdat($frau_id,$erg[0],$erg[11]);'></td>";
  print "<td style='width:46pt;text-align:right'>$erg[4]</td>"; # datum
  print "<td style='width:22pt;padding-left:5pt;text-align:right'>$erg[1]</td>"; # posnr
  # Aus DB Gebührentext und E. Preis holen
  my($l_bezeichnung,$l_preis,$l_fuerzeit)=$l->leistungsart_such_posnr('KBEZ,EINZELPREIS,FUERZEIT',"$erg[1]",$d->convert($erg[4]));

  (undef,$l_fuerzeit)=$d->fuerzeit_check($l_fuerzeit);

  print "<td style='width:135pt;padding-left:2pt;text-align:left'>$l_bezeichnung</td>";
  $l_preis =~ s/\./,/g;
  print "<td style='width:31pt;text-align:right'>$l_preis</td>"; # e preis
  my $g_preis = sprintf "%.2f",$erg[10];
  $g_preis =~ s/\./,/g;
  print "<td style='width:35pt;text-align:right'>$g_preis</td>"; # g preis
  my ($h1,$m1)= unpack('A2xA2',$erg[5]);

  # prüfen, ob zeiten angezeigt werden müssen
  my ($zeit_von,$zeit_bis) = $l->timetoblank($erg[1],              # posnr
					     $l_fuerzeit,          # fuerzeit
					     $d->convert($erg[4]), # datum
					     $erg[5],              # zeit von
					     $erg[6]);             # zeit bis


  print "<td style='width:25pt;text-align:right'>$zeit_von</td>"; # zeit von
  my ($h2,$m2)= unpack('A2xA2',$erg[6]);
  print "<td style='width:24pt;text-align:right'>$zeit_bis</td>"; # zeit bis

  # Dauer berechnen
  $h1 *=-1;
  $m1 *=-1;
  my ($y,$m,$d,$H,$M,$S) = Add_Delta_DHMS(1900,1,1,$h2,$m2,0,0,$h1,$m1,0);
  my $dauer=sprintf "%2.2u:%2.2u",$H,$M;
  $dauer = '00:00' unless($l_fuerzeit);
  $dauer =~ s/00:00//g;
  print "<td style='width:26pt;text-align:right'>$dauer</td>\n"; # Dauer

  my $beg='';
  $beg='ja' if ($erg[3]);
  print "<td style='width:19pt;text-align:right'>$beg</td>"; # Begründung
  my $tag = sprintf "%.2f",$erg[7];$tag =~ s/\./,/g;$tag =~ s/^0,00//g;
  print "<td style='width:26pt;text-align:right'>$tag</td>"; # Entfernung Tag
  my $nacht = sprintf "%.2f",$erg[8];$nacht =~ s/\./,/g;$nacht =~ s/^0,00//g;
  print "<td style='width:25pt;text-align:right'>$nacht</td>"; # Entfernung Nacht
  $erg[9]='' if (!$tag && !$nacht);
  print "<td style='width:20pt;text-align:center'>$erg[9]</td>"; # Anzahl Frauen

  my $status = $l->status_text($erg[11]);
  print "<td style='width:60;text-align:left;padding-left:5pt'>$status</td>"; # Status der Position
  print "<td></td>";
  print '</tr>';
  print "\n";
}
  print '</table>';
print "\n";
print "<script>window.scrollBy(0,10000);</script>";
print "</body>";
print "</html>";
