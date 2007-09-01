#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Rechnungspositionen erfassen für einzelne Rechnungsposition

# $Id: rechpos.pl,v 1.39 2007-09-01 06:51:14 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2005,2006,2007 Thomas Baum <thomas.baum@arcor.de>
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
use Date::Calc qw(Today Day_of_Week Delta_Days Add_Delta_Days);

use lib "../";
use Heb_stammdaten;
use Heb_datum;
use Heb_leistung;
use Heb_GO;
use Heb;

my $q = new CGI;
my $s = new Heb_stammdaten;
my $d = new Heb_datum;
my $l = new Heb_leistung;
my $h = new Heb;

my $debug=1;
my $script='';
my $hint='';
my $hscript='';

my $TODAY = $d->convert_tmj(sprintf "%4.4u-%2.2u-%2.2u",Today());
my $TODAY_jmt = sprintf "%4.4u%2.2u%2.2u",Today();
my @aus = ('Neu','Ändern');

my $frau_id = $q->param('frau_id') || 0;
my $posnr = $q->param('posnr') || '';
my $begruendung = $q->param('begruendung') || '';
my $datum = $q->param('datum') || $TODAY;
#$datum = $d->convert_tmj($datum);
my $zeit_von = $q->param('zeit_von') || '';
$zeit_von = $d->convert_zeit($zeit_von);
my $zeit_bis = $q->param('zeit_bis') || '';
$zeit_bis = $d->convert_zeit($zeit_bis);
my $entfernung_tag = $q->param('entfernung_tag') || 0;
my $entfernung_nacht = $q->param('entfernung_nacht') || 0;
my $leist_id = $q->param('leist_id') || 0;
my $anzahl_frauen = $q->param('anzahl_frauen') || 1;
my $strecke = $q->param('strecke') || 'gesamt';
my $abschicken = $q->param('abschicken');
my $anzahl_kurse = $q->param('anzahl_kurse');
my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $func = $q->param('func') || 0;

print $q->header ( -type => "text/html", -expires => "-1d");

if ($auswahl eq 'Neu' && defined($abschicken)) {
  $hint=speichern($frau_id,$posnr,$begruendung,$datum,$zeit_von,$zeit_bis,$entfernung_tag,$entfernung_nacht,$anzahl_frauen,$strecke);
  $entfernung_tag=0;
  $entfernung_nacht=0;
  $begruendung='';
  $anzahl_frauen=1;
}

if ($auswahl eq 'Ändern' && defined($abschicken)) {
  aendern();
  hole_daten() if($leist_id > 0);
  $entfernung_tag=0;
  $entfernung_nacht=0;
  $begruendung='';
  $anzahl_frauen=1;
  $auswahl='Neu';
}

if ($func == 3) {
  loeschen($leist_id);
  $hint='';
  $auswahl='Neu';
}

if ($func == 2) {
  hole_daten();
  $auswahl='Ändern';
}

print '<head>';
print '<title>Rechnungen</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="leistungen.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';

# Alle Felder zur Eingabe ausgeben
print '<body id="rechpos_window" bgcolor=white>';

# Formular für eigentliche Erfassung ausgeben
print '<form name="rechpos" action="rechpos.pl" method="get" target=rechpos onsubmit="return leistung_speicher(this);" bgcolor=white>';

# Leistungspositionen 
# z1 s1
print '<h3>Leistungspositionen</h3>';
print '<table border="0" align="left">';
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr id="zeile1_tab">';
print '<td><b>Datum:</b></td>';
print '<td id="posnr_tab_id"><b>Posnr:</b></td>';
print '<td id="preis_tab_id"><b>E. Preis:</b></td>';
print '<td><b>Wochentag:</b></td>';
print '</tr>';
print "\n";

print '<tr id="zeile2_tab">';
print "<td><input type='text' name='datum' value='$datum' size='10' maxlength='10' onchange='datum_check(this);wo_tag(document.rechpos.datum.value,document.rechpos.zeit_von.value,document.rechpos);'></td>";
# Auswahlbox für Positionsnummern
printauswahlboxposnr();

print "<td id='preis_id'><input type='text' class='disabled' disabled name='preis' value='' size='6'></td>";
print "<td><input type='text' class='disabled' disabled name='wotag' value='' size='17'></td>";

print '</tr>';
print '</table>';


print '<tr><td><table border="0" align="left">';
print '<td><b>Uhrzeit von</b></td>';
print '<td><b>Uhrzeit bis</b></td>';
print '<td><b>Dauer</b></td>';
print '<td><b>Begründung</b></td>';
#print '<td><b>ID Leistung</b></td>';
#print '<td><b>ID Frau</b></td>';
print '<tr>';

print '<tr>';
print "<td><input type='text' disabled class='disabled' name='zeit_von' value='$zeit_von' size='5' maxlength='5' onchange='uhrzeit_check(this);wo_tag(document.rechpos.datum.value,document.rechpos.zeit_von.value,document.rechpos);'></td>";
print "<td><input type='text' disabled class='disabled' name='zeit_bis' value='$zeit_bis' size='5' maxlength='5' onchange='uhrzeit_check(this)'></td>";
print "<td><input type='text' class='disabled' disabled name='dauer' value='' size='5'></td>";
printauswahlboxbegr();
print "<td><input type='hidden' name='leist_id' value='$leist_id' size='5'></td>";
print "<td><input type='hidden' name='frau_id' value='$frau_id' size='5'></td>";
print '</tr>';

