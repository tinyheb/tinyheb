#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Leistungsarten erfassen, ändern, löschen

# $Id: leistungsarterfassung.pl,v 1.14 2008-05-19 17:54:13 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2005,2006,2007,2008 Thomas Baum <thomas.baum@arcor.de>
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
use Heb_leistung;
use Heb_datum;

my $q = new CGI;
my $d = new Heb_datum;
my $l = new Heb_leistung;

my $debug=1;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();
my $TODAY_tmj = $d->convert_tmj($TODAY);
my @aus = ('Anzeigen','Ändern','Neu','Löschen');

my $hint = '';

my $leist_id = $q->param('leist_id') || '0';
my $posnr = $q->param('posnr') || '';
my $bezeichnung = $q->param('bezeichnung') || '';
my $kbez = $q->param('kbez') || '';
my $leistungstyp = $q->param('leistungstyp') || '';
my $einzelpreis = $q->param('einzelpreis') || '';
my $prozent = $q->param('prozent') || '';
my $sonntag = $q->param('sonntag') || '';
my $nacht = $q->param('nacht') || '';
my $samstag = $q->param('samstag') || '';
my $fuerzeit = $q->param('fuerzeit') || '';
my $dauer = $q->param('dauer') || '';
my $zwillinge = $q->param('zwillinge') || '';
my $zweitesmal = $q->param('zweitesmal') || '';
my $einmalig = $q->param('einmalig') || '';
my $begruendungspflicht = $q->param('begruendungspflicht') || '';
my $zusatz1 = $q->param('zusatz1') || '';
my $zusatz2 = $q->param('zusatz2') || '';
my $zusatz3 = $q->param('zusatz3') || '';
my $zusatz4 = $q->param('zusatz4') || '';
my $nicht = $q->param('nicht') || '';
my $kilometer = $q->param('kilometer') || 'J';
my $pzn = $q->param('pzn') || '';
my $guelt_von = $q->param('guelt_von') || $TODAY_tmj;
my $guelt_bis = $q->param('guelt_bis') || '31.12.9999';
my $speichern = $q->param('Speichern');
my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
my $func = $q->param('func') || 0;


hole_leistart_daten() if ($func == 1 || $func == 2 || $func==3);

print $q->header ( -type => "text/html", -expires => "-1d");

if (($auswahl eq 'Neu') && defined($abschicken)) {
  $leist_id = speichern();
  $auswahl = 'Anzeigen';
}
if (($auswahl eq 'Ändern') && defined($abschicken)) {
  aendern();
  $auswahl = 'Anzeigen';
}
print '<head>';
print '<title>Leistungsarten</title>';
print '<script language="javascript" src="leistungen.js"></script>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';

if (($auswahl eq 'Löschen') && defined($abschicken)) {
  loeschen();
  if ($hint eq '') {
    print '<script>window.location="leistungsarterfassung.pl";</script>';
  } else {
    print "<script>alert('$hint');</script>";
    $auswahl='Anzeigen';
  }
}


# Alle Felder zur Eingabe ausgeben
print '<body id="leistungsarterfassung" bgcolor=white>';
print '<div align="center">';
print '<h1>Leistungsarten</h1>';
print '<hr width="90%">';
print '</div><br>';
# Formular ausgeben
print '<form name="leistungsart" action="leistungsarterfassung.pl" method="get" target=_top bgcolor=white>';
print '<table border="0" width="700" align="left">';

# Zeile ID, POSNR, KBEZ, Bezeichnung
# z1 s1
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>ID</b></td>';
print '<td><b>PosNr</b></td>';
print '<td><b>Leistungstyp</b></td>';
print '<td><b>Kurzbezeichnung</b></td>';
print '</tr>';
print "\n";

# z2 s1
print '<tr>';
print "<td><input type='text' name='leist_id' value='$leist_id' size='5'></td>";
print "<td><input type='text' name='posnr' value='$posnr' size='5'></td>";
print "<td><input type='text' name='leistungstyp' value='$leistungstyp' size='1'></td>";
print "<td><input type='text' name='kbez' value='$kbez' size='50'></td>";
print "<td><input type='button' name='leistart_suchen' value='Suchen' onClick='leistartsuchen(posnr.value);'></tr>";
print '</table>';
print "\n";

