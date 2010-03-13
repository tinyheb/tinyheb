#!/usr/bin/perl -wT
#-w
#-d:ptkdb
#-d:DProf  


# Auswahl einer Frau aus den Stammdaten

# $Id: frauenauswahl.pl,v 1.19 2010-03-13 13:31:31 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2004 - 2010 Thomas Baum <thomas.baum@arcor.de>
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

use lib "../";
use Heb_stammdaten;
use Heb_datum;
use Heb_krankenkassen;
use Heb_leistung;

my $q = new CGI;
my $s = new Heb_stammdaten;
my $d = new Heb_datum;
my $k = new Heb_krankenkassen;
my $l = new Heb_leistung;

my $debug=1;

my $vorname = $q->param('vorname') || '';
my $nachname = $q->param('nachname') || '';
my $geb_f = $q->param('geb_f') || '';
my $geb_k = $q->param('geb_k') || '';
my $ort = $q->param('ort') || '';
my $plz = $q->param('plz') || '';
my $strasse = $q->param('strasse') || '';

my $sel_status = $q->param('sel_status') || 'ungleich erl.';
my $suchen = $q->param('suchen');
my $abschicken = $q->param('abschicken');

my $kk_ik = '';
my $kk_name = '';
my $kk_plz = '';
my $kk_ort = '';
my $kk_strasse = '';

print $q->header ( -type => "text/html", -expires => "-1d");

# Alle Felder zur Eingabe ausgeben
print '<head>';
print '<title>Frau suchen</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="stammdaten.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Frau suchen</h1>';
print '<hr width="100%">';
print '</div><br>';
# Formular ausgeben
print '<form name="frau_suchen" action="frauenauswahl.pl" method="get" target=_self onsubmit="return frauenauswahl(this);">';
print '<h3>Suchkriterien:</h3>';
print '<table border="0" width="850" align="left">';

# Name, Ort, PLZ, IK, als Suchkriterien vorgeben
# z1 s1
print '<tr>';
print '<td>';
print '<table border="0" align="left" width="850">';
print '<tr>';
print "<td><b>Vorname</b></td>\n";
print "<td><b>Nachname</b></td>\n";
print "<td><b>Geb. Frau</b></td>\n";
print "<td><b>Geb. Kind</b></td>\n";
print "<td><b>PLZ</b></td>\n";
print "<td><b>Ort</b></td>\n";
print "<td><b>Strasse</b></td>\n";
print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' name='vorname' value='$vorname' size='15'></td>";
print "<td><input type='text' name='nachname' value='$nachname' size='15'></td>";
print "<td><input type='text' name='geb_f' value='$geb_f' size='12' onchange='datum_check(this)'></td>";
print "<td><input type='text' name='geb_k' value='$geb_k' size='12' onchange='datum_check(this)'></td>";
print "<td><input type='text' name='plz' value='$plz' size='7' onchange='plz_check(this)'></td>";
print "<td><input type='text' name='ort' value='$ort' size='10'></td>";
print "<td><input type='text' name='strasse' value='$strasse' size='10'></td>";
print '</table>';
print "\n";

# Zeile mit Pop Menue um Einschränkung auf erledigt und andere status
# vorzunehmen
print '<tr>';
print '<td>';
print '<select name="sel_status" size="1">';
print '<option';
print ' selected' if ($sel_status eq 'alle');
print '>alle</option>';
print '<option';
print ' selected' if ($sel_status eq 'ungleich erl.');
print '>ungleich erl.</option>';
foreach (10,20,22,24,26,80) {
  print '<option';
  print ' selected' if ($sel_status eq $l->status_text($_));
  print ">".$l->status_text($_)."</option>\n";
}
print '</td></tr>';

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

