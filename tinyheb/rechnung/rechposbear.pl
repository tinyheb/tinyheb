#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Rechnungen bearbeiten für einzelne Rechnungen

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
use Date::Calc qw(Today Day_of_Week);

use lib "../";
use Heb_stammdaten;
use Heb_datum;
use Heb_leistung;
use Heb_krankenkassen;
use Heb;

my $q = new CGI;
my $s = new Heb_stammdaten;
my $d = new Heb_datum;
my $l = new Heb_leistung;
my $k = new Heb_krankenkassen;
my $h = new Heb;

my $debug=1;
my $script='';
my $hint='';

my $TODAY = $d->convert_tmj(sprintf "%4.4u-%2.2u-%2.2u",Today());
my $TODAY_jmt = sprintf "%4.4u%2.2u%2.2u",Today();
my @aus = ('Ändern');

my $rechnungsnr = $q->param('rechnungsnr') || 'NULL';
my $mahn_datum = $q->param('mahn_datum') || '';
my $zahl_datum = $q->param('zahl_datum') || '';
my $betraggez = $q->param('betraggez') || 0;

my $abschicken = $q->param('abschicken');
my $func = $q->param('func') || 0;

print $q->header ( -type => "text/html", -expires => "-1d");

# Daten holen
$l->rechnung_such("RECHNUNGSNR,DATE_FORMAT(RECH_DATUM,'%d.%m.%Y'),DATE_FORMAT(MAHN_DATUM,'%d.%m.%Y'),DATE_FORMAT(ZAHL_DATUM,'%d.%m.%Y'),BETRAG,STATUS,BETRAGGEZ,FK_STAMMDATEN,IK","RECHNUNGSNR=$rechnungsnr");
my ($r_rechnr,$r_rech_datum,$r_mahn_datum,$r_zahl_datum,$r_betrag,$r_status,$r_betraggez,$r_fk_st,$r_ik)=$l->rechnung_such_next();
$r_rechnr='' unless (defined($r_rechnr));
$r_rech_datum='' unless (defined($r_rech_datum));
$r_betrag=0 unless (defined($r_betrag));
$r_betraggez=0 unless (defined($r_betraggez));
$r_ik='NULL' unless (defined($r_ik));
$r_fk_st=0 unless (defined($r_fk_st));


if (defined($abschicken)) {
  speichern();
}

print '<head>';
print '<title>Rechnungen Bearbeiten</title>';
print '<script language="javascript" src="../Heb.js"></script>';
#print '<script language="javascript" src="leistungen.js"></script>';
print '</head>';

# style-sheet ausgeben
print <<STYLE;
  <style type="text/css">
  .disabled { color:black; background-color:gainsboro}
  .invisible { color:white; background-color:white;border-style:none}
  .enabled { color:black; background-color:white}
  </style>
STYLE

# Alle Felder zur Eingabe ausgeben
print '<body bgcolor=white>';

# Formular für eigentliche Erfassung ausgeben
print '<form name="rechposbear" action="rechposbear.pl" method="get" target=rechposbear bgcolor=white>';

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
print "<td><input type='text' class='disabled' disabled name='rechnungsnr2' value='$r_rechnr' size='9'></td>";
print "<td><input type='text' class='disabled' disabled name='r_rech_datum' value='$r_rech_datum' size='9'></td>";
my $g_preis = sprintf "%.2f",$r_betrag;
$g_preis =~ s/\./,/g;
print "<td><input type='text' class='disabled' style='text-align:right' disabled name='betrag' value='$g_preis' size='7'></td>";
$g_preis = sprintf "%.2f",$r_betraggez;
$g_preis =~ s/\./,/g;
print "<td><input type='text' class='disabled' style='text-align:right' disabled name='r_betraggez' value='$g_preis' size='7'></td>";
# Name Krankenkasse holen
my ($name)=$k->krankenkasse_ik("NAME",$r_ik);
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
print "<td><input type='text' name='zahl_datum' value='$TODAY' size='9' onblur='datum_check(this);'></td>";
print "<td><input type='text' name='betraggez' value='' size='7'></td>";
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
print '<td><input type="button" name="hauptmenue" value="Hauptmenue" onClick="haupt();"></td>';
print "<td><input type='button' name='stammdaten' value='Stammdaten' onClick='stamm($r_fk_st,document.rechposbear);'></td>";
print "<td><input type='button' name='mahnung' value='Mahnung generieren' onClick='parent.window.location=\"mahnung_generierung.pl?frau_id=$r_fk_st&rechnr=$r_rechnr;\"'></td>";
print '</tr>';


print '</table>';

print '</td></tr>';
print '</table>';
print_summen();
print '</form>';

print <<SCRIPTE;
<script>
  document.rechposbear.zahl_datum.select();
  document.rechposbear.zahl_datum.focus();
  open("list_rech.pl","list_rech");
</script>
SCRIPTE
if ($hint ne '') {
  print "<script>alert('$hint');</script>";
}
print "</body>";
print "</html>";



#---------------------------------------------------------------------
sub print_summen {
#--- neue Tabelle für Summen
# summe der offenen und erledigten Rechnungen berechnen
  $l->rechnung_such('sum(betraggez)','betraggez>0');
  my $summe_gez = $l->rechnung_such_next();
  $summe_gez = sprintf "%.2f",$summe_gez;
  $l->rechnung_such('sum(betrag)');
  my $summe_offen = $l->rechnung_such_next()-$summe_gez;
  $summe_offen = sprintf "%.2f",$summe_offen;
  print '<table border="0">';
  print '<tr>';
  print '<td><h3>Rechnungssummen</h3></td>';
  print '</tr>';
  print '<tr>';
  print '<td><b>erl.</b></td>';
  print "<td align='right'>$summe_gez</td>";
  print '</tr>';
  print '<tr>';
  print '<td><b>offene</b></td>';
  print "<td align='right'>$summe_offen</td>";
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
  if ($betraggez_s == 0 || $zahl_datum eq '' || $r_rechnr eq '') {
    $hint .= "Bitte Datum und Betrag erfassen, nichts gespeichert";
    return;
  }
  if ($r_status == 30) {
    $hint .= "Rechnung ist schon gezahlt, nichts gespeichert";
    return;
  }
  if ($betraggez_s+$r_betraggez > $r_betrag) {
    $hint .= "gez. Betrag zu groß, nichts gespeichert";
    return;
  }
  
  my $status=0;
  if ($betraggez_s+$r_betraggez < $r_betrag) {
    # Teilzahlung
    $status=24;
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
}