# Zeile Bezeichnung
print '<tr><td><b>Bezeichnung:</b></td></tr>';
print '<tr>';
print "<td><textarea class='enabled' name='bezeichnung' rows='2' cols='75'>$bezeichnung</textarea></td>";
print '</tr>';
print "\n";

# Zeile Einzelpreis, Prozent
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><b>Einzelpreis</b></td>';
print '<td><b>Prozentpreis</b></td>';
print '<td><b>Fürzeit</b></td>';
print '<td><b>Dauer</b></td>';
print '</tr>';

# Eingabe Felder
print "<tr>";
print "<td><input type='text' name='einzelpreis' value='$einzelpreis' size='7'></td>";
print "<td><input type='text' name='prozent' value='$prozent' size='6'></td>";
print "<td><input type='text' name='fuerzeit' value='$fuerzeit' size='6'></td>";
print "<td><input type='text' name='dauer' value='$dauer' size='6'></td>";
print '</tr>';
print '</table>';
print "\n";

# Zeile Samstag, Sonntag, Nacht
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr><td><b>Samstag</b></td>';
print '<td><b>Sonntag</b></td>';
print '<td><b>Nacht</b></td>';
print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' name='samstag' value='$samstag' size='6'></td>";
print "<td><input type='text' name='sonntag' value='$sonntag' size='6'></td>";
print "<td><input type='text' name='nacht' value='$nacht' size='6'></td>";
# z4.2 s3
print '<td>';
print '</tr>';
print '</table>';
print "\n";

# zeile Zwillinge, Zweitesmal, Einmalig, Begründungspflicht
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><b>Zwillinge</b></td>';
print '<td><b>Zweitesmal</b></td>';
print '<td><b>Einamlig</b></td>';
print '<td><b>Begründungspflicht</b></td>';
print '</tr>';
print '<tr>';
print "<td><input type='text' name='zwillinge' value='$zwillinge' size='6'></td>";
print "<td><input type='text' name='zweitesmal' value='$zweitesmal' size='6'></td>";
print "<td><input type='text' name='einmalig' value='$einmalig' size='6'></td>";
print "<td><input type='text' name='begruendungspflicht' value='$begruendungspflicht' size='1'></td>";
print '</tr>';
print '</table>';
print "\n";

# Zeile mit Zusatzgebühren
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><b>Zusatzgeb. 1</b></td>';
print '<td><b>Zusatzgeb. 2</b></td>';
print '<td><b>Zusatzgeb. 3</b></td>';
print '<td><b>Zusatzgeb. 4</b></td>';
print '<td><b>nicht mit Positionsnummern</b></td>';

print '</tr>';
print "<td><input type='text' name='zusatz1' value='$zusatz1' size='6'></td>";
print "<td><input type='text' name='zusatz2' value='$zusatz2' size='6'></td>";
print "<td><input type='text' name='zusatz3' value='$zusatz3' size='6'></td>";
print "<td><input type='text' name='zusatz4' value='$zusatz4' size='6'></td>";
print "<td><input type='text' name='nicht' value='$nicht' size='40'></td>";
print '</tr>';
print '</table>';
print "\n";


# Zeile mit Kilometer und Pharmazentralnummer
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><b>Kilometer</b></td>';
print '<td><b>Pharmazentralnummer</b></td>';

print '</tr>';
print "<td><input type='text' name='kilometer' value='$kilometer' size='1' maxlength='1'></td>";
print "<td><input type='text' name='pzn' value='$pzn' size='7' maxlength='7'></td>";
print '</tr>';
print '</table>';
print "\n";

# Zeile mit gültig von, bis
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><b>gültig von</b></td>';
print '<td><b>gültig bis</b></td>';
print '</tr>';
print '<tr>';
print "<td><input type='text' name='guelt_von' value='$guelt_von' size='10' onblur='datum_check(this)'></td>";
print "<td><input type='text' name='guelt_bis' value='$guelt_bis' size='10' onblur='datum_check(this)'></td>";
print '</tr>';
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
print '<td>';
print "<select name='auswahl' size=1 onChange='auswahl_wechsel(document.leistungsart)'>";
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
print ' onClick="loeschen()">';
print '</td>';
print '<td><input type="submit" name="abschicken" value="Speichern"></td>';
print '<td><input type="button" name="vorheriger" value="vorheriger Datensatz" onclick="prev_satz_leistart(document.leistungsart)"></td>';
print '<td><input type="button" name="naechster" value="nächster Datensatz" onclick="next_satz_leistart(document.leistungsart)"></td>';
print '<td><input type="button" name="hauptmenue" value="Hauptmenue" onClick="haupt();"></td>';
print '<td><input type="button" name="wartungsmenue" value="Wartungsmenue" onClick="window.location=\'../wartung.html\';"></td>';
print '</tr>';
print '</table>';
print '</form>';
print '</tr>';
print '</table>';
print "<script>auswahl_wechsel(document.leistungsart);</script>";
print "</body>";
print "</html>";

