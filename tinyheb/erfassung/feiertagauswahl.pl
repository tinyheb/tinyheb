#!/usr/bin/perl -w
#-w
#-d:ptkdb
#-d:DProf  

# Bearbeitung von Feiertagen

# Copyright (C) 2004,2005,2006 Thomas Baum <thomas.baum@arcor.de>
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
use Heb_datum;

my $q = new CGI;
my $d = new Heb_datum;

my $debug=1;

my $name = $q->param('name_feiertag') || '';
my $bundesland = $q->param('bund_feiertag') || '';
my $datum = $q->param('datum_feiertag') || '';

my $suchen = $q->param('suchen');
my $abschicken = $q->param('abschicken');

print $q->header ( -type => "text/html", -expires => "-1d");

# Alle Felder zur Eingabe ausgeben
print '<head>';
print '<title>Feiertag suchen</title>';
print '</head>';
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Feiertag suchen</h1>';
print '<hr width="100%">';
print '</div><br>';
# Formular ausgeben
print '<form name="feiertag_suchen" action="feiertagauswahl.pl" method="get" target=_self>';
print '<h3>Suchkriterien:</h3>';
print '<table border="0" width="500" align="left">';

# Name, Ort, PLZ, IK, als Suchkriterien vorgeben
# z1 s1
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print "<td><b>Name</b></td>\n";
print "<td><b>Bundesland</b></td>\n";
print "<td><b>Datum</b></td>\n";
print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' name='name_feiertag' value='$name' size='20'></td>";
print "<td><input type='text' name='bund_feiertag' value='$bundesland' size='20'></td>";
print "<td><input type='text' name='datum_feiertag' value='$datum' size='10'></td>";
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
  # alle Feiertage ausgeben, die den Kriterien entsprechen
  print '<tr>';
  print '<td>';
  print '<table border="1" align="left">';
  print '<tr>';
  print "<td><b>Name</b></td>\n";
  print "<td><b>Bundesland</b></td>\n";
  print "<td><b>Datum</b></td>\n";
  print '</tr>';
  $name = '%'.$name.'%';
  $bundesland = $bundesland.'%';
  my $such_datum='';
  $such_datum = $d->convert($datum) if ($datum ne '');
  $such_datum = '%'.$such_datum.'%';
  $d->feiertag_such($name,$bundesland,$such_datum);
  while (my ($id,$f_name,$f_bundesland,$f_datum) = $d->feiertag_such_next) {
    print '<tr>';
    print "<td>$f_name</td>";
    print "<td>$f_bundesland</td>";
    print "<td>$f_datum</td>";
    print '<td><input type="button" name="waehlen" value="Auswählen"';
    print "onclick=\"f_eintrag('$id','$f_name','$f_bundesland','$f_datum');self.close()\"></td>";
    print "</tr>\n";
  }
}
print '</form>';
print '</tr>';
print '</table>';

print <<SCRIPTE;
<script>
  function f_eintrag(feiertag_id,name,bundesland,datum) {
    // in Parent Dokument übernehmen
    var formular=opener.window.document.forms[0];
    formular.id_feiertag.value=feiertag_id;
    formular.name_feiertag.value=name;
    //formular.bund_feiertag.value=bundesland;
    formular.datum_feiertag.value=datum;
    for (i=0;i<formular.bund_feiertag.options.length;i++) {
       if (formular.bund_feiertag.options[i].text == bundesland) {
         formular.bund_feiertag.selectedIndex=i;
       }
    }
  }
window.focus();
</script>
SCRIPTE
print "</body>'";
print "</html>";