print '<tr>';
print '<td><b>Kilometer Tag</b></td>';
print '<td><b>Kilometer Nacht</b></td>';
print '<td><b>Anzahl Frauen</b></td>';
print '<td><b>Strecke</b></td>';
print '</tr>';

print '<tr>';
print "<td><input type='text' name='entfernung_tag' value='$entfernung_tag' size='6' onChange='numerisch_check(this)'></td>";
print "<td><input type='text' name='entfernung_nacht' value='$entfernung_nacht' size='6' onChange='numerisch_check(this)'></td>";
print "<td><input type='text' name='anzahl_frauen' value='$anzahl_frauen' size='2'></td>";
if ($strecke eq 'gesamt') {
  print "<td><input type='radio' name='strecke' value='gesamt' checked>gesamt";
  print "<input type='radio' name='strecke' value='anteilig'>anteilig";
} else {
  print "<td><input type='radio' name='strecke' value='gesamt'>gesamt";
  print "<input type='radio' name='strecke' value='anteilig' checked>anteilig";
}
print "</td>";
print "</tr>";
print '</table>';


print "\n";




# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td colspan 3>';
print '<table border="0" align="left">';
print '<tr>';
print '<td>';
print "<select name='auswahl' size=1 onChange='auswahl_wechsel(document.rechpos)'>";
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

print '<td><input type="submit" name="abschicken" value="Speichern"></td>';
print '<td><input type="button" name="hauptmenue" value="Hauptmenue" onClick="haupt();"></td>';
print '<td><input type="button" name="stammdaten" value="Stammdaten" onClick="stamm(frau_id.value,document.rechpos);"></td>';
print '<td><input type="button" name="Drucken" value="Rechnung generieren" onClick="druck(document.rechpos);"></td>';
print '</tr>';
print '</table>';
print '</form>';
print '</td>';
print '</tr>';
print '</table>';
# //  auswahl_wechsel(document.rechpos);
print <<SCRIPTE;
<script>
  open("list_posnr.pl?frau_id=$frau_id","list_posnr");
  posnr_wechsel(document.rechpos); // funktion wurde dynamisch generiert.
  wo_tag(document.rechpos.datum.value,document.rechpos.zeit_von.value,document.rechpos);
  document.rechpos.datum.select();
  document.rechpos.datum.focus();
 </script>
SCRIPTE
if ($hint ne '') {
  print "<script>alert(\"$hint\");</script>";
  print "<script>$hscript</script>";
}
print "</body>";
print "</html>";



#---------------------------------------------------------------------

sub printauswahlboxbegr {
   print "<td><select name='begruendung' size=1>";
   $h->parm_such('BEGRUENDUNG');
   print "<option value=''> </option>";
   while(my $text=$h->parm_such_next()) {
     $text = substr($text,0,40);
     print "<option value='$text' ";
     print ' selected' if($text eq $begruendung);
     print ' >';
     print "$text";
     print '</option>';
   }
   print "</select>";
}


sub printauswahlboxposnr {
  $script='<script>function posnr_wechsel(formular) {';
  print "<td><select id='posnr_id' name='posnr' onchange='posnr_wechsel(document.rechpos)' size=1>";
  print "<option value=''> </option>";
  $script .= "if(formular.posnr.value == '') {formular.preis.value='';}\n";
  printbox('A');
  printbox('B');
  printbox('C');
  printbox('D');
  printbox('M');
  $script .= "}\n</script>";
  print "</select>";
  print $script;
print <<KURS_SCRIPT
<script>
function kurs_knopf() {
//  alert("Hallo Kurs ausgewählt");
  var ueberschrift=document.createElement("TD");
  ueberschrift.id='ueberschrift_anz_kurse';
//  alert("überschrift-Id"+ueberschrift.id);
  var tab=document.getElementById("zeile1_tab");
  var preis_node=document.getElementById("preis_tab_id");
  tab.insertBefore(ueberschrift,preis_node);
  ueberschrift.innerHTML="<b>Anzahl&nbsp;Kurse</b>";
 
  var feld=document.createElement("TD");
  feld.id='anz_kurse';
  var tab2=document.getElementById("zeile2_tab");
  var preis_feld=document.getElementById("preis_id");
  tab2.insertBefore(feld,preis_feld);
  feld.innerHTML="<input type='text' name='anzahl_kurse' size='2'>";
}

function loesche_kurs_knopf() {
  // alert("loesche Kurs ausgewählt");
  var tab=document.getElementById("zeile1_tab");
  var ueberschrift=document.getElementById("ueberschrift_anz_kurse");
  // alert("ueberschrift"+ueberschrift);
  // überschrift nur entfernen, wenn vorhanden
  if (ueberschrift != null) {
    tab.removeChild(ueberschrift);
    var tab2=document.getElementById("zeile2_tab");
    var feld=document.getElementById("anz_kurse");
    tab2.removeChild(feld);
  }
  
}
</script>

KURS_SCRIPT

}

