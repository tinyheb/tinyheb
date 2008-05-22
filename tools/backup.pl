#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Backup der tinyHeb Datenbank anlegen

# $Id$
# Tag $Name$

# Copyright (C) 2007 Thomas Baum <thomas.baum@arcor.de>
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
use Heb;

my $q = new CGI;
my $h = new Heb;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();

my $umfang = $q->param('umfang') || 'alles';
my $passwort = $q->param('passwort') || '';

my $abschicken = $q->param('abschicken');

print $q->header ( -type => "text/html", -expires => "-1d");

print '<head>';
print '<title>Sichern der Datenbank</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';


# Alle Felder zur Eingabe ausgeben
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Sichern der <i>tinyHeb</i> Datenbank</h1>';
print '<hr width="90%">';
print '</div><br>';
# Formular ausgeben

print '<form name="backup" action="backup_gen.pl" method="get" target=_top bgcolor=white>';
print '<table border="0" width="700" align="left">';

# Zeile Komplette Datenbank oder nur Krankenkassendaten
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>Sicherungsumfang</b></td>';
print '</tr>';
print "\n";

print '<tr>';
print "<td>";
if ($umfang eq 'alles') {
  print "<input type='radio' name='umfang' value='alles' checked>alle Daten";
} else {
  print "<input type='radio' name='umfang' value='alles'>alle Daten";
}
print "</td>";
print "</tr>";
print '<tr>';
print "<td>";
if ($umfang ne 'alles') {
  print "<input type='radio' name='umfang' value='krankenkassen' checked>nur Krankenkassendaten";
} else {
  print "<input type='radio' name='umfang' value='krankenkassen'>nur Krankenkassendaten";
}
print "</td>";
print "</tr>";
print '</table>';
print "\n";



# Root Passwort
print '<tr><td><table border="0" align="left">';
print '<tr><td><b>Passwort des Datenbankadmin</b> (falls benötigt)</td></tr>';
print '</tr>';
print '<tr>';
print "<td><input type='password' name='passwort' value='$passwort' size='15' maxlength='14'></td>";
print "</tr>";
print '</table>';
print "\n";


# leere Zeile
print '<tr><td>&nbsp;</td></tr>';
print "\n";

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';

print '<td><input type="submit" name="abschicken" value="Sicherung anlegen"></td>';
print '<td><input type="button" name="hauptmenue" value="Hauptmenue" onClick="haupt();"></td>';
print '<td><input type="button" name="wartungsmenue" value="Wartungsmenue" onClick="window.location=\'../wartung.html\';"></td>';

print '</tr>';
print '</table>';
print '</form>';

print '</tr>';
print '</table>';

print "</body>";
print "</html>";