# Prüfen, ob gesucht werden soll
if (defined($suchen)) {
  # alle Frauen ausgeben, die den Kriterien entsprechen
  print '<tr>';
  print '<td>';
  print '<table border="1" align="left">';
  print '<tr>';
  print "<td><b>Vorname</b></td>\n";
  print "<td><b>Nachname</b></td>\n";
  print "<td><b>Geb. Frau</b></td>\n";
  print "<td><b>Geb. Kind</b></td>\n";
  print "<td><b>PLZ</b></td>\n";
  print "<td><b>Ort</b></td>\n";
  print "<td><b>Strasse</b></td>\n";
  print "<td><b>DA Stelle</b></td>\n";
  print "<td><b>Status Bearb.</b></td>\n";
  print '</tr>';
  # suchkriterien erweitern
  $vorname='%'.$vorname.'%';
  $nachname=$nachname.'%';
  $geb_f = $d->convert($geb_f) if ($geb_f ne '');
  $geb_f='%'.$geb_f.'%';
  $geb_k = $d->convert($geb_k) if ($geb_k ne '');
  $geb_k='%'.$geb_k.'%';
  $plz='%'.$plz.'%';
  $ort='%'.$ort.'%';
  $strasse='%'.$strasse.'%';
  $s->stammdaten_suchfrau($vorname,$nachname,$geb_f,$geb_k,$plz,$ort,$strasse);
  while (my ($f_id,
	     $f_vorname,
	     $f_nachname,
	     $f_geb_f,
	     $f_geb_k,
	     $f_plz,
	     $f_ort,
	     $f_tel,
	     $f_strasse,
	     $f_bundesland,
	     $f_entfernung,
	     $f_krankennr,
	     $f_krankennrguelt,
	     $f_verstatus,
	     $f_fk_krankenkasse,
	     $f_nae_heb,
	     $f_begr_nicht_nae_heb) = $s->stammdaten_suchfrau_next) {
    $f_entfernung =~ s/\./,/g;
    # Krankenkassen Infos holen
    if ($f_fk_krankenkasse != 0) {
      ($kk_ik,$kk_name,$kk_plz,$kk_ort,$kk_strasse) =
	 $k->krankenkasse_sel('IK,NAME,PLZ_HAUS,ORT,STRASSE',$f_fk_krankenkasse);
      $kk_strasse = '' if (!$kk_strasse);
    } else {
      ($kk_ik,$kk_name,$kk_plz,$kk_ort,$kk_strasse) = ('','','','','');
    }

    # Datenannahmestelle ermitteln
    my $da_stelle='';
    if ($kk_name ne '') {
      # prüfen ob zu ik Zentral IK vorhanden ist
      my ($ktr,$zik)=$k->krankenkasse_ktr_da($kk_ik);
      my ($name_zik)=$k->krankenkasse_sel("KNAME",$zik);
      if ($zik) {
	$da_stelle=$name_zik;
      }
      $da_stelle = 'privat' if($f_verstatus eq 'privat');
    }


    # Status zu Erfassung ermitteln
    my $status=$l->status_text(10);
    if($l->leistungsdaten_werte($f_id,'distinct status','','status')) {
      ($status)=$l->leistungsdaten_werte_next();
      $status=$l->status_text($status);
    }
    if ($sel_status eq 'alle' || # <- alle frauen
	($status ne $l->status_text(30) && $sel_status eq 'ungleich erl.') || 
	$sel_status eq $status # angegebene status
       ) {
      print '<tr>';
      $f_vorname=' ' if (!defined($f_vorname));print "<td>$f_vorname</td>";
      $f_nachname=' ' if (!defined($f_nachname));print "<td>$f_nachname</td>";
      print "<td>$f_geb_f</td>";
      print "<td>$f_geb_k</td>";
      print "<td>$f_plz</td>";
      $f_ort=' ' if (!defined($f_ort));print "<td>$f_ort</td>";
      $f_strasse=' ' if (!defined($f_strasse));print "<td>$f_strasse</td>";
      print "<td>$da_stelle</td>\n";
      print "<td>$status</td>";
      print '<td><input type="button" name="waehlen" value="Auswählen"';
      print "onclick=\"frau_eintrag('$f_id');self.close();\">\n";
      print "</td>";
      print "</tr>\n";
    }
  }
}
print '</form>';
print '</tr>';
print '</table>';

print "<script>window.focus();</script>";
print "</body>\n";
print "</html>";
