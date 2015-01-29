#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Rechnungen bearbeiten für einzelne Rechnungen

# $Id: rechposbear.pl,v 1.22 2013-10-02 19:48:03 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2005 - 2013 Thomas Baum <thomas.baum@arcor.de>
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
use Date::Calc qw(Today Day_of_Week);

use lib "../";
use Heb_stammdaten;
use Heb_datum;
use Heb_leistung;
use Heb_krankenkassen;
use Heb;

my $q = new CGI;
our $s = new Heb_stammdaten;
our $d = new Heb_datum;
our $l = new Heb_leistung;
our $k = new Heb_krankenkassen;
our $h = new Heb;

my $debug=1;
our $script='';
our $hint='';

our $TODAY = $d->convert_tmj(sprintf "%4.4u-%2.2u-%2.2u",Today());
our $TODAY_jmt = sprintf "%4.4u%2.2u%2.2u",Today();
my @aus = ('Ändern');

our $rechnungsnr = $q->param('rechnungsnr') || 'NULL';
our $mahn_datum = $q->param('mahn_datum') || '';
our $zahl_datum = $q->param('zahl_datum') || '';
our $betraggez = $q->param('betraggez') || 0;

our $ignore = $q->param('ignore') || 0;
my $abschicken = $q->param('abschicken');
my $stornieren = $q->param('stornieren');
my $func = $q->param('func') || 0;
my $sel_status = $q->param('sel_status') || 'ungleich erl.';

print $q->header ( -type => "text/html", -expires => "-1d");

# Daten holen
$l->rechnung_such("RECHNUNGSNR,DATE_FORMAT(RECH_DATUM,'%d.%m.%Y'),DATE_FORMAT(MAHN_DATUM,'%d.%m.%Y'),DATE_FORMAT(ZAHL_DATUM,'%d.%m.%Y'),BETRAG,STATUS,BETRAGGEZ,FK_STAMMDATEN,IK","RECHNUNGSNR=$rechnungsnr");
our ($r_rechnr,$r_rech_datum,$r_mahn_datum,$r_zahl_datum,$r_betrag,$r_status,$r_betraggez,$r_fk_st,$r_ik)=$l->rechnung_such_next();
$r_rechnr='' unless (defined($r_rechnr));
$r_rech_datum='' unless (defined($r_rech_datum));
$r_betrag=0 unless (defined($r_betrag));
$r_betraggez=0 unless (defined($r_betraggez));
$r_ik='NULL' unless (defined($r_ik));
$r_fk_st=0 unless (defined($r_fk_st));
$r_status=0 unless (defined($r_status));


if (defined($abschicken)) {
  speichern();
}
if (defined($stornieren)) {
  stornieren();
}


print '<head>';
print '<title>Rechnungen Bearbeiten</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="rechnung.js"></script>';
#print '<script>alert("lade rechposbear.pl");</script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';

# Alle Felder zur Eingabe ausgeben
print '<body bgcolor=white>';

# Formular für eigentliche Erfassung ausgeben
print '<form name="rechposbear" action="rechposbear.pl" method="get" target=rechposbear onsubmit="return save_rechposbear(this);" bgcolor=white>';

# Rechnung 
# z1 s1
print '<h3>Rechnung</h3>';
print '<table id="haupt" border="0" align="left">';
print '<tr><td>';

print '<table id="oben" border="0" align="left">';
print '<tr>';

print '<td><table id="erste" border="0" align="left">';
print '<tr>';
print '<td><b>Rechnungsnr:</b></td>';
print '<td><b>Rechdatum:</b></td>';
print '<td><b>Betrag:</b></td>';
print '<td><b>Betrag gez.:</b></td>';
print '<td><b>Krankenkasse:</b></td>';
print '</tr>';
print "\n";

print '<tr>';
print "<input type='hidden'name='rechnungsnr' value='$r_rechnr'>";
print "<input type='hidden'name='ignore' value='$ignore'>";
print "<input type='hidden'name='status' value='$r_status'>";
print "<input type='hidden'name='sel_status' value='$sel_status'>";

