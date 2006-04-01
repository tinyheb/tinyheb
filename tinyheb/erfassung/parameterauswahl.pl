#!/usr/bin/perl -wT
#-w
#-d:ptkdb
#-d:DProf  

# Auswahl von Parametern

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
use Heb;


my $q = new CGI;
my $h = new Heb;

my $pname = $q->param('pname') || '';
my $pvalue = $q->param('pvalue') || '';
my $pbeschreibung = $q->param('pbeschreibung') || '';

my $suchen = $q->param('suchen');
my $abschicken = $q->param('abschicken');

print $q->header ( -type => "text/html", -expires => "-1d");

# Alle Felder zur Eingabe ausgeben
print '<head>';
print '<title>Parameter suchen</title>';
print '</head>';
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Parameter suchen</h1>';
print '<hr width="100%">';
print '</div><br>';
# Formular ausgeben
print '<form name="parameter_suchen" action="parameterauswahl.pl" method="get" target=_self>';
print '<h3>Suchkriterien:</h3>';
print '<table border="0" width="500" align="left">';

# Name, Wert, Beschreibung als Suchkriterien vorgeben
# z1 s1
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print "<td><b>Name</b></td>\n";
print "<td><b>Beschreibung</b></td>\n";
print "<td><b>Wert</b></td>\n";

print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' name='pname' value='$pname' size='20'></td>";
print "<td><input type='text' name='pbeschreibung' value='$pbeschreibung' size='30'></td>";
print "<td><input type='text' name='pvalue' value='$pvalue' size='20'></td>";

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
  print "<td><b>Beschreibung</b></td>\n";
  print "<td><b>Wert</b></td>\n";

  print '</tr>';
  $pname = '%'.$pname.'%';
  $pbeschreibung = $pbeschreibung.'%';
  $pvalue = '%'.$pvalue.'%';

  $h->parm_such_werte($pname,$pvalue,$pbeschreibung);
  while (my ($id,$p_name,$p_wert,$p_beschreibung) = $h->parm_such_werte_next) {
    print '<tr>';
    print "<td>$p_name</td>";
    print "<td>$p_beschreibung</td>";
    $p_wert =~ s/</&lt;/g;
    $p_wert =~ s/>/&gt;/g;
    print "<td>$p_wert</td>";
    print '<td><input type="button" name="waehlen" value="Auswählen"';
    print "onclick=\"p_eintrag('$id','$p_name','$p_wert','$p_beschreibung');self.close()\"></td>";
    print "</tr>\n";
  }
}
print '</form>';
print '</tr>';
print '</table>';

print <<SCRIPTE;
<script>

window.focus();

  function p_eintrag(parm_id,name,wert,beschreibung) {
    // in Parent Dokument übernehmen
    var formular=opener.window.document.forms[0];
    formular.id.value=parm_id;
    formular.id2.value=parm_id;
    formular.pname.value=name;
    formular.pvalue.value=wert;
    formular.pbeschreibung.value=beschreibung;
  }
</script>
SCRIPTE
print "</body>";
print "</html>";
