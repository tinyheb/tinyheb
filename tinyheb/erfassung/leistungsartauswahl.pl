#!/usr/bin/perl -wT
#-w
#-d:ptkdb
#-d:DProf  

# Auswahl von Leistungsarten

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
use Heb_leistung;
use Heb_datum;


my $q = new CGI;
my $l = new Heb_leistung;
my $d = new Heb_datum;

my $TODAY = $d->convert_tmj(sprintf "%4.4u-%2.2u-%2.2u",Today());
my $posnr = $q->param('posnr') || '';
my $guelt = $q->param('guelt') || '';
my $kbez = $q->param('kbez') || '';
my $leistungstyp = $q->param('leistungstyp') || '';

my $suchen = $q->param('suchen');
my $abschicken = $q->param('abschicken');

print $q->header ( -type => "text/html", -expires => "-1d");

# Alle Felder zur Eingabe ausgeben
print '<head>';
print '<title>Leistungsarten suchen</title>';
print '<script language="javascript" src="leistungen.js"></script>';
print '<script language="javascript" src="../Heb.js"></script>';
print '</head>';
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Leistungsarten suchen</h1>';
print '<hr width="100%">';
print '</div><br>';
# Formular ausgeben
print '<form name="leistungsart_suchen" action="leistungsartauswahl.pl" method="get" target=_self>';
print '<h3>Suchkriterien:</h3>';
print '<table border="0" width="500" align="left">';

# Name, Wert, Beschreibung als Suchkriterien vorgeben
# z1 s1
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print "<td><b>Posnr</b></td>\n";
print "<td><b>Kurzbezeichnung</b></td>\n";
print "<td><b>Gültigkeit</b></td>\n";
print "<td><b>Leistungstyp</b></td>\n";

print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' name='posnr' value='$posnr' size='5'></td>";
print "<td><input type='text' name='kbez' value='$kbez' size='30'></td>";
print "<td><input type='text' name='guelt' value='$guelt' size='10' onblur='datum_check(this)'></td>";
print "<td><input type='text' name='leistungstyp' value='$leistungstyp' size='1'></td>";
print '</tr>';
print '</table>';
print "\n";

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><input type="submit" name="suchen" value="Suchen"></td>';
print '<td><input type="button" name="zurueck" value="Zurück" onClick="self.close()"></td>';
print '</tr>';
print '</table>';

# Prüfen, ob gesucht werden soll
if (defined($suchen)) {
  # alle Leistungsarten ausgeben, die den Kriterien entsprechen
  print '<tr>';
  print '<td>';
  print '<table border="1" align="left">';
  print '<tr>';
  print "<td><b>Posnr</b></td>\n";
  print "<td><b>Leistungstyp</b></td>\n";
  print "<td><b>Kurzbezeichnung</b></td>\n";
  print "<td><b>Gültig von</b></td>\n";
  print "<td><b>Gültig bis</b></td>\n";

  print '</tr>';
  $kbez = $kbez.'%';
  $leistungstyp = $leistungstyp.'%';

  $l->leistungsart_such_werte($posnr,$leistungstyp,$kbez,$guelt);
  while (my ($l_leistid,$l_posnr,$l_leistungstyp,$l_kbez,$l_guelt_von,$l_guelt_bis) = $l->leistungsart_such_werte_next) {
    print '<tr>';
    print "<td>$l_posnr</td>";
    print "<td>$l_leistungstyp</td>";
    print "<td>$l_kbez</td>";
    print "<td>$l_guelt_von</td>";
    print "<td>$l_guelt_bis</td>";
    print '<td><input type="button" name="waehlen" value="Auswählen"';
    print "onclick=\"l_eintrag('$l_leistid');self.close()\"></td>";
    print "</tr>\n";
  }
}
print '</form>';
print '</tr>';
print '</table>';

print <<SCRIPTE;
<script>
  function l_eintrag(id) {
    // in Parent Dokument übernehmen
    var formular=opener.window.name;
    opener.window.location="leistungsarterfassung.pl?func=3&leist_id="+id;
    self.close();
  }
</script>
SCRIPTE
print "</body>";
print "</html>";