print "<td><input type='text' class='disabled' disabled name='rechnungsnr2' value='$r_rechnr' size='9'></td>";
print "<td><input type='text' class='disabled' disabled name='r_rech_datum' value='$r_rech_datum' size='9'></td>";
my $g_preis = sprintf "%.2f",$r_betrag;
$g_preis =~ s/\./,/g;
print "<td><input type='text' class='disabled' style='text-align:right' disabled name='betrag' value='$g_preis' size='7'></td>";
$g_preis = sprintf "%.2f",$r_betraggez;
$g_preis =~ s/\./,/g;
print "<td><input type='text' class='disabled' style='text-align:right' disabled name='r_betraggez' value='$g_preis' size='7'></td>";
# Name Krankenkasse holen
my ($name)=$k->krankenkasse_sel("NAME",$r_ik);
$name = '' unless (defined($name));
print "<td><input type='text' class='disabled' disabled name='krankenkasse' value='$name' size='40'></td>";
print '</tr>';
print '</table>';
print '</td></tr>';

# Zeile für Eingaben
print '<tr><td>';
print '<table id="zweite" border="0" align="left">';
print '<tr>';
print '<td><b>Zahldatum:</b></td>';
print '<td><b>Betrag gez:</b></td>';
print '</tr>';
print '<tr>';
print "<td><input type='text' name='zahl_datum' value='$TODAY' size='9' onchange='datum_check(this);'></td>";
print "<td><input type='text' name='betraggez' value='' size='7' onchange='numerisch_check(this);'></td>";
print '</tr>';
print '</table>';
print '</td></tr>';
print "\n";

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td colspan 3>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><input type="submit" name="abschicken" value="Speichern"></td>';
print '<td><input type="submit" name="stornieren" value="Stornieren"></td>';
print '<td><input type="button" name="hauptmenue" value="Hauptmenue" onClick="haupt();"></td>';
print "<td><input type='button' name='stammdaten' value='Stammdaten' onClick='stamm($r_fk_st,document.rechposbear);'></td>";
print "<td><input type='button' name='mahnung' value='Mahnung generieren' onClick='mahn_gen(rechnungsnr)'></td>";
print '</tr>';

print '</table>';

print '</td></tr>';
print '</table>';
print '</form>';
print_summen();


print qq!<script>!;
print qq!document.rechposbear.zahl_datum.select();!;
print qq!document.rechposbear.zahl_datum.focus();!;
print qq!var sel=window.parent.frames.document.rechbear.sel_status;!;
print qq!sel_status=sel.options[sel.selectedIndex].text;!;
#print qq!alert("parent"+sel_status);!;
print qq!open("list_rech.pl?sel_status="+sel_status,"list_rech");!;
print qq!</script>!;

if ($hint ne '') {
  print "<script>alert('$hint');</script>";
}
print "</body>";
print "</html>";



#---------------------------------------------------------------------
sub print_summen {
#--- neue Tabelle für Summen
# summe der offenen und erledigten Rechnungen berechnen
  # Teilzahlung und erledigt
  # gesamte Vergangenheit
  $l->rechnung_such('sum(betraggez)','status>=24 and status<80');
  my $summe_gez = $l->rechnung_such_next();
  $summe_gez=0 unless(defined($summe_gez));
  $summe_gez = sprintf "%.2f",$summe_gez;
  $summe_gez =~ s/\./,/g;

  # akutelles Jahr
  my (undef,undef,$akt_jahr) = split '\.',$TODAY;
  $l->rechnung_such('sum(betraggez)','status>=24 and status<80 and ZAHL_DATUM > '.$akt_jahr.'0101');
  my $summe_gez_akt = $l->rechnung_such_next();
  $summe_gez_akt = 0 unless($summe_gez_akt);
  $summe_gez_akt = sprintf "%.2f",$summe_gez_akt;
  $summe_gez_akt =~ s/\./,/g;
  
  # offene Rechnungen
  $l->rechnung_such('sum(betrag)-sum(betraggez)','status<30');
  my $summe_offen = $l->rechnung_such_next();
  $summe_offen=0 unless(defined($summe_offen));
  $summe_offen = sprintf "%.2f",$summe_offen;
  $summe_offen =~ s/\./,/g;


  # offene Rechnungen aktuelles Jahr
  $l->rechnung_such('sum(betrag)-sum(betraggez)','status<30 and RECH_DATUM > '.$akt_jahr.'0101');
  my $summe_offen_akt = $l->rechnung_such_next();
  $summe_offen_akt=0 unless($summe_offen_akt);
  $summe_offen_akt = sprintf "%.2f",$summe_offen_akt;
  $summe_offen_akt =~ s/\./,/g;

  print '<table border="0" align="right">';
  print '<tr>';
  print '<td colspan="2"><b style="font-size: 1.2em">Rechnungssummen</b></td>';
  print '</tr>';
  print '<tr>';
  print '<td colspan="2" align="right">'.$akt_jahr.'</td>';
  print '<td colspan="2" align="right">gesamt</td>';
  print '</tr>';
  print '<tr>';
  print '<td><b>erl.</b></td>';
  print "<td align='right'>$summe_gez_akt</td>";
  print "<td align='right' style='padding-left:9pt'>$summe_gez</td>";
  print '</tr>';
  print '<tr>';
  print '<td><b>offene</b></td>';
  print "<td align='right'>$summe_offen_akt</td>";
  print "<td align='right' style='padding-left:9pt'>$summe_offen</td>";
  print '</tr>';
  print '</table>';
  #--- Tabelle Summen ende
}