sub printbox {
  my ($wahl) = @_;
  #  print "WAHL $wahl\n";
  $l->leistungsart_such($TODAY_jmt,$wahl);
  while (my @werte = $l->leistungsart_such_next() ) {  
    my $fuerzeit_flag='';
    my ($l_posnr,$l_bez,$l_preis,$l_fuerzeit,$l_samstag,$l_nacht)=($werte[1],$werte[21],$werte[4],$werte[9],$werte[8],$werte[7]);
    ($fuerzeit_flag,$l_fuerzeit)=$d->fuerzeit_check($l_fuerzeit);
    if ($l_preis > 0) {
      print "<option value='$l_posnr' ";
      print ' selected' if ($posnr eq $l_posnr);
      print " >";
      $script .= "if(formular.posnr.value == '$l_posnr') {\nformular.preis.value=$l_preis;\n";
      if (defined($l_fuerzeit) && $l_fuerzeit > 0 || 
	  defined($l_samstag) && $l_samstag ne '' ||
	  $l->leistungsart_pruef_zus($l_posnr,'SAMSTAG') ||
	  $l->leistungsart_pruef_zus($l_posnr,'NACHT') ||
	  defined($l_nacht) && $l_nacht ne '') {
	$script .= "formular.zeit_von.disabled=false;\n";
	$script .= "formular.zeit_bis.disabled=false;\n";
	$script .= "var zl_tag = document.getElementsByName('zeit_von');\n";
	$script .= "zl_tag[0].className='enabled';\n";
	$script .= "var zl_tag = document.getElementsByName('zeit_bis');\n";
	$script .= "zl_tag[0].className='enabled';\n";
	$script .= "formular.zeit_von.focus();\n";
      } else {
	$script .= "formular.zeit_von.disabled=true;\n";
	$script .= "formular.zeit_bis.disabled=true;\n";
	$script .= "var zl_tag = document.getElementsByName('zeit_von');\n";
	$script .= "zl_tag[0].className='disabled';\n";
	$script .= "var zl_tag = document.getElementsByName('zeit_bis');\n";
	$script .= "zl_tag[0].className='disabled';\n";
	$script .= "formular.entfernung_tag.focus();\n";
      }
      if($l_posnr eq '7' || $l_posnr eq '40' ||
	 $l_posnr eq '070' || $l_posnr eq '270') {
	$script .= "kurs_knopf();\n";
	$script .= "formular.anzahl_kurse.focus()\n";
      } else {
	$script .= "loesche_kurs_knopf();\n";
      }
      $script.="}\n";
      print "$l_posnr&nbsp;$l_bez";
      print '</option>';
    }
  }
}



