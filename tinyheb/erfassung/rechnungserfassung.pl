#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# globaler Rahmen um Rechnungspositionen zu erfassen

# $Id: rechnungserfassung.pl,v 1.15 2009-11-16 16:47:39 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2005 - 2009 Thomas Baum <thomas.baum@arcor.de>
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
    $begruendung_nicht_nae_heb,$kzetgt) = $s->stammdaten_frau_id($frau_id);
$entfernung = '0.0' unless defined($entfernung);
$entfernung =~ s/\./,/g;


print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>Rechnungsposten erfassen</title>';
#print '<script language="javascript" src="krankenkassen.js"></script>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';

# Alle Felder zur Eingabe ausgeben
print '<body id="rechnung_window" bgcolor=white>';
print '<div align="center">';
print '<h1>Rechnungsposten erfassen</h1>';
print '<hr width="100%">';
print '</div>';
# Formular ausgeben
print '<form name="rechnung" action="rechnungserfassung.pl" method="get" target=_top bgcolor=white>';
print '<table id="oben" border="0" width="700" align="left">';

# Zeile mit Frauen Daten 
# z1 s1
print '<tr><td>';
print '<table id="z1s1" border="0" align="left">';
print '<tr>';
print '<td><b>ID</b></td>';
print '<td><b>Vorname:</b></td>';
print '<td><b>Nachname</b></td>';
print '<td><b>Geb. Frau:</b></td>';
if (!$kzetgt || $kzetgt == 2) {
  print '<td><b>ET Kind:</b></td>';
} else {
  print '<td><b>Geb. Kind:</b></td>';
}
print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' class='disabled' disabled name='frau_id' value='$frau_id' size='3'></td>";
print "<td><input type='text' class='disabled' disabled name='vorname' value='$vorname' size='40'></td>";
print "<td><input type='text' class='disabled' disabled name='nachname' value='$nachname' size='40'></td>";
print "<td><input type='text' class='disabled' disabled name='geburtsdatum_frau' value='$geb_frau' size='10'></td>";
print "<td><input type='text' class='disabled' disabled name='geburtsdatum_kind' value='$geb_kind' size='10'></td>";
print qq!<td><input type='button' name='frau_suchen' value='Suchen' onClick='open("../erfassung/frauenauswahl.pl?suchen=Suchen&sel_status=ungleich erl.","frauenauswahl","scrollbars=yes,width=880,height=400,resizable=yes");'></td>!;
print "</tr>";
print '</table>';
print "</td></tr>\n";
print "\n";
# leere Zeile
print '<tr><td>&nbsp;</td></tr>';

# bisher erfasste Positionen angezeigen
print "<tr><td>\n";
print '<table id="ueberschrift" style="margin-left:0;table-layout:fixed" border="0" width=800 align="left">';
print '<tr>';
print '<td style="width:4.8cm;text-align:right">Datum</td>';
print '<td style="width:1.0cm;text-align:right">Nr.</td>';
print '<td style="width:4.5cm;text-align:left">Gebühren Text</td>';
print '<td style="width:1.3cm;text-align:right">E. Preis</td>';
print '<td style="width:1.2cm;text-align:right">G. Preis</td>';
print '<td style="width:0.8cm;text-align:right">Anf.</td>';
print '<td style="width:0.8cm;text-align:right">Ende</td>';
print '<td style="width:0.8cm;text-align:right">Dauer</td>';
print '<td style="width:0.9cm;text-align:right">Begr.</td>';
print '<td style="width:0.7cm;text-align:right">kmT</td>';
print '<td style="width:0.8cm;text-align:right">kmN</td>';
print '<td style="width:0.7cm;text-align:right">Anz.</td>';
print '<td style="width:1.0cm;text-align:left">Status</td>';
print '<td></td>';
print "</tr>";
print "</table>\n";
print '<br>';
print "</td>\n";
print "</tr>\n";
print "</form>\n";

# die wirklichen Infos kommen aus einem Programm
print "<tr><td>\n";
print "<iframe src='../blank.html' name='list_posnr' width='900' height='250' scrolling='yes' frameborder='1'>";
#print "<iframe src='about:blank' name='list_posnr' width='900' height='250' scrolling='yes' frameborder='1'>";
print "</iframe>";
print "</td>\n";
print "</tr>\n";

# Formular für eigentliche Erfassung ausgeben
print "<tr>\n<td>\n";
print "<iframe src='rechpos.pl?frau_id=$frau_id' name='rechpos' width='800' height='300' scrolling='no' frameborder='0'>";
print "</iframe>";
print "</td>\n";
print "</tr>\n";
print "</table>\n";

print "</body>";
print "</html>";


