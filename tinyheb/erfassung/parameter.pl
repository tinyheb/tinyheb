#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Parameter erfassen, ändern, löschen

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
use Heb_datum;
use Heb;

my $q = new CGI;
my $d = new Heb_datum;
my $h = new Heb;

my $debug=1;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();
my @aus = ('Anzeigen','Ändern','Neu','Löschen');

my $hint='';

my $id =$q->param('id') || 0;
my $id2 =$q->param('id2') || 0;
my $pname = $q->param('pname') || '';
my $pvalue = $q->param('pvalue');
$pvalue = '' unless(defined($pvalue));
my $pbeschreibung = $q->param('pbeschreibung') || '';

my $speichern = $q->param('Speichern');

my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
my $func = $q->param('func') || 0;

hole_parm_daten() if ($func == 1 || $func == 2);
if (($auswahl eq 'Ändern') && defined($abschicken)) {
  aendern();
  $auswahl = 'Anzeigen';
  $id=$id2;
}

if (($auswahl eq 'Neu') && defined($abschicken)) {
  $id=speichern();
  $auswahl = 'Anzeigen';
}

print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>Parameter</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="parameter.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';

if (($auswahl eq 'Löschen') && defined($abschicken)) {
  loeschen();
  if ($hint eq '') {
    print '<script>open("parameter.pl","_top");</script>';
  } else {
    print "<script>alert('$hint');</script>";
    $auswahl='Anzeigen';
  }
}

# Alle Felder zur Eingabe ausgeben
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Parameter</h1>';
print '<hr width="100%">';
print '</div><br>';
# Formular ausgeben
print '<form name="parameter" action="parameter.pl" method="get" target=_top bgcolor=white>';
print '<table border="0" width="700" align="left">';

# Zeile ID, Name
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>ID</b></td>';
print '<td><b>Name</b></td>';
print '</tr>';
print "\n";

# ID noch mal Hidden ausgeben
print "<td><input type='hidden' name='id2' value='$id' size='4'></td>";

print '<tr>';
print "<td><input type='text' disabled class='disabled' name='id' value='$id' size='4'></td>";
print "<td><input type='text' name='pname' value='$pname' size='20'></td>";
print "<td><input type='button' name='parm_suchen' value='Suchen' onClick='parmsuchen(pname,pvalue,pbeschreibung);'></tr>";
print '</table>';
print "\n";

# Wert des Parameters erfassen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><b>Wert</b></td>';
print '</tr>';
print '<tr>';
print "<td><input type='text' name='pvalue' value='$pvalue' size='80'></td>";
print '</tr>';
print '</table>';
print "\n";

# Beschreibung des Parameters erfassen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><b>Beschreibung</b></td>';
print '</tr>';
print '<tr>';
print "<td><input type='text' name='pbeschreibung' value='$pbeschreibung' size='80'></td>";
print '</tr>';
print '</table>';
print "\n";


# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td>';
print "<select name='auswahl' size=1 onChange='auswahl_wechsel(document.parameter)'>";
my $i=0;
while ($i <= $#aus) {
  print "<option value='$aus[$i]'";
  print ' selected' if ($aus[$i] eq $auswahl);
  print '>';
  print $aus[$i];
  print '</option>';
  $i++;
}
print '</select>';
print '</td>';
print '<td>';
print '<input type="button" name="reset" value="Inhalt löschen"';
print ' onClick=window.location="parameter.pl">';
print '</td>';
print '<td>';
print '<input type="submit" name="abschicken" value="Speichern"';
print '</td>';
print '<td>';
print '<input type="button" name="vorheriger" value="vorheriger Datensatz" onclick="prev_satz_parms(document.parameter)"';
print '</td>';
print '<td>';
print '<input type="button" name="naechster" value="nächster Datensatz" onclick="next_satz_parms(document.parameter)"';
print '</td>';
print '<td><input type="button" name="hauptmenue" value="Hauptmenue" onClick="haupt();"></td>';
print '</tr>';
print '</table>';
print '</form>';
print '</tr>';
print '</table>';
print <<SCRIPTE;
<script>
  auswahl_wechsel(document.parameter);
</script>
SCRIPTE
print "</body>";
print "</html>";

sub speichern {
  # Speichert neuen Parameter in der Parms Tabelle
  my $erg = $h->parm_ins($pname,$pvalue,$pbeschreibung);
  return $erg;
}

sub loeschen {
  # löscht Datensatz aus der Parms Tabelle
  if ($id2 == 0) {
    $hint = 'Dieser Datensatz kann nicht gelöscht werden';
    return;
  }
  my $erg = $h->parm_delete($id2);
  return $erg;
}

sub aendern {
  # Ändert Datensatz in der Parms Tabelle 
  my $erg = $h->parm_update($id2,$pname,$pvalue,$pbeschreibung);
  return $erg;
}



sub hole_parm_daten {
  my $id_alt=$id;
  $id = $h->parm_next_id($id) if ($func==1);
  $id = $h->parm_prev_id($id) if ($func==2);
  $id=$id_alt if (!defined($id));
  ($id,$pname,$pvalue,$pbeschreibung)= $h->parm_get_id($id);
  return;

}