#---------------------------------------------------
# Routinen zum Speichern und Ändern
sub speichern {

  my ($frau_id,$posnr,$begruendung,$datum,$zeit_von,$zeit_bis,$entfernung_tag,$entfernung_nacht,$anzahl_frauen,$strecke)=@_;

  my $zuschlag='';
  my $hint='';

  if ($frau_id == 0) {
    $hint .= "Bitte Frau auswählen";
    return $hint;
  }
  if ($posnr eq '') {
    $hint .= "FEHLER: Keine PosNr. gewählt, nichts gespeichert";
    return $hint;
  }


  # Datum konvertieren
  my $datum_l = $d->convert($datum);
  if ($datum_l eq 'error') {
    $hint .= "FEHLER: ungültiges Datum erfasst, nichts gespeichert";
    $hscript = 'document.rechpos.datum.focus()';
    return $hint;
  }

  # Prüfen ob Positionsnummer für dieses Datum eine gültige ist.
  my ($kbez) = $l->leistungsart_such_posnr('KBEZ',$posnr,$datum_l);
  if (!(defined($kbez))) {
    $hint .= 'Fehler: Positionsnummer '.$posnr.' ist für '.$datum.' keine gültige Positionsnummer,\nes wurde nichts gespeichert.';
    return $hint;
  }


  # prüfen ob Uhrzeit erfasst wurde, wenn ja, muss es gültige Zeit sein
  if ($zeit_von ne '' || $zeit_bis ne '') {
    if (!($d->check_zeit($zeit_von))) {
      $hint .= '\nFEHLER: keine gültige Uhrzeit von erfasst, nichts gespeichert';
      $hscript = 'document.rechpos.zeit_von.focus();';
      return $hint;
    }
    my $fuerzeit_flag='';
    my ($l_fuerzeit) = $l->leistungsart_such_posnr('FUERZEIT',$posnr,$datum_l);
   ($fuerzeit_flag,$l_fuerzeit)=$d->fuerzeit_check($l_fuerzeit);
    if (!($d->check_zeit($zeit_bis)) && 
	defined($l_fuerzeit) && 
	$l_fuerzeit > 0) {
      $hint .= '\nFEHLER: keine gültige Uhrzeit bis erfasst, nichts gespeichert';
      $hscript = 'document.rechpos.zeit_bis.focus();';
      return $hint;
    }
  }


  # Entfernung konvertieren
  $entfernung_tag =~ s/,/\./g;
  $entfernung_nacht =~ s/,/\./g;
  # entfernung berechnen
  $anzahl_frauen++ if($anzahl_frauen eq '' || $anzahl_frauen == 0);
  if ($strecke eq 'gesamt') {
    $entfernung_tag /= $anzahl_frauen;
    $entfernung_nacht /= $anzahl_frauen;
  }


  my $hebgo = Heb_GO->new(
			  posnr => $posnr,
			  frau_id => $frau_id,
			  datum_l => $datum_l,
			  begruendung => $begruendung,
			  zeit_von => $zeit_von,
			  zeit_bis => $zeit_bis,
			 );

#  my $dow=Day_of_Week($d->jmt($datum));

  # Samstag ersetzen?
  if (my $posnr_neu=$hebgo->ersetze_samstag) {
    $hint .= 'Positionsnummer '.$posnr.' w/ Samstag ersetzt durch '.$posnr_neu.'\n';
    $posnr=$posnr_neu;
  }
  $zuschlag = $hebgo->zuschlag_samstag if ($hebgo->zuschlag_samstag);

  # Sonn- oder Feiertag ersetzen?
  if (my $posnr_neu=$hebgo->ersetze_sonntag) {
    $hint .= 'Positionsnummer '.$posnr.' w/ Sonntag oder Feiertag ersetzt durch '.$posnr_neu.'\n';
    $posnr=$posnr_neu;
  }
  $zuschlag = $hebgo->zuschlag_sonntag if ($hebgo->zuschlag_sonntag);   

  # Nacht
  if(my $posnr_neu=$hebgo->ersetze_nacht) {
      $hint .='Positionsnummer '.$posnr.' w/ Nacht ersetzt durch '.$posnr_neu.'\n';
      $posnr = $posnr_neu;
      # dann sind es auch Nachtkilometer
      $entfernung_nacht = $entfernung_tag;
      $entfernung_tag = 0;
    }
  $zuschlag=$hebgo->zuschlag_nacht if($hebgo->zuschlag_nacht);

  # Zweitesmal
  if(my $posnr_neu=$hebgo->zweitesmal) {
    $hint .= "Positionsnummer $posnr w/ Zweitesmal ersetzt durch $posnr_neu ";
    $posnr=$posnr_neu;
  }

  $hebgo = Heb_GO->new(
		       posnr => $posnr,
		       frau_id => $frau_id,
		       datum_l => $datum_l,
		       begruendung => $begruendung,
		       zeit_von => $zeit_von,
		       zeit_bis => $zeit_bis,
		      );
  
  # Prüfung ob Zuschlag für valides Datum gewählt wurde
  if($hebgo->zuschlag_plausi) {
    $hint .= '\nFEHLER: Positionsnummer '.$posnr.' nur zu bestimmten Tagen und Zeiten, es wurde nichts gespeichert';
    $hscript = 'document.rechpos.datum.select();document.rechpos.datum.focus()';
    return $hint;
  }
  
  
  # Leistungstyp Plausi
  if ($hebgo->ltyp_plausi ne '') {
    $hint .= $hebgo->ltyp_plausi();
    return $hint;
  }

  # spezielle Prüfungen für PosNr. 1
  if ($hebgo->pos1_plausi ne '') {
    $hint .= $hebgo->pos1_plausi();
    return $hint;
  }

  # spezielle Prüfungen für PosNr. 010
  if ($hebgo->pos010_plausi ne '') {
    $hint .= $hebgo->pos010_plausi();
    return $hint;
  }

  # spezielle Prüfungen für PosNr. 020
  if ($hebgo->pos020_plausi) {
    $hint .= $hebgo->pos020_plausi();
    return $hint;
  }


  # spezielle Prüfungen für PosNr. 2, 4, 5 und 8
  if ($hebgo->pos2458_plausi ne '') {
    $hint .= $hebgo->pos2458_plausi;
    return $hint;
  }

  # spezielle Prüfungen für PosNr. 020, 030, 040, 050, 060 und 080
  if ($hebgo->pos234568_plausi) {
    $hint .= $hebgo->pos234568_plausi;
    return $hint;
  }

  # spezielle Prüfung für PosNr. 6
  if ($hebgo->pos6_plausi) {
    $hint .= $hebgo->pos6_plausi;
    return $hint;
  }

  # spezielle Prüfung für PosNr. 060
  if ($hebgo->pos060_plausi) {
    $hint .= $hebgo->pos060_plausi;
    return $hint;
  }

  # spezielle Prüfung für PosNr. 7 
  if ($hebgo->pos7_plausi) {
    $hint .= $hebgo->pos7_plausi;
    return $hint;
  }

  # spezielle Prüfung für PosNr. 070 
  if ($hebgo->pos070_plausi) {
    $hint .= $hebgo->pos070_plausi;
    return $hint;
  }


  # spezielle Prüfung für PosNr. 8 
  if ($hebgo->pos8_plausi) {
    $hint .= $hebgo->pos8_plausi;
    return $hint;
  }

  # spezielle Prüfung für PosNr. 080 
  if ($hebgo->pos080_plausi) {
    $hint .= $hebgo->pos080_plausi;
    return $hint;
  }

  # spezielle Prüfung für PosNr. 40 
  if ($hebgo->pos40_plausi) {
    $hint .= $hebgo->pos40_plausi;
    return $hint;
  }

  # spezielle Prüfung für PosNr. 270 
  if ($hebgo->pos270_plausi) {
    $hint .= $hebgo->pos270_plausi;
    return $hint;
  }

  # spezielle Prüfung w/ Zeitesmal im Wochenbett
  if ($hebgo->Cd_plausi ne '') {
    $hint .= $hebgo->Cd_plausi;
    return $hint;
  }

  # spezielle Prüfung w/ Zeitesmal im Wochenbett
  if ($hebgo->Cd_plausi_neu) {
    $hint .= $hebgo->Cd_plausi_neu;
    return $hint;
  }

  # spezielle Prüfung w/ wie viele Wochenbettbesuche
  if ($hebgo->Cc_plausi ne '') {
    $hint .= $hebgo->Cc_plausi;
    return $hint;
  }

  # Prüfung auf Begründungspflicht
  if ($hebgo->Begruendung_plausi ne '') {
    $hint .= $hebgo->Begruendung_plausi;
    return $hint;
  }

  # Preis berechnen in Abhängigkeit der Dauer
  my $preis=0;
  my $fuerzeit_flag='';
  my ($l_epreis,$l_fuerzeit) = $l->leistungsart_such_posnr('EINZELPREIS,FUERZEIT',$posnr,$datum_l);
  ($fuerzeit_flag,$l_fuerzeit)=$d->fuerzeit_check($l_fuerzeit);
  if (defined($l_fuerzeit) && $l_fuerzeit > 0) {
    # prüfen ob gültige Zeiten erfasst sind
    my $dauer = $d->dauer_m($zeit_bis,$zeit_von);
    if ($zeit_von eq '' || $zeit_bis eq '' || $dauer == 0) {
      $hint .= '\nFEHLER: Bitte Zeit von, Zeit bis erfassen, nichts gespeichert';
      $hscript = 'document.rechpos.zeit_von.focus();';
      return $hint;
    }
    if ($hebgo->dauer_plausi ne '') {
      $hint .= $hebgo->dauer_plausi;
      return $hint;
    }
    $preis = sprintf "%3.3u",($dauer / $l_fuerzeit) if ($fuerzeit_flag ne 'E');
    $preis = sprintf "%3.2f",($dauer / $l_fuerzeit) if ($fuerzeit_flag eq 'E');
    $preis++ if ($preis*$l_fuerzeit < $dauer && $fuerzeit_flag ne 'E');
    $preis = $preis*$l_epreis;
  } else {
    $preis = $l_epreis;
  }
  


  # einfügen in Datenbank
  $leist_id=$l->leistungsdaten_ins($posnr,$frau_id,$begruendung,$datum_l,$zeit_von.':00',$zeit_bis.':00',$entfernung_tag,$entfernung_nacht,$anzahl_frauen,$preis,'',10);

  # prüfen, ob Anzahl Kurse übergeben wurde, wenn ja die auch einfügen
  if ($anzahl_kurse) {
    my $i=1;
    my $sieben_spaeter=$datum_l;
    $sieben_spaeter =~ s/-//g;
    while ($i<$anzahl_kurse) {
      $sieben_spaeter=sprintf "%4.4u-%2.2u-%2.2u",Add_Delta_Days(unpack('A4A2A2',$sieben_spaeter),7);
      
      my $datum_l7s=  $sieben_spaeter;
      $sieben_spaeter =~ s/-//g;
      my $hebgo7s = Heb_GO->new(
				posnr => $posnr,
				frau_id => $frau_id,
				datum_l => $datum_l7s,
				begruendung => $begruendung,
				zeit_von => $zeit_von,
				zeit_bis => $zeit_bis,
			       );
      
      if ($hebgo7s->pos7_plausi or $hebgo7s->pos070_plausi) {
	$hint .= "Es wurden nur $i Kurse gespeichert.";
	return $hint;
      }
      if ($hebgo7s->pos40_plausi or $hebgo7s->pos270_plausi) {
	$hint .= "Es wurden nur $i Kurse gespeichert.";
	return $hint;
      }
      if ($hebgo7s->ltyp_plausi) {
	$hint .= "Es wurden nur $i Kurse gespeichert.";
	return $hint;
      }
      $i++;
      $leist_id=$l->leistungsdaten_ins($posnr,$frau_id,$begruendung,$sieben_spaeter,$zeit_von.':00',$zeit_bis.':00',$entfernung_tag,$entfernung_nacht,$anzahl_frauen,$preis,'',10);
    }
  }

  # prüfen ob einmaliger Zuschlag gerechnet werden muss
  # wird genau dann gemacht, wenn die Positionsnummer 
  # noch nicht erfasst ist
  my ($einmal_zus) = $l->leistungsart_such_posnr('EINMALIG',$posnr,$datum_l);
  $einmal_zus = '' unless(defined($einmal_zus));
  if ($einmal_zus =~ /(\+{0,1})(\d{1,3})/ && $2 > 0) {
    $zuschlag=$2;
    if ($l->leistungsdaten_werte($frau_id,"ID,DATUM","POSNR=$zuschlag","DATUM")) {
      my ($id,$datum1)=$l->leistungsdaten_werte_next();
      $datum1 =~ s/-//g;
      my $datum2 = $datum_l;
      $datum2 =~ s/-//g;
      if ($datum1 <= $datum2) {
	$zuschlag=0;
      } else {
	loeschen($id); # Neues Datum ist kleiner als bisheriges
      }      
    }
  }


  # prüfen ob Zuschlag gespeichert werden muss
  if ($zuschlag ne '' && $zuschlag > 0) {
    my ($prozent,$ze_preis) = $l->leistungsart_such_posnr('PROZENT,EINZELPREIS',$zuschlag,$datum_l);
    my $preis_neu = 0;
    $prozent=0 if (!defined($prozent) || $prozent eq '');
    $preis_neu = $preis * $prozent if ($prozent > 0);
    $preis_neu = $ze_preis if ($ze_preis > 0);
    # Entfernung darf nicht 2mal gerechnet werden
    $l->leistungsdaten_ins($zuschlag,$frau_id,$begruendung,$datum_l,$zeit_von.':00',$zeit_bis.':00',0,0,$anzahl_frauen,$preis_neu,'',10);
    $hint .= '\nZuschlag prozentual wurde zusätzlich gespeichert' if ($prozent > 0);
    $hint .= '\nZuschlag wurde zusätzlich gespeichert' if ($ze_preis > 0);
  }

  # prüfen, ob Materialpauschale gerechnet werden muss
  # wird genau dann gemacht, wenn Zusatzgebühr1 auf Material verweisst.
  # und keine Abhängigkeit zur Zeit besteht
  my ($mat_zus,$mat_zus2) = $l->leistungsart_such_posnr('ZUSATZGEBUEHREN1,ZUSATZGEBUEHREN2',$posnr,$datum_l);
  $mat_zus2 = '' unless(defined($mat_zus2));
  $mat_zus = '' unless(defined($mat_zus));
  if ($mat_zus2 eq '' && $mat_zus =~ /(\+[A-Z]?)(\d{1,3})/ && $2 > 0) {
    my $m_zus=$1.$2;$m_zus =~ s/\+//;
    # Entfernung nicht 2mal rechnen, deshalb im insert statement auf 0 setzen
    # Begründungen müssen bei automatisch gewählen Auslagen nicht 
    # angegeben werden, hier löschen
    # keine Zeit von,bis
    my ($ze_preis,$kbez) = $l->leistungsart_such_posnr('EINZELPREIS,KBEZ',$m_zus,$datum_l);
    $l->leistungsdaten_ins($m_zus,$frau_id,'',$datum_l,'00:00:00','00:00:00',0,0,$anzahl_frauen,$ze_preis,'',10);
    $hint .= '\nAuslage '.$kbez.' wurde zusätzlich gespeichert';
  }


  # prüfen, ob Materialpauschale für Zuschlag gerechnet werden muss
  # hier mit Vergleichswerten
  ($mat_zus,$mat_zus2) = $l->leistungsart_such_posnr('ZUSATZGEBUEHREN1,ZUSATZGEBUEHREN2',$zuschlag,$datum_l);
  $hint .= matpausch($mat_zus,$mat_zus2,$datum_l);
  ($mat_zus,$mat_zus2) = $l->leistungsart_such_posnr('ZUSATZGEBUEHREN3,ZUSATZGEBUEHREN4',$zuschlag,$datum_l);
  $hint .= matpausch($mat_zus,$mat_zus2,$datum_l);
  

  $entfernung_tag*=$anzahl_frauen;
  $entfernung_nacht*=$anzahl_frauen;
  $strecke='gesamt';
  return $hint;
}


