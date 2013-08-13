#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Rechnungen generieren und drucken

# $Id$
# Tag $Name$

# Copyright (C) 2005 - 2009 Thomas Baum <thomas.baum@arcor.de>
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

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();

my $frau_id = $q->param('frau_id') || 0;

my $speichern = $q->param('Speichern');

my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
my $func = $q->param('func') || 0;

my $rechnungsnr = 1+($h->parm_unique('RECHNR'));
$l->rechnung_such('RECHNUNGSNR',"RECHNUNGSNR=$rechnungsnr");
my ($rech_exists)=$l->rechnung_such_next();
if (defined($rech_exists)) {
  die "Die Datenbank ist korrupt, die nächste zu vergebende Rechnungsnummer $rechnungsnr existiert schon in der Datenbank, bitte Parameter RECHNR überprüfen\n";
}

# zunächst daten der Frau holen
my ($vorname,$nachname,$geb_frau,$geb_kind,$plz,$ort,$tel,$strasse,
    $anz_kinder,$entfernung_frau,$kv_nummer,$kv_gueltig,$versichertenstatus,
    $ik_krankenkasse,$naechste_hebamme,
    $begruendung_nicht_nae_heb,$kzetgt) = $s->stammdaten_frau_id($frau_id);

# krankenkassendaten ermitteln w/ existensprüfung krankenkasse
my  ($name_krankenkasse) = $k->krankenkasse_sel('NAME',$ik_krankenkasse);
$name_krankenkasse = '' unless (defined($name_krankenkasse));

print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>Rechnungen generieren</title>';
print '<script language="javascript" src="../erfassung/stammdaten.js"></script>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="rechnung.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';

# Alle Felder zur Eingabe ausgeben
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Rechnungsgenerierung</h1>';
print '<hr width="100%">';
print '</div>';
# Formular ausgeben
print '<form name="rechnungen_gen" action="rechnung_generierung.pl" method="get" target=_top bgcolor=white>';
print '<table border="0" width="700" align="left">';

# Zeile mit Frauen Daten 
# z1 s1
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>ID</b></td>';
print '<td><b>Vorname:</b></td>';
print '<td><b>Nachname</b></td>';
print '<td><b>Geb. Frau:</b></td>';
if (!$kzetgt || $kzetgt == 2) {
  print '<td><b>ET Kind:</b></td>';
} else {
  print '<td><b>Geb. Kind:</b></td>';
}
print '</tr>';
print "\n";
print '<tr>';

print "<td><input type='text' size='3' class='disabled' disabled name='frau_id' value='$frau_id'></td>";
$vorname = '' unless (defined($vorname));
$nachname = '' unless (defined($nachname));
$geb_frau = '' unless (defined($geb_frau));
$geb_kind = '' unless (defined($geb_kind));
print "<td><input type='text' class='disabled' disabled name='vorname' value='$vorname' size='40'></td>";
print "<td><input type='text' class='disabled' disabled name='nachname' value='$nachname' size='40'></td>";
print "<td><input type='text' class='disabled' disabled name='geburtsdatum_frau' value='$geb_frau' size='10'></td>";
print "<td><input type='text' class='disabled' disabled name='geburtsdatum_kind' value='$geb_kind' size='10'></td>";
print qq!<td><input type='button' name='frau_suchen' value='Suchen' onClick='open("../erfassung/frauenauswahl.pl?suchen=Suchen&sel_status=ungleich erl.","frauenauswahl","scrollbars=yes,width=880,height=400");'></td>!;
print "</tr>";

print "</table>";
print "</td>";
print "</tr>";

# Informationen zur Krankenkasse ausgeben
my $text='';
if ($name_krankenkasse ne '') {
  # prüfen ob zu ik Zentral IK vorhanden ist
  my ($ktr,$zik)=$k->krankenkasse_ktr_da($ik_krankenkasse);
  my $test_ind = $k->krankenkasse_test_ind($ik_krankenkasse);
  my ($name_zik)=$k->krankenkasse_sel("KNAME",$zik);
  my ($name_ktr)=$k->krankenkasse_sel("KNAME",$ktr);
  $text.="Kostenträger: $ktr ($name_ktr). ";
  if (defined($zik) && $zik > 0) {
    $text.="Datenannahmestelle: $zik ($name_zik).\n";
  } else {
    $text .= "keine zentrale Datenannahmestelle vorhanden. ";
  }
  my $empf_phys=$k->krankenkasse_empf_phys($zik);
  my ($name_phys)=$k->krankenkasse_sel("KNAME",$empf_phys);
  if (defined($empf_phys) && $empf_phys > 0) {
    $text.="via $empf_phys ($name_phys) ";
  }

  if (defined($test_ind)) { # ZIK als Annahmestelle vorhanden
    if ($test_ind == 0) {
      $text .= "Testphase, Rechnung auf Papier erstellen.\n";
    } elsif ($test_ind == 1) {
      $text .= "Erprobungsphase, Rechnung auf Papier und Mail erstellen.\n";
    } elsif ($test_ind == 2) {
      $text .= "Produktion, Rechnung per Mail erstellen.\n";
    } else {
      $text .= "Falsch Parametrisiert, bitte Parameter für Datenannahmestelle prüfen!\n";
    }
  } else {
    $text .= "kein elektronischer Datenaustausch, Rechnung auf Papier erstellen.\n";
  }
}

