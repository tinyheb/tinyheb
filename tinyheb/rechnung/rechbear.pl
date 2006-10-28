#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Rechnungen bearbeiten

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
#print '<script>alert("lade rechbear.pl");</script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';


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
print "<iframe src='../blank.html' name='list_rech' width='840' height='250' scrolling='yes' frameborder='1' align='left'>";
print "</iframe>";
print '</form>';

# Formular für eigentliche Bearbeitung ausgeben
print "<iframe src='rechposbear.pl' name='rechposbear' width='840' height='250' scrolling='auto' frameborder='0'>";
print "</iframe>";



print <<SCRIPTE;
<script>
//  auswahl_wechsel(document.rechnungsdaten);
</script>
SCRIPTE
print "</body>";
print "</html>";