sub abh {
  # prüfen gibt es Abhängige Positionsnummer für bestimmten Typ
  # z.B. Samstag, Sonntag, Nacht (muss übergeben werden)
  # wenn diese existiert wird die ID der entsprechenden Nummer
  # als Ergebnis geliefert, undef sonst
  
  my ($posnr,$abh_posnr,$datum_l) = @_;
  my ($l_posnr) = $l->leistungsart_such_posnr($abh_posnr,$posnr,$datum_l);
  return undef unless(defined($l_posnr));
  if ($l_posnr =~ /^(\+{0,1})(\d{1,3})$/ && $2 > 0) {
    # print "$typ erkannt\n";
    # prüfen ob es sich um andere Positionsnummer handelt
#    if ($1 eq '+') {
      # welche ID hat diese Posnr?
      $l->leistungsdaten_werte($frau_id,"ID","POSNR=$2 AND DATUM='$datum_l'");
      my ($id)=$l->leistungsdaten_werte_next();
      return $id;
#    }
  }
  if ($l_posnr =~ /(\+)([A-Z])(\d{1,3})/ && $3 > 0) {
    # Materialpauschalen
    $l->leistungsdaten_werte($frau_id,"ID","POSNR='$2$3' AND DATUM='$datum_l'");
    my ($id)=$l->leistungsdaten_werte_next();
    return $id;
  }
  return undef;
}