# Infos zur Rechnungsanschrift nur wenn Krankenkasse vorhanden ist
if (defined($ik_krankenkasse) && $ik_krankenkasse ne '') {
  my ($beleg_ik,$beleg_typ)=$k->krankenkasse_beleg_ik($ik_krankenkasse);
  my $beleg_parm = $h->parm_unique('BELEGE');
  $beleg_typ=1 if(!(defined($beleg_parm)) || $beleg_parm != 1);
  if ($beleg_typ==1) {
    $text .= "Rechnung wird unmittelbar an Krankenkasse geschickt\n";
  } elsif($beleg_typ==2) {
    my ($name_beleg)=$k->krankenkasse_sel("KNAME",$beleg_ik);
    $text .= "Rechnung über direkt verknüpfte Belegannahmestelle $beleg_ik ($name_beleg)\n";
  } elsif($beleg_typ==3) {
    my ($name_beleg)=$k->krankenkasse_sel("KNAME",$beleg_ik);
    my ($ktr,$da)=Heb_krankenkassen->krankenkasse_ktr_da($ik_krankenkasse);
    my ($name_ktr)=$k->krankenkasse_sel("KNAME",$ktr);
    $text .= "Rechnung w/ zentralem Kostenträger $ktr ($name_ktr) an Belegannahmestelle $beleg_ik ($name_beleg)\n";
  } else {
    $text .= "unbekannte Belegannahmestelle, Bitte benachrichtigen Sie den Software Ersteller\n";
  }
}

if ($text ne '' && $versichertenstatus ne 'privat') {
  print "<tr>";
  print "<td><textarea name='hinweise' cols='112' rows='2' class='disabled' disabled >$text</textarea>";
# print "<td colspan='6'><textarea name='hinweise' cols='112' rows='2' class='disabled' >$text</textarea>";
  print "</td>";
  print "</tr>";
}

#print '</table>';

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
# entgültig drucken nur dann einschalten, wenn Rechnung wirklich Daten enthält
# damit keine Rechnung ohne Gegenwert gespeichert wird
my $test_ind = $k->krankenkasse_test_ind($ik_krankenkasse);
$test_ind = -1 unless(defined($test_ind));
if ($l->leistungsdaten_offen($frau_id,'')) {
  $name_krankenkasse =~ s/'//g;
  $name_krankenkasse =~ s/\r|\n//g;
  print "<td><input type='button' name='pdruck' value='Rechnung fertigstellen' onclick='druck_fertig(\"$frau_id\",\"$vorname\",\"$nachname\",\"$geb_frau\",\"$geb_kind\",\"$plz\",\"$ort\",\"$strasse\",\"$kv_nummer\",\"$kv_gueltig\",\"$versichertenstatus\",\"$name_krankenkasse\",\"$test_ind\",rechnungen_gen);'</td>";

} else {
  print "<td><input type='button' disabled name='pdruck' value='entgültig Drucken'></td>";
}
print '<td><input type="button" name="hauptmenue" value="Hauptmenue" onClick="haupt();"></td>';
print '<td><input type="button" name="echnungerf" value="Rechnungsposten erfassen" onClick="recherf(frau_id.value);"></td>';
print '<td><input type="button" name="stammdaten" value="Stammdaten" onClick="stamm(frau_id.value,document.rechnungen_gen);"></td>';
print '</tr>';
print '</table>';

#rint '</table>';
print "\n";
print '</form>';
print '</td>';
print '</tr>';

print "<tr><td>\n";
print "<iframe src='ps2html.pl?frau_id=$frau_id' name='rechnung' width='880' height='550' scrolling='auto' frameborder='1'>" if ($frau_id > 0);
print "<iframe src='../blank.html' name='rechnung' width='880' height='550' scrolling='yes' frameborder='1'>" unless ($frau_id);
print "</iframe>";
print "</td></tr>\n";
print "</table>\n";

print "</body>";
print "</html>";


