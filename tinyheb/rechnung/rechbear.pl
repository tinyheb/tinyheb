#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Rechnungen bearbeiten

# $Id: rechbear.pl,v 1.12 2008-10-05 13:48:09 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2005,2006,2007 Thomas Baum <thomas.baum@arcor.de>
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

my $q = new CGI;
our $s = new Heb_stammdaten;
our $d = new Heb_datum;
our $l = new Heb_leistung;

my $debug=1;

our $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();

our $speichern = $q->param('Speichern');

our $auswahl = $q->param('auswahl') || 'Anzeigen';
our $abschicken = $q->param('abschicken');
our $sel_status = $q->param('sel_status') || 'ungleich erl.';
our $func = $q->param('func') || 0;

print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>Rechnungen Bearbeiten</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="rechnung.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';


print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Rechnungsbearbeitung</h1>';
print '<hr width="100%">';
print '</div>';


print '<table border="0" align="left">';
print '<tr><td>';
# Formular ausgeben
print '<form name="rechbear" action="rechbear.pl" method="get" target=_top bgcolor=white>';
print '<table border="0" align="left">';
print '<tr><td style="font-size: 1.2em"><b>Anzeige Einschränken:</b></td>';
print "<td>\n";
print '<select name="sel_status" size="1" onChange="rufe_list_rech();">';
print '<option';
print ' selected' if ($sel_status eq 'alle Rechnungen');
print '>alle</option>';
print '<option';
print ' selected' if ($sel_status eq 'ungleich erl.');
print '>ungleich erl.</option>';
print '</td></tr>';

print '</table>';
print '</td></tr>';
print '</form>';
# bisher erfasste Rechnungen angezeigen
print '<tr><td>';
print '<table style="margin-left:0;table-layout:fixed" border="0" width=930 align="left">';
print '<tr>';
print '<td style="width:145pt;text-align:right">RechNr.</td>';
print '<td style="width:42pt;text-align:center">EDI&nbsp;Ref</td>';
print '<td style="width:96pt;text-align:left;padding:2pt">Name Frau</td>';
print '<td style="width:80pt;text-align:left">Krankenkasse</td>';
print '<td style="width:36pt;text-align:left">Rech.&nbsp;von</td>';
print '<td style="width:46pt;text-align:right">Betrag</td>';
print '<td style="width:40pt;text-align:center">Mahn.</td>';
print '<td style="width:40pt;text-align:center">Eingang</td>';
print '<td style="width:32pt;text-align:right">gez. Betrag</td>';
print '<td style="width:46pt;text-align:left;padding:1pt">Status</td>';

print "</tr>";
print '</table>';
print "\n";
print '</td></tr>';

print '<tr><td>';
# die wirklichen Infos kommen aus einem Programm
print "<iframe src='about:blank' name='list_rech' width='950' height='250' scrolling='yes' frameborder='1' align='left'>";
print "</iframe>";
print '</td></td>';

# Formular für eigentliche Bearbeitung ausgeben
print '<tr><td>';
print "<iframe src='rechposbear.pl?sel_status=$sel_status' name='rechposbear' width='840' height='260' scrolling='auto' frameborder='0'>";
print "</iframe>";
print '</td></tr>';
print '</table>';


print "</body>";
print "</html>";