sub matpausch {
  # prüfen, ob Materialpauschale für Zuschlag gerechnet werden muss
  # wird genau dann gemacht, wenn Zusatzgebühr bei Zuschlag 
  # auf Material verweisst und Abhängigkeit zur Zeit besteht
  # der Vergleichswert wird aus Zusatzvermerk ermittelt
  my ($mat_zus,$mat_zus2,$datum_l) = @_;
  my $hint='';

  # keine Prüfung, wenn Werte nicht definiert
  return '' if (!defined($mat_zus2));
  if ($mat_zus2 ne '' && $mat_zus =~ /(\+[A-Z]?)(\d{1,3})/ && $2 > 0) {
    my $m_zus=$1.$2;$m_zus=~s/\+//;
    my $comp=0; # Flag ob gespeichert werden muss oder nicht
    # operator für Vergleich ermitteln
    my ($op,$op_wert,$op_vgltyp) = 
      $mat_zus2 =~ /([>,<,=]{1})(\d{1,3})(\D{1,2})/;
    if ($op_vgltyp eq 'GK') { # Geburtsdatum Kind
      # geburtsdatum kind ermitteln
      my @dat_frau = $s->stammdaten_frau_id($frau_id);
      my $geb_kind = $dat_frau[3];
      $geb_kind = $d->convert($geb_kind);
      if ($geb_kind eq 'error') {
	$geb_kind = '1900.01.01';
	$hint .= '\nGeburtsdatum Kind konnte nicht ermittelt werden, bitte Ergebiss überprüfen';
      }
      # Wieviele Tage liegen zwischen $datum_l und Geburtsdatum Kind?
      my $days = Delta_Days(unpack('A4xA2xA2',$datum_l),unpack('A4xA2xA2',$geb_kind));
      $comp = 1 if (abs($days)<$op_wert && $op eq '<');
      $comp = 1 if (abs($days)==$op_wert && $op eq '=');
      $comp = 1 if (abs($days)>$op_wert && $op eq '>');
    }
    
    if ($comp) { # es muss gespeichert werden
      # Entfernung nicht 2mal rechnen bei Materialpauschale, daher
      # mit Entfernung 0 aufrufen
      my ($ze_preis,$kbez) = $l->leistungsart_such_posnr('EINZELPREIS,KBEZ',$m_zus,$datum_l);
      $l->leistungsdaten_ins($m_zus,$frau_id,$begruendung,$datum_l,$zeit_von.':00',$zeit_bis.':00',0,0,$anzahl_frauen,$ze_preis,'',10);
      $hint .= '\nAuslage '.$kbez.' wurde zusätzlich gespeichert';
    }
  }
  return $hint;
}




