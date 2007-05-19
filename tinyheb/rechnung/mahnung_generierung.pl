#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Mahnungen generieren und drucken

# Copyright (C) 2006,2007 Thomas Baum <thomas.baum@arcor.de>
# Thomas Baum, 42719 Solingen, Germany

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

my $rechnr = $q->param('rechnr') || 0;

my $speichern = $q->param('Speichern');

my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
my $func = $q->param('func') || 0;

# rechnungsinfos holen
$l->rechnung_such("RECH_DATUM,MAHN_DATUM,BETRAGGEZ,BETRAG,STATUS,IK,FK_STAMMDATEN","RECHNUNGSNR=$rechnr");
my ($rech_datum,$mahn_datum,$betraggez,$betrag,$status,$ik_krankenkasse,$frau_id)=$l->rechnung_such_next();

$frau_id = 0 unless(defined($frau_id));
# zunächst daten der Frau holen
my ($vorname,$nachname,$geb_frau,$geb_kind,$plz,$ort,$tel,$strasse,
    $anz_kinder,$entfernung_frau,$kv_nummer,$kv_gueltig,$versichertenstatus,
    $dummy,$naechste_hebamme,
    $begruendung_nicht_nae_heb) = $s->stammdaten_frau_id($frau_id);

# krankenkassendaten ermitteln w/ existensprüfung krankenkasse
my  ($name_krankenkasse) = $k->krankenkasse_sel('NAME',$ik_krankenkasse);
$name_krankenkasse = '' unless (defined($name_krankenkasse));

print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>Mahnungen generieren</title>';
print '<script language="javascript" src="../erfassung/stammdaten.js"></script>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="rechnung.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';

# Alle Felder zur Eingabe ausgeben
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Mahnnungsgenerierung</h1>';
print '<hr width="100%">';
print '</div>';
# Formular ausgeben
print '<form name="mahnung_gen" action="mahnung_generierung.pl" method="get" target=_top bgcolor=white>';
print '<table border="0" width="700" align="left">';

# Zeile mit Frauen Daten 
# z1 s1
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>ID</b></td>';
print '<td><b>Vorname:</b></td>';
print '<td><b>Nachname</b></td>';
print '<td><b>Geb.:</b></td>';
print '<td><b>Geb. Kind:</b></td>';
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
print "</tr>";

print "</table>";
print "</td>";
print "</tr>";


# Infos zur Rechnungsanschrift nur wenn Krankenkasse vorhanden ist
my $text='';
if (defined($ik_krankenkasse) && $ik_krankenkasse ne '') {
  my ($beleg_ik,$beleg_typ)=$k->krankenkasse_beleg_ik($ik_krankenkasse);
  my $beleg_parm = $h->parm_unique('BELEGE');
  $beleg_typ=1 if(!(defined($beleg_parm)) || $beleg_parm != 1);
  if ($beleg_typ==1) {
    $text .= "Mahnung wird unmittelbar an Krankenkasse geschickt\n";
  } elsif($beleg_typ==2) {
    my ($name_beleg)=$k->krankenkasse_sel("KNAME",$beleg_ik);
    $text .= "Mahnung über direkt verknüpfte Belegannahmestelle $beleg_ik ($name_beleg)\n";
  } elsif($beleg_typ==3) {
    my ($name_beleg)=$k->krankenkasse_sel("KNAME",$beleg_ik);
    my ($ktr,$da)=Heb_krankenkassen->krankenkasse_ktr_da($ik_krankenkasse);
    my ($name_ktr)=$k->krankenkasse_sel("KNAME",$ktr);
    $text .= "Mahnung w/ zentralem Kostenträger $ktr ($name_ktr) an Belegannahmestelle $beleg_ik ($name_beleg)\n";
  } else {
    $text .= "unbekannte Belegannahmestelle, Bitte benachrichtigen Sie den Software Ersteller\n";
  }
}

if ($text ne '' && $versichertenstatus ne 'privat') {
  print "<tr>";
  print "<td><textarea name='hinweise' cols='112' rows='1' class='disabled' disabled >$text</textarea>";
  print "</td>";
  print "</tr>";
}

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';

print "<td><input type='button' name='pdruck' value='Mahnung fertigstellen' onclick='mahn_fertig(\"$frau_id\",\"$rechnr\",mahnung_gen);'</td>";

print '<td><input type="button" name="hauptmenue" value="Hauptmenue" onClick="haupt();"></td>';
print '<td><input type="button" name="rechnungbearb" value="Rechnungsbearbeitung" onClick="window.location=\'rechbear.pl\';"></td>';
print '<td><input type="button" name="stammdaten" value="Stammdaten" onClick="stamm(frau_id.value,document.mahnung_gen);"></td>';
print '</tr>';
print '</table>';

#rint '</table>';
print "\n";
print '</form>';
print '</td>';
print '</tr>';

print "<tr><td>\n";
print "<iframe src='mahnung.pl?frau_id=$frau_id&rechnr=$rechnr' name='mahnung' width='880' height='550' scrolling='auto' frameborder='1'>" if ($rechnr > 0);
print "<iframe src='../blank.html' name='mahnung' width='880' height='550' scrolling='yes' frameborder='1'>" if ($rechnr == 0);
print "</iframe>";
print "</td></tr>\n";
print "</table>\n";



print <<SCRIPTE;
<script>
//  auswahl_wechsel(document.rechnungsdaten);
</script>
SCRIPTE
print "</body>";
print "</html>";