# Routinen zum Speichern und Ändern

sub speichern {
  # speichert Zahlungseingang in Datenbank
  my $betraggez_s = $betraggez;
  $betraggez_s =~ s/,/\./g;
  # erst Plausiprüfungen
  if($r_rechnr eq '') {
    $hint .= "Bitte Rechnung zum Bearbeiten auswählen, nichts gespeichert";
    return;
  }

  if (($betraggez_s == 0 && $ignore == 0) || $zahl_datum eq '') {
    $hint .= "Bitte Datum und Betrag größer Null erfassen, nichts gespeichert";
    return;
  }
  if ($r_status == 30) {
    $hint .= "Rechnung ist schon gezahlt, nichts gespeichert";
    return;
  }

  if ($r_status == 80) {
    $hint .= "Rechnung ist Storniert, nichts gespeichert";
    return;
  }

#  $r_betraggez = sprintf "%.2f",$r_betraggez;
  if ($betraggez_s+$r_betraggez-$r_betrag > 0.001 && $ignore==0) {
    $hint .= "gez. Betrag zu groß, nichts gespeichert";
    return;
  }
  
  my $status=0;
  if ($betraggez_s+$r_betraggez < $r_betrag) {
    # Teilzahlung
    $status=24;
    $status=30 if($ignore==1);
  } else {
    $status=30;
  }
  $betraggez_s += $r_betraggez;
  $l->rechnung_up($r_rechnr,$zahl_datum,$betraggez_s,$status);
  $betraggez = 0;
  $r_betraggez=$betraggez_s;
  # update auf einzelne Leistungspositionen muss noch erfolgen
  $l->leistungsdaten_such_rechnr("ID",$r_rechnr);
  while (my ($id)=$l->leistungsdaten_such_rechnr_next()) {
    $l->leistungsdaten_up_werte($id,"STATUS=$status");
  }
  $r_status=$status;
}


sub stornieren {
  # storniert eine Rechnung in der Datenbank
  # d.h. Rechnung geht auf Status 80 (Storniert)
  # die einzelnen Rechnungposten in Status 10 (Bearbeitung)

  my $betraggez_s = $betraggez;
  $betraggez_s =~ s/,/\./g;

  # erst Plausiprüfungen
  if($r_rechnr eq '') {
    $hint .= "Bitte Rechnung zum Stornieren auswählen, nichts gespeichert";
    return;
  }

  if ($r_status == 30) {
    $hint .= "Rechnung ist schon gezahlt, Storno nicht möglich";
    return;
  }

  if ($r_status == 24) {
    $hint .= "Rechnung ist schon zum Teil gezahlt, Storno nicht möglich";
    return;
  }

  if($betraggez_s > 0) {
    $hint .= "Betrag erfasst und Storno, nichts gespeichert";
    return;
  }

  $l->rechnung_up($r_rechnr,'0000-00-00',0,80);
  # update auf einzelne Leistungspositionen muss noch erfolgen
  $l->leistungsdaten_such_rechnr("ID",$r_rechnr);
  while (my ($id)=$l->leistungsdaten_such_rechnr_next()) {
    $l->leistungsdaten_up_werte($id,"STATUS=10,RECHNUNGSNR=''");
  }
  $r_status=80;
}