sub loeschen {
#  print "loeschen\n";
  my ($leist_id)=@_;
  # bevor gelöscht wird, genaue Daten zu entsprechendem Satz holen
  my @erg=$l->leistungsdaten_such_id($leist_id);
  my $posnr=$erg[1];
  my $datum_l=$d->convert($erg[4]);
  $l->leistungsdaten_delete($frau_id,$leist_id);
  
  my $leist_id_loe=abh($posnr,'SAMSTAG',$datum_l);
  loeschen($leist_id_loe) if(defined($leist_id_loe));

  $leist_id_loe=abh($posnr,'SONNTAG',$datum_l);
  loeschen($leist_id_loe) if(defined($leist_id_loe));

  $leist_id_loe=abh($posnr,'NACHT',$datum_l);
  loeschen($leist_id_loe) if(defined($leist_id_loe));

  $leist_id_loe=abh($posnr,'ZUSATZGEBUEHREN1',$datum_l);
  loeschen($leist_id_loe) if(defined($leist_id_loe));

  $leist_id_loe=abh($posnr,'ZUSATZGEBUEHREN2',$datum_l);
  loeschen($leist_id_loe) if(defined($leist_id_loe));

  $leist_id_loe=abh($posnr,'ZUSATZGEBUEHREN3',$datum_l);
  loeschen($leist_id_loe) if(defined($leist_id_loe));

  $leist_id_loe=abh($posnr,'ZUSATZGEBUEHREN4',$datum_l);
  loeschen($leist_id_loe) if(defined($leist_id_loe));

  $leist_id_loe=abh($posnr,'ZWILLINGE',$datum_l);
  loeschen($leist_id_loe) if(defined($leist_id_loe));


  $leist_id_loe=abh($posnr,'ZWEITESMAL',$datum_l);
  if(defined($leist_id_loe)) {
    # Wenn es diese Position gibt, muss sie gelöscht werden und
    # als erstesmal gespeichert werden.
    my @erg=$l->leistungsdaten_such_id($leist_id_loe);
    $l->leistungsart_zus($erg[1],'ZWEITESMAL',$datum_l);
    my $werte='';
    my $wert_neu='';
    while (my $poszus=$l->leistungsart_zus_next()) {
      $wert_neu = $poszus if ($werte eq '');
      $werte .= ',' if ($werte ne '');
      $werte .= $poszus;
    }
    $werte=$erg[1] if ($werte eq '');
    if ($l->leistungsdaten_werte($frau_id,"ID","(POSNR in ($werte) or POSNR=$erg[1]) and DATUM >= '".$d->convert($erg[4])."'",'DATUM')) {
      my ($id)=$l->leistungsdaten_werte_next();
      my @erg=$l->leistungsdaten_such_id($id);
      loeschen($id); # pos löschen und später erneut einfügen
      my $datum_id_loe=$d->convert($erg[4]);
      my $posnr=$erg[1];
      $posnr=$wert_neu if($wert_neu ne '');
      # Erneut speichern
      $hint=speichern($erg[2],$posnr,$begruendung,$datum_id_loe,$erg[5].':00',$erg[6].':00',$erg[7],$erg[8],$erg[9],'anteilig');
    }
    $l->leistungsdaten_delete($frau_id,$leist_id_loe);
  }


  $leist_id_loe=abh($posnr,'EINMALIG',$datum_l);
  if(defined($leist_id_loe)) {
    # es muss noch geprüft werden, ob jetzt eine andere Positionsnummer
    # w/ Einmalig gewählt werden muss
    # zunächst Prüfen welche Positionsnummern relevant sind
    my @erg=$l->leistungsdaten_such_id($leist_id_loe);
    loeschen($leist_id_loe);
    $l->leistungsart_zus($erg[1],'EINMALIG',$datum_l);
    my $werte='';
    while (my $poszus=$l->leistungsart_zus_next()) {
      $werte .= ',' if ($werte ne '');
      $werte .= $poszus;
    }
    if ($werte ne '' && $l->leistungsdaten_werte($frau_id,"ID","POSNR in ($werte)","DATUM")) {
      my ($id)=$l->leistungsdaten_werte_next();
      my @erg=$l->leistungsdaten_such_id($id);
      loeschen($id); # pos löschen und später erneut einfügen
      my $datum_id_loe=$d->convert($erg[4]);
      my $posnr=$erg[1];
      # Zuschlag für anderen Tag speichern
      if ($erg[5] eq '00:00' && $erg[6] eq '00:00') {
	$erg[5]='';
	$erg[6]='';
      }
      $hint=speichern($erg[2],$posnr,$begruendung,$datum_id_loe,$erg[5],$erg[6],$erg[7],$erg[8],$erg[9],'anteilig');
    }
    $l->leistungsdaten_delete($frau_id,$leist_id_loe);
  }


  $leist_id=0;
}

