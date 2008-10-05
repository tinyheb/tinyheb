#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Feiertag erfassen, ändern, löschen

# $Id: feiertagserfassung.pl,v 1.13 2008-10-05 13:18:30 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2004,2005,2006,2007 Thomas Baum <thomas.baum@arcor.de>
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
use Heb_datum;

my $q = new CGI;
our $d = new Heb_datum;

my $debug=1;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();
my @aus = ('Anzeigen','Ändern','Neu','Löschen');
my @bund = ('Bundesweit',$d->bundeslaender);

our $feiertag_id = $q->param('id_feiertag') || '0';
our $name = $q->param('name_feiertag') || '';
our $bundesland = $q->param('bund_feiertag') || '';
our $datum = $q->param('datum_feiertag') || '';

my $speichern = $q->param('Speichern');

my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
our $func = $q->param('func') || 0;

hole_feiertag_daten() if ($func == 1 || $func == 2);
if (($auswahl eq 'Ändern') && defined($abschicken)) {
  aendern();
  $auswahl = 'Anzeigen';
}
if (($auswahl eq 'Neu') && defined($abschicken)) {
  $feiertag_id = speichern();
  $auswahl = 'Anzeigen';
}

print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>Feiertage</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="feiertage.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';

if (($auswahl eq 'Löschen') && defined($abschicken)) {
  loeschen();
  print '<script>loeschen();</script>';
}

# Alle Felder zur Eingabe ausgeben
print '<body id="feiertage_window" bgcolor=white>';
print '<div align="center">';
print '<h1>Feiertage</h1>';
print '<hr width="100%">';
print '</div><br>';
# Formular ausgeben
print '<form name="feiertage" action="feiertagserfassung.pl" method="get" target=_top onsubmit="return feiertag_speicher(this);" bgcolor=white>';
print '<table border="0" width="700" align="left">';

# Zeile ID, Name
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>ID</b></td>';
print '<td><b>Name</b></td>';
print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' class=disabled name='id_feiertag' value='$feiertag_id' size='6'></td>";
print "<td><input type='text' name='name_feiertag' value='$name' size='40'></td>";
print "<td><input type='button' name='feiertag_suchen' value='Suchen' onClick='return feiertagsuchen(name_feiertag,bund_feiertag,form);'></tr>";
print '</table>';
print "\n";

# Bundesland erfassen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><b>Bundesland</b></td>';
print '<tr>';
print '<td>';
print "<select name='bund_feiertag' size=1>";
my $j=0;
while ($j <= $#bund) {
  print '<option';
  print ' selected' if ($bund[$j] eq $bundesland);
  print '>';
  print $bund[$j];
  print '</option>';
  $j++;
}
print '</td>';
print '</tr>';
print '</table>';
print "\n";

# Datum des Feiertages erfassen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><b>Datum</b></td>';
print '</tr>';
print '<tr>';
print "<td><input type='text' name='datum_feiertag' value='$datum' size='10' onChange='datum_check(this);'></td>";
print '</tr>';
print '</table>';
print "\n";

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td>';
print "<select name='auswahl' size=1 onChange='auswahl_wechsel(document.feiertage)'>";
my $i=0;
while ($i <= $#aus) {
  print '<option';
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
print ' onClick="loeschen()">';
print '</td>';
print '<td>';
print '<input type="submit" name="abschicken" value="Speichern"';
print '</td>';
print '<td>';
print '<input type="button" name="vorheriger" value="vorheriger Datensatz" onclick="prev_satz(document.feiertage)"';
print '</td>';
print '<td>';
print '<input type="button" name="naechster" value="nächster Datensatz" onclick="next_satz(document.feiertage)"';
print '</td>';
print '<td><input type="button" name="hauptmenue" value="Hauptmenue" onClick="haupt();"></td>';
print '</tr>';
print '</table>';
print '</form>';
print '</tr>';
print '</table>';
print "<script>set_focus(document.feiertage);auswahl_wechsel(document.feiertage);</script>";
print "</body>";
print "</html>";



sub speichern {
  # Speichert die Daten in der Krankenkassen Datenbank
  my $f_datum = $d->convert($datum);
  my $erg = $d->feiertag_ins($name,$bundesland,$f_datum);
  return $erg;
}

sub loeschen {
  # löscht Datensatz aus der Stammdaten Datenbank
  my $erg = $d->feiertag_delete($feiertag_id);
  return $erg;
}

sub aendern {
  # Ändert die Daten zur angegebenen Krankenkassen in der Datenbank
  my $f_datum = $d->convert($datum);
  my $erg = $d->feiertag_update($name,$bundesland,$f_datum,$feiertag_id);
  return $erg;
}



sub hole_feiertag_daten {
  
  $feiertag_id = $d->feiertag_next_id($feiertag_id) if ($func==1);
  $feiertag_id = $d->feiertag_prev_id($feiertag_id) if ($func==2);
  ($name,$bundesland,$datum)= $d->feiertag_feier_id($feiertag_id);
  $name = '' unless ($name);
  $bundesland = '' unless($bundesland);
  $datum = '' unless($datum);
  return;
}
