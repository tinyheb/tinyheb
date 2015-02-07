#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf

# erfasste Rechnungen ausgeben

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
use Date::Calc qw(Today);

use lib "../";
use Heb_stammdaten;
use Heb_datum;
use Heb_leistung;
use Heb_krankenkassen;

my $q = new CGI;
my $s = new Heb_stammdaten;
my $d = new Heb_datum;
my $l = new Heb_leistung;
my $k = new Heb_krankenkassen;

my $sel_status=$q->param("sel_status") || "ungleich erl.";

my $debug=1;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();

print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>list_rech</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="rechnung.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';

# Alle Felder zur Eingabe ausgeben
print '<table rules=rows style="margin:0em;table-layout:fixed" border="1" width="100%" align="left">';

# jetzt Rechnungsposten ausgeben
$l->rechnung_such("RECHNUNGSNR,DATE_FORMAT(RECH_DATUM,'%d.%m.%Y'),DATE_FORMAT(MAHN_DATUM,'%d.%m.%Y'),DATE_FORMAT(ZAHL_DATUM,'%d.%m.%Y'),BETRAG,STATUS,BETRAGGEZ,FK_STAMMDATEN,IK,EDI_AUFTRAG",);
while (my @erg=$l->rechnung_such_next()) {
  # Rechnung nur Anzeigen, wenn Status ok
  if ($sel_status eq 'alle' or $erg[5]<30) {
    print '<tr>';
    print "<td style='width:50pt;margin-left:0em;margin-right:0em'>";
#    print "<td style='margin-left:0em;margin-right:0em'>";
    print "<input style='font-size:8pt;padding-left:1pt;padding-right:0pt' type='button' name='bearb' value='Bearbeiten' onclick='bearb_rech($erg[0],$erg[5]);'></td>\n";
    print "<td style='width:50pt;padding-left:3pt'><input style='font-size:8pt;padding-left:1pt;padding-right:1pt' type='button' name='anseh' value='Ansehen' onclick='anseh_rech($erg[0],$erg[5]);'></td>\n";

    print "<td style='width:35pt;text-align:right'>$erg[0]</td>"; # Rechnungsnr
#    print "<td style='width:35pt;padding-left:1pt;text-align:right'>$erg[0]</td>"; # Rechnungsnr
    my $aus_ref='';
    $aus_ref=substr($erg[9],19,8) if ($erg[9]);
    print "<td style='width:51pt;text-align:right;'>$aus_ref</td>"; # Datenaustauschreferenz
    # Name Frau holen
    my @erg_frau=$s->stammdaten_frau_id($erg[7]);
    print "<td style='width:100pt;text-align:left;padding:2pt'>$erg_frau[1], $erg_frau[0]</td>"; # Name Frau
#    print "<td style='width:100pt;text-align:left;padding-left:0pt'>$erg_frau[1], $erg_frau[0]</td>"; # Name Frau
    # Name Krankenkasse holen
    my ($name)=$k->krankenkasse_sel("NAME",$erg[8]);
    if (!(defined($name))) {
      $name = 'unbekannt';
      $name='Privat Rechnung' if ($erg_frau[12] eq 'privat');
    }

    print "<td style='width:80pt;text-align:left;padding:2pt'>$name</td>"; # Name Krankenkasse
    print "<td style='width:40pt;text-align:right;padding:2pt'>$erg[1]</td>"; # Datum Rech
    my $g_preis = sprintf "%.2f",$erg[4];$g_preis =~ s/\./,/g;
    print "<td style='width:40pt;text-align:right;padding:2pt'>$g_preis</td>"; # Betrag
    $erg[2] =~ s/00.00.0000/&nbsp;/g;
    print "<td style='width:46pt;text-align:right;padding:2pt'>$erg[2]</td>"; # letzte Mahn
    $erg[3] =~ s/00.00.0000/&nbsp;/g;
    print "<td style='width:46pt;text-align:right;padding:2pt'>$erg[3]</td>"; # Eingang
    my $betraggez = sprintf "%.2f",$erg[6];$betraggez=~ s/\./,/g;
    print "<td style='width:28pt;text-align:right;padding:2pt'>$betraggez</td>"; # Betrag

    my $status = $l->status_text($erg[5]);
    print "<td style='width:45pt;text-align:left;padding:1pt'>$status</td>"; # Status der Position
    print '</tr>';
    print "\n";
  }
}
print '</table>';
print "\n";
print "<script>window.scrollBy(0,10000);</script>";
print "</body>";
print "</html>";