sub aendern {
  if ($frau_id==0 || $leist_id ==0) {
    $hint='Keine Position zur Änderung ausgewählt,\nes wurde nicht geändert';
    return;
  }
  # Werte der zu löschenden Position holen, falls bei Speichern etwas
  # schief geht
  my @erg=$l->leistungsdaten_such_id($leist_id);
  loeschen($leist_id);
  $leist_id=0;
  $hint=speichern($frau_id,$posnr,$begruendung,$datum,$zeit_von,$zeit_bis,$entfernung_tag,$entfernung_nacht,$anzahl_frauen,$strecke);
  if ($hint=~/FEHLER/g) {
    # jetzt alte Daten wieder speichern
    my $datum=$d->convert($erg[4]);
    speichern($erg[2],$erg[1],$erg[3],$datum,$erg[5].':00',$erg[6].':00',$erg[7],$erg[8],$erg[9],'anteilig');
    $hint='Änderung konnte nicht durchdeführt werden, wegen'.$hint;
  } else {
    $hint = '';
  }
}


sub hole_daten {
#  print "hole daten\n";
  my @erg=$l->leistungsdaten_such_id($leist_id);
#  $frau_id = $erg[2] || 0;
  $posnr = $erg[1] || '';
  $begruendung = $erg[3] || '';
  $datum = $erg[4];
  $zeit_von = $erg[5] || '';
  $zeit_bis = $erg[6] || '';
  if ($zeit_von eq '00:00' && $zeit_bis eq '00:00') {
    $zeit_von='';
    $zeit_bis='';
  }
  $anzahl_frauen = $erg[9] || '1';
  $erg[7] = 0 unless (defined($erg[7]));
  $entfernung_tag = $erg[7]*$anzahl_frauen || 0;
  $entfernung_tag = sprintf "%.2f",$entfernung_tag;
  $entfernung_tag =~ s/\./,/g;
  $erg[8] = 0 unless (defined($erg[8]));
  $entfernung_nacht = $erg[8]*$anzahl_frauen || 0;
  $entfernung_nacht = sprintf "%.2f",$entfernung_nacht;
  $entfernung_nacht =~ s/\./,/g;
  $strecke = 'gesamt';
}