sub speichern {
  # Speichert die Daten in der Stammdaten Datenbank
  # print "Speichern in DB\n";
  # Datümer konvertierten
  my $leist_id_alt = shift;
 
  my $g_von = $d->convert($guelt_von);
  my $g_bis = $d->convert($guelt_bis);
  $kilometer = 'J' if ($kilometer eq '');
  $kilometer = uc $kilometer;
  my $g_pzn = $pzn;
  $g_pzn=undef if ($pzn eq '');
  if (defined($leist_id_alt)) {
    $leist_id=$l->leistungsart_ins($posnr,$bezeichnung,$leistungstyp,$einzelpreis,$prozent,$sonntag,$nacht,$samstag,$fuerzeit,$dauer,$zwillinge,$zweitesmal,$einmalig,$begruendungspflicht,$zusatz1,$zusatz2,$zusatz3,$zusatz4,$g_von,$g_bis,$kbez,$kilometer,$g_pzn,$nicht,$leist_id_alt);
  } else {
    $leist_id=$l->leistungsart_ins($posnr,$bezeichnung,$leistungstyp,$einzelpreis,$prozent,$sonntag,$nacht,$samstag,$fuerzeit,$dauer,$zwillinge,$zweitesmal,$einmalig,$begruendungspflicht,$zusatz1,$zusatz2,$zusatz3,$zusatz4,$g_von,$g_bis,$kbez,$kilometer,$g_pzn,$nicht);
  }
}

sub loeschen {
  # löscht Datensatz aus der Leistungsarten Datenbank
  $l->leistungsart_delete($leist_id);
  $leist_id=0;
}

sub aendern {
  # Ändert die Daten zu einer Leistungsart in der Datenbank
  return if ($leist_id==0);
  my $leist_id_alt = $leist_id;
  loeschen();
  speichern($leist_id_alt);
}

sub hole_leistart_daten {
  my $leist_id_alt = $leist_id;
  $leist_id = $l->leistungsart_next_id($leist_id) if ($func==1);
  $leist_id = $l->leistungsart_prev_id($leist_id) if ($func==2);
  $leist_id = $leist_id_alt if (!defined($leist_id));
  ($leist_id,$posnr,$bezeichnung,$leistungstyp,$einzelpreis,$prozent,
   $sonntag,$nacht,$samstag,
   $fuerzeit,$dauer,$zwillinge,$zweitesmal,$einmalig,
   $begruendungspflicht,$zusatz1,$zusatz2,$zusatz3,$zusatz4,
   $guelt_von,$guelt_bis,
   $kbez,$kilometer,$pzn,$nicht)= $l->leistungsart_id($leist_id);
  $guelt_von = $d->convert_tmj($guelt_von);
  $guelt_bis = $d->convert_tmj($guelt_bis);
  $samstag = '' unless (defined($samstag));
  $sonntag = '' unless (defined($sonntag));
  $nacht = '' unless (defined($nacht));
  $zusatz1 = '' unless (defined($zusatz1));
  $zusatz2 = '' unless (defined($zusatz2));
  $zusatz3 = '' unless (defined($zusatz3));
  $zusatz4 = '' unless (defined($zusatz4));
  $zwillinge = '' unless (defined($zwillinge));
  $zweitesmal = '' unless (defined($zweitesmal));
  $einmalig = '' unless (defined($einmalig));
  $prozent = '' unless (defined($prozent));
  $begruendungspflicht = '' unless (defined($begruendungspflicht));
  $einzelpreis = '' unless (defined($einzelpreis));
  $kbez =~ s/'/&#145/g;
  $kilometer = 'J' unless($kilometer);
  $nicht = '' unless($nicht);
  $pzn = '' unless($pzn);
}
