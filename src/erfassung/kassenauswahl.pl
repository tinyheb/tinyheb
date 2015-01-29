#!/usr/bin/perl -wT
#-w
#-d:ptkdb
#-d:DProf  

# Auswahl einer Krankenkasse

# $Id: kassenauswahl.pl,v 1.15 2008-05-19 17:49:29 thomas_baum Exp $
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
use Heb_krankenkassen;

my $q = new CGI;
my $k = new Heb_krankenkassen;

my $debug=1;

my $name = $q->param('name') || '';
my $kname = $q->param('kname') || '';
my $ort = $q->param('ort') || '';
my $plz_haus = $q->param('plz_haus') || '';
my $plz_post = $q->param('plz_post') || '';
my $ik = $q->param('ik') || '';
my $fk_krankenkasse = -1;

my $suchen = $q->param('suchen');
my $abschicken = $q->param('abschicken');

print $q->header ( -type => "text/html", -expires => "-1d");

# Alle Felder zur Eingabe ausgeben
print '<head>';
print '<title>Krankenkasse suchen</title>';
print '<script language="javascript" src="krankenkassen.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Krankenkasse suchen</h1>';
print '<hr width="100%">';
print '</div><br>';
# Formular ausgeben
print '<form name="kasse_suchen" action="kassenauswahl.pl" method="get" target=_self>';
print '<h3>Suchkriterien:</h3>';
print '<table border="0" width="500" align="left">';

# Name, Ort, PLZ, IK, als Suchkriterien vorgeben
# z1 s1
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print "<td><b>IK</b></td>\n";
print "<td><b>Name</b></td>\n";
print "<td><b>KName</b></td>\n";
print "<td><b>Ort</b></td>\n";
print "<td><b>PLZ Hausanschrift</b></td>\n";
print "<td><b>PLZ Postfach</b></td>\n";
print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' name='ik' value='$ik' size='10'></td>";
print "<td><input type='text' name='name' value='$name' size='20'></td>";
print "<td><input type='text' name='kname' value='$kname' size='20'></td>";
print "<td><input type='text' name='ort' value='$ort' size='20'></td>";
print "<td><input type='text' name='plz_haus' value='$plz_haus' size='7'></td>";
print "<td><input type='text' name='plz_post' value='$plz_post' size='7'></td>";
print '</table>';
print "\n";

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><input type="submit" name="suchen" value="Suchen"></td>';
print '<td>';
print '<input type="button" name="zurueck" value="Zurück" onClick="self.close()"></td>';
print '</tr>';
print '</table>';

print "<script>window.focus();</script>";


# Prüfen, ob gesucht werden soll
if (defined($suchen)) {
  # alle Kassen ausgeben, die den Kriterien entsprechen
  print '<tr>';
  print '<td>';
  print '<table border="1" align="left">';
  print '<tr>';
  print "<td><b>IK</b></td>\n";
  print "<td><b>Name</b></td>\n";
  print "<td><b>KName</b></td>\n";
  print "<td><b>PLZ Hausanschrift</b></td>\n";
  print "<td><b>PLZ Postfach</b></td>\n";
  print "<td><b>Ort</b></td>\n";
  print "<td><b>Strasse</b></td>\n";
  print '</tr>';
  $name = '%'.$name.'%';
  $kname = '%'.$kname.'%';
  $plz_haus = $plz_haus.'%';
  $plz_post = $plz_post.'%';
  $ort = '%'.$ort.'%';
  $ik = '%'.$ik.'%';
  $k->krankenkasse_such($name,$kname,$plz_haus,$plz_post,$ort,$ik);
  while (my ($k_ik,$k_kname,$k_name,$k_strasse,$k_plz_haus,$k_plz_post,$k_ort,$k_postfach,$k_asp_name,$k_asp_tel,$k_zik,$k_bemerkung) = $k->krankenkasse_such_next) {
    print '<tr>';
    print "<td>$k_ik</td>";
    print "<td>$k_name</td>";
    print "<td>$k_kname</td>";
    print "<td>$k_plz_haus</td>";
    print "<td>$k_plz_post</td>";
    print "<td>$k_ort</td>";
    print "<td>$k_strasse</td>";

    my $status_edi='kein elektronischer Datenaustausch';
    my $test_ind= $k->krankenkasse_test_ind($k_ik);
    if (defined($test_ind)) {
      $status_edi='Testphase' if ($test_ind == 0);
      $status_edi='Erprobungsphase' if ($test_ind == 1);
      $status_edi='Echtbetrieb' if ($test_ind == 2);
      $status_edi='unbekannt, Bitte Parameter prüfen' if ($test_ind != 0 && $test_ind != 1 && $test_ind != 2);
    }

#    print "<td>$k_postfach,$k_asp_name,$k_asp_tel,$k_zik,$k_bemerkung</td>";
    print '<td><input type="button" name="waehlen" value="Auswählen"';
    print "\n";
    $k_bemerkung = ' ' if($k_bemerkung eq '');
    $k_kname =~ s/'/\\'/g;
    $k_name =~ s/'/\\'/g;
    print "onclick=\"kk_eintrag('$k_ik','$k_kname','$k_name','$k_plz_haus','$k_plz_post','$k_ort','$k_strasse','$status_edi');self.close();\"></td>";
    print "</tr>\n";
  }
}
print '</form>';
print '</tr>';
print '</table>';

print "</body>";
print "</html>";
