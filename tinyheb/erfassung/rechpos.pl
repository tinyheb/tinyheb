#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Rechnungspositionen erfassen für einzelne Rechnungsposition

# $Id: rechpos.pl,v 1.50 2009-01-09 17:38:35 thomas_baum Exp $
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

#no warnings qw(redefine);

use lib "../";
#use Devel::Cover -silent => 'On';

use CGI;
use CGI::Carp qw(fatalsToBrowser);
use Date::Calc qw(Today Day_of_Week Delta_Days Add_Delta_Days);


use Heb_stammdaten;
use Heb_datum;
use Heb_leistung;
use Heb_GO;
use Heb;

my $q = new CGI;
our $s = new Heb_stammdaten;
our $d = new Heb_datum;
our $l = new Heb_leistung;
our $h = new Heb;

my $debug=1;
our $script='';
our $hint='';
our $hscript='';

our $TODAY = $d->convert_tmj(sprintf "%4.4u-%2.2u-%2.2u",Today());
our $TODAY_jmt = sprintf "%4.4u%2.2u%2.2u",Today();
my @aus = ('Neu','Ändern');

our $frau_id = $q->param('frau_id') || 0;
our $posnr = $q->param('posnr') || '';
our $begruendung = $q->param('begruendung') || '';
our $datum = $q->param('datum') || $TODAY;
#$datum = $d->convert_tmj($datum);
our $zeit_von = $q->param('zeit_von') || '';
$zeit_von = $d->convert_zeit($zeit_von);
our $zeit_bis = $q->param('zeit_bis') || '';
$zeit_bis = $d->convert_zeit($zeit_bis);
our $dia_schl = $q->param('dia_schl') || '';
our $dia_text = $q->param('dia_text') || '';
our $entfernung_tag = $q->param('entfernung_tag') || 0;
our $entfernung_nacht = $q->param('entfernung_nacht') || 0;
our $leist_id = $q->param('leist_id') || 0;
our $anzahl_frauen = $q->param('anzahl_frauen') || 1;
our $strecke = $q->param('strecke') || 'gesamt';
our $abschicken = $q->param('abschicken');
our $anzahl_kurse = $q->param('anzahl_kurse');
our $auswahl = $q->param('auswahl') || 'Anzeigen';
our $func = $q->param('func') || 0;

print $q->header ( -type => "text/html", -expires => "-1d");

if ($auswahl eq 'Anzeigen' && $frau_id > 0 &&
    $entfernung_tag == 0 && $entfernung_nacht == 0) {
  # entfernung aus den Stammdaten der Frau holen und Anzahl auf 1 setzen
  my @dat_frau = $s->stammdaten_frau_id($frau_id);
  $entfernung_tag = $dat_frau[9];
  $entfernung_tag = 0 if (!$dat_frau[9]);
  $entfernung_tag =~ s/\./,/g;
  $anzahl_frauen=1;
}

if ($auswahl eq 'Neu' && defined($abschicken)) {
  $hint=speichern($frau_id,$posnr,$begruendung,$datum,$zeit_von,$zeit_bis,$entfernung_tag,$entfernung_nacht,$anzahl_frauen,$strecke,$dia_schl,$dia_text);
#  $entfernung_tag=0;
#  $entfernung_nacht=0;
  $begruendung='';
#  $anzahl_frauen=1;
  $zeit_von='';
  $zeit_bis='';
}

if ($auswahl eq 'Ändern' && defined($abschicken)) {
  aendern();
  hole_daten() if($leist_id > 0);
#  $entfernung_tag=0;
#  $entfernung_nacht=0;
  $begruendung='';
#  $anzahl_frauen=1;
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
print '<h3 style="margin-top:1pt;margin-bottom:3pt">Leistungspositionen</h3>';
print '<table border="0" align="left">';
print '<tbody id="haupt_tab">';
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
print "</table>\n";


print '<tr><td>';
print '<table border="0" align="left">';
print '<tbody id="tab2">';
print '<tr>';
print '<td><b>Uhrzeit von</b></td>';
print '<td><b>Uhrzeit bis</b></td>';
print '<td><b>Dauer</b></td>';
print '<td><b>Begründung</b></td>';
print '</tr>';

print '<tr>';
print "<td><input type='text' disabled class='disabled' name='zeit_von' value='$zeit_von' size='5' maxlength='5' onchange='uhrzeit_check(this);wo_tag(document.rechpos.datum.value,document.rechpos.zeit_von.value,document.rechpos);'></td>";
print "<td><input type='text' disabled class='disabled' name='zeit_bis' value='$zeit_bis' size='5' maxlength='5' onchange='uhrzeit_check(this)'></td>";
print "<td><input type='text' class='disabled' disabled name='dauer' value='' size='5'></td>";
printauswahlboxbegr();
print "<td><input type='hidden' name='leist_id' value='$leist_id' size='5'></td>";
print "<td><input type='hidden' name='frau_id' value='$frau_id' size='5'></td>";
print '</tr>';
print '</tbody>';
print '</table>';


if ($begruendung =~ /Attest/ ) {
  # Zeile mit Diagnose Angaben ausgeben
  print "<tr id='dia_felder'>";
  print "<td><table>";
  print "<tr><td colspan='2'>";
  print "<b>Diagnose Angaben</b></td></tr>";
  print "<tr><td><b>Schlüssel</b></td><td><b>Text</b></td></tr>";
  print "<tr>";
  print "<td><input type='text' name='dia_schl' value='$dia_schl' size='12' maxlength='12'></td>";
  print "<td><input type='text' name='dia_text' value='$dia_text' size='80' maxlength='70'></td></tr></table>";
  print "</td>";
  print "</tr>";
}

print '<tr id="zeile3_tab">';
print '<td>';
print '<table border="0" align="left">';
print '<tbody id="tab3">';
print '<tr id="km_tab">';
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
print '</tbody>';
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
print "</table>\n";
print '</form>';
print '</td>';
print '</tr>';
print '</tbody>';
print "</table>\n";

# scripte
print qq!<script>!;
print qq!open("list_posnr.pl?frau_id=$frau_id","list_posnr");!;
print qq!posnr_wechsel(document.rechpos); // funktion wurde dynamisch generiert.\n!;
print qq!wo_tag(document.rechpos.datum.value,document.rechpos.zeit_von.value,document.rechpos);\n!;
print qq!</script>\n!;

if ($hint) {
  print qq!<script>alert("$hint");</script>!;
  print "<script>$hscript</script>";
}
print "<script>\n";
print qq!document.rechpos.datum.select();!;
print qq!document.rechpos.datum.focus();!;
print "</script>\n";
print "</body>";
print "</html>";



#---------------------------------------------------------------------

sub printauswahlboxbegr {
   print "<td id='begruend_feld_id'><select name='begruendung' onchange='dia(document.rechpos)' size=1>";
   $h->parm_such('BEGRUENDUNG');
   print "<option value=''> </option>";
   while(my $text=$h->parm_such_next()) {
     $text = substr($text,0,40);
     print "<option value='$text' ";
     print ' selected' if($text eq $begruendung);
     print ' >';
     print "$text";
     print "</option>\n";
   }
   print "</select>";
}


sub printauswahlboxposnr {
  $script='<script>function posnr_wechsel(formular) {';
  print "<td><select id='posnr_id' name='posnr' onchange='posnr_wechsel(document.rechpos)' size=1>";
  print "<option value=''> </option>";
  $script .= "if(formular.posnr.value == '') {formular.preis.value='';}\n";
  printbox($_) foreach qw(A B C D M);

  $script .= "}\n</script>";
  print "</select>";
  print $script;
}

sub printbox {
  my ($wahl) = @_;
  #  print "WAHL $wahl\n";
  $l->leistungsart_such($TODAY_jmt,$wahl);
  while (my @werte = $l->leistungsart_such_next() ) {  
    my $fuerzeit_flag='';
    my ($l_posnr,$l_bez,$l_preis,$l_fuerzeit,$l_samstag,$l_nacht,$l_kilometer)=($werte[1],$werte[21],$werte[4],$werte[9],$werte[8],$werte[7],$werte[22]);
    ($fuerzeit_flag,$l_fuerzeit)=$d->fuerzeit_check($l_fuerzeit);
    if ($l_preis > 0) {
      print "<option value='$l_posnr'";
      print ' selected' if ($posnr eq $l_posnr);
      print ">\n";
      $script .= "if(formular.posnr.value == '$l_posnr') { formular.preis.value=$l_preis; ";

      # Script um Kilometer anzeige abzuschalten
      $script .= "km(formular,'$l_kilometer'); ";

      # Skript aufrufen, um Kursknopf an und auszuschalten
      if($l_posnr eq '7' || $l_posnr eq '40' ||
	 $l_posnr eq '070' || $l_posnr eq '270') {
	$script .= "kurs_knopf();\n";
	$script .= "formular.anzahl_kurse.focus(); ";
      } else {
	$script .= "loesche_kurs_knopf(); ";
      }

      # Script um Zeitanzeige abzuschalten
      if (1 ||
	  $l_fuerzeit || 
	  $l_samstag ||
	  $l_nacht ||
	  $l->leistungsart_pruef_zus($l_posnr,'SAMSTAG') ||
	  $l->leistungsart_pruef_zus($l_posnr,'NACHT')
	 ) {
	$script .= "zeit(formular,'J'); ";
      } else {
	$script .= "zeit(formular,'N'); ";
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

  my ($frau_id,$posnr,$begruendung,$datum,$zeit_von,$zeit_bis,$entfernung_tag,$entfernung_nacht,$anzahl_frauen,$strecke,$dia_schl,$dia_text)=@_;

  my $zuschlag='';
  my $hint='';


  return $hint .= "FEHLER: Bitte Frau auswählen" unless ($frau_id);


  return $hint .= "FEHLER: Keine PosNr. gewählt, nichts gespeichert" unless($posnr);


  # Datum konvertieren
  my $datum_l = $d->convert($datum);
  if ($datum_l eq 'error') {
    $hint .= "FEHLER: ungültiges Datum erfasst, nichts gespeichert";
    $hscript = 'document.rechpos.datum.focus()';
    return $hint;
  }

  # Prüfen ob Positionsnummer für dieses Datum eine gültige ist.
  my ($kbez) = $l->leistungsart_such_posnr('KBEZ',$posnr,$datum_l);
  unless ($kbez) {
    $hint .= 'FEHLER: Positionsnummer '.$posnr.' ist für '.$datum.' keine gültige Positionsnummer,\nes wurde nichts gespeichert.';
    return $hint;
  }

  my $hebgo = Heb_GO->new(
			  posnr => $posnr,
			  frau_id => $frau_id,
			  datum_l => $datum_l,
			  begruendung => $begruendung,
			  zeit_von => $zeit_von,
			  zeit_bis => $zeit_bis,
			 );


  return $hint .= $hebgo->zeit_vorhanden_plausi if ($hebgo->zeit_vorhanden_plausi);


  # Entfernung konvertieren
  $entfernung_tag =~ s/,/\./g;
  $entfernung_nacht =~ s/,/\./g;
  # entfernung berechnen
  $anzahl_frauen++ if(!$anzahl_frauen);
  if ($strecke eq 'gesamt') {
    $entfernung_tag /= $anzahl_frauen;
    $entfernung_nacht /= $anzahl_frauen;
  }


  # Samstag ersetzen?
  if (my $posnr_neu=$hebgo->ersetze_samstag) {
    $hint .= 'Positionsnummer '.$posnr.' w/ Samstag ersetzt durch '.$posnr_neu.'\n';
    $posnr=$posnr_neu;
  } 
  
  # Sonn- oder Feiertag ersetzen?
  elsif ($posnr_neu=$hebgo->ersetze_sonntag) {

    $hint .= 'Positionsnummer '.$posnr.' w/ Sonntag oder Feiertag ersetzt durch '.$posnr_neu.'\n';
    $posnr=$posnr_neu;
  } 

  # Nacht
  elsif($posnr_neu=$hebgo->ersetze_nacht) {
    $hint .='Positionsnummer '.$posnr.' w/ Nacht ersetzt durch '.$posnr_neu.'\n';
    $posnr = $posnr_neu;
    # dann sind es auch Nachtkilometer
    $entfernung_nacht = $entfernung_tag;
    $entfernung_tag = 0;
  }
  
  $zuschlag = $hebgo->zuschlag_samstag if ($hebgo->zuschlag_samstag);
  $zuschlag = $hebgo->zuschlag_sonntag if ($hebgo->zuschlag_sonntag);   
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
  

  # Zukunft Plausi
#  return $hint .= $hebgo->zukunft_plausi if ($hebgo->zukunft_plausi);
  
  # Leistungstyp Plausi
  return $hint .= $hebgo->ltyp_plausi if ($hebgo->ltyp_plausi);

  # darf Positionsnummer nicht mit anderen erfasst werden
  return $hint .= $hebgo->nicht_plausi if ($hebgo->nicht_plausi);

  # spezielle Prüfungen für PosNr. 1
  return $hint .= $hebgo->pos1_plausi if ($hebgo->pos1_plausi);

  # spezielle Prüfungen für PosNr. 010
  return $hint .= $hebgo->pos010_plausi if ($hebgo->pos010_plausi);

  # spezielle Prüfungen für PosNr. 020
  return $hint .= $hebgo->pos020_plausi if ($hebgo->pos020_plausi);

  # spezielle Prüfung für PosNr. 6
  return $hint .= $hebgo->pos6_plausi if ($hebgo->pos6_plausi);

  # spezielle Prüfung für PosNr. 060
  return $hint .= $hebgo->pos060_plausi if ($hebgo->pos060_plausi);

  # spezielle Prüfung für PosNr. 7 
  return $hint .= $hebgo->pos7_plausi if ($hebgo->pos7_plausi);

  # spezielle Prüfung für PosNr. 070 
  return $hint .= $hebgo->pos070_plausi if ($hebgo->pos070_plausi);

  # spezielle Prüfung für PosNr. 8 
  return $hint .= $hebgo->pos8_plausi if ($hebgo->pos8_plausi);

  # spezielle Prüfung für PosNr. 080 
  return $hint .= $hebgo->pos080_plausi if ($hebgo->pos080_plausi);

  # spezielle Prüfung für PosNr. 40 
  return $hint .= $hebgo->pos40_plausi if ($hebgo->pos40_plausi);

  # spezielle Prüfung für PosNr. 270 
  return $hint .= $hebgo->pos270_plausi if ($hebgo->pos270_plausi);

  # spezielle Prüfung für PosNr. 280 290
  return $hint .= $hebgo->pos280_290_plausi if ($hebgo->pos280_290_plausi);

  # spezielle Prüfung w/ Zeitesmal im Wochenbett
  return $hint .= $hebgo->Cd_plausi if ($hebgo->Cd_plausi);

  # spezielle Prüfung w/ Zeitesmal im Wochenbett
  return $hint .= $hebgo->Cd_plausi_neu if ($hebgo->Cd_plausi_neu);

  # spezielle Prüfung w/ wie viele Wochenbettbesuche
  return $hint .= $hebgo->Cc_plausi if ($hebgo->Cc_plausi);

  # Prüfung auf Begründungspflicht
  return $hint .= $hebgo->Begruendung_plausi if ($hebgo->Begruendung_plausi);

  # Gibt es schon Rechnungsposten zu dieser Uhrzeit
  return $hint .= $hebgo->zeit_plausi if ($hebgo->zeit_plausi);

  # Ist PZN hinterlegt bei Material
  return $hint .= $hebgo->pzn_plausi if ($hebgo->pzn_plausi);


  # Preis berechnen in Abhängigkeit der Dauer
  my $preis=0;
  my $fuerzeit_flag='';
  my ($l_epreis,$l_fuerzeit) = $l->leistungsart_such_posnr('EINZELPREIS,FUERZEIT',$posnr,$datum_l);
  ($fuerzeit_flag,$l_fuerzeit)=$d->fuerzeit_check($l_fuerzeit);
  if ($l_fuerzeit) {
    # prüfen ob gültige Zeiten erfasst sind
    my $dauer = $d->dauer_m($zeit_bis,$zeit_von);
#    if ($zeit_von eq '' || $zeit_bis eq '' || $dauer == 0) {
#      $hint .= '\nFEHLER: Bitte Zeit von, Zeit bis erfassen, nichts gespeichert';
#      $hscript = 'document.rechpos.zeit_von.focus();';
#      return $hint;
#    }
    return $hint .= $hebgo->dauer_plausi if ($hebgo->dauer_plausi);

    $preis = sprintf "%3.3u",$h->runden($dauer / $l_fuerzeit) if ($fuerzeit_flag ne 'E');
    $preis = sprintf "%3.2f",$h->runden($dauer / $l_fuerzeit) if ($fuerzeit_flag eq 'E');
    $preis++ if ($preis*$l_fuerzeit < $dauer && $fuerzeit_flag ne 'E');
    $preis = $h->runden($preis*$l_epreis);
  } else {
    $preis = $l_epreis;
  }
  


  # einfügen in Datenbank
  $leist_id=$l->leistungsdaten_ins($posnr,$frau_id,$begruendung,$datum_l,$zeit_von.':00',$zeit_bis.':00',$entfernung_tag,$entfernung_nacht,$anzahl_frauen,$preis,'',10,$dia_schl,$dia_text);

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
      $leist_id=$l->leistungsdaten_ins($posnr,$frau_id,$begruendung,$sieben_spaeter,$zeit_von.':00',$zeit_bis.':00',$entfernung_tag,$entfernung_nacht,$anzahl_frauen,$preis,'',10,$dia_schl,$dia_text);
    }
  }

  # prüfen ob einmaliger Zuschlag gerechnet werden muss
  # wird genau dann gemacht, wenn die Positionsnummer 
  # noch nicht erfasst ist
  my ($einmal_zus) = $l->leistungsart_such_posnr('EINMALIG',$posnr,$datum_l);
  $einmal_zus = '' unless($einmal_zus);
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
  if ($zuschlag) {
    my ($prozent,$ze_preis,$ze_kbez) = $l->leistungsart_such_posnr('PROZENT,EINZELPREIS,KBEZ',$zuschlag,$datum_l);
    my $preis_neu = 0;
    $prozent=0 if (!$prozent);
    $preis_neu = $preis * $prozent if ($prozent > 0);
    $preis_neu = $ze_preis if ($ze_preis > 0);
    # Entfernung darf nicht 2mal gerechnet werden
    # Uhrzeit muss bei Zuschlag auch nicht angegeben sein,
    # keine Begründung
    $l->leistungsdaten_ins($zuschlag,$frau_id,'',$datum_l,'00:00:00','00:00:00',0,0,$anzahl_frauen,$preis_neu,'',10,'','');
    $hint .= '\nZuschlag prozentual wurde zusätzlich gespeichert' if ($prozent > 0);
    $hint .= '\n'.$ze_kbez.' wurde zusätzlich gespeichert' if ($ze_preis > 0);
  }

  # prüfen, ob Materialpauschale gerechnet werden muss
  # wird genau dann gemacht, wenn Zusatzgebühr1 auf Material verweisst.
  # und keine Abhängigkeit zur Zeit besteht
  my ($mat_zus,$mat_zus2) = $l->leistungsart_such_posnr('ZUSATZGEBUEHREN1,ZUSATZGEBUEHREN2',$posnr,$datum_l);
  $mat_zus2 = '' unless($mat_zus2);
  $mat_zus = '' unless($mat_zus);
  if ($mat_zus2 eq '' && $mat_zus =~ /(\+[A-Z]?)(\d{1,3})/ && $2 > 0) {
    my $m_zus=$1.$2;$m_zus =~ s/\+//;
    # Entfernung nicht 2mal rechnen, deshalb im insert statement auf 0 setzen
    # Begründungen müssen bei automatisch gewählen Auslagen nicht 
    # angegeben werden, hier löschen
    # keine Zeit von,bis
    my ($ze_preis,$kbez) = $l->leistungsart_such_posnr('EINZELPREIS,KBEZ',$m_zus,$datum_l);
    $l->leistungsdaten_ins($m_zus,$frau_id,'',$datum_l,'00:00:00','00:00:00',0,0,$anzahl_frauen,$ze_preis,'',10,'','');
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
  return unless($l_posnr);
  if ($l_posnr =~ /^(\+{0,1})(\d{1,3})$/ && $2 > 0) {
    # print "$typ erkannt\n";
    # prüfen ob es sich um andere Positionsnummer handelt
    # welche ID hat diese Posnr?
    $l->leistungsdaten_werte($frau_id,"ID","POSNR=$2 AND DATUM='$datum_l'");
    my ($id)=$l->leistungsdaten_werte_next();
    return $id;
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
  return '' if (!$mat_zus2);
  if ($mat_zus2 && $mat_zus =~ /(\+[A-Z]?)(\d{1,3})/ && $2 > 0) {
    my $m_zus=$1.$2;$m_zus=~s/\+//;
    my $comp=0; # Flag ob gespeichert werden muss oder nicht
    # operator für Vergleich ermitteln
    my ($op,$op_wert,$op_vgltyp) = 
      $mat_zus2 =~ /([>,<,=]{1})(\d{1,3})(\D{1,2})/;
    my $kzetgt=2; # errechneter Termin (default)
    if ($op_vgltyp eq 'GK') { # Geburtsdatum Kind
      # geburtsdatum kind ermitteln
      my @dat_frau = $s->stammdaten_frau_id($frau_id);
      $kzetgt = $dat_frau[16] if($dat_frau[16]); # GT
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
      # mit Entfernung 0 aufrufen und Zeit 0, keine begründung
      my ($ze_preis,$kbez) = $l->leistungsart_such_posnr('EINZELPREIS,KBEZ',$m_zus,$datum_l);
      $l->leistungsdaten_ins($m_zus,$frau_id,'',$datum_l,'00:00:00','00:00:00',0,0,$anzahl_frauen,$ze_preis,'',10,'','');
      $hint .= '\nAuslage '.$kbez.' wurde zusätzlich gespeichert';
      if ($kzetgt == 2) {
	$hint .= ' auf Basis errechneter Termin! Bitte prüfen!\n';
      } else {
	$hint .= ' auf Basis Geburtstermin\n';
      }
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
  loeschen($leist_id_loe) if($leist_id_loe);

  $leist_id_loe=abh($posnr,'SONNTAG',$datum_l);
  loeschen($leist_id_loe) if($leist_id_loe);

  $leist_id_loe=abh($posnr,'NACHT',$datum_l);
  loeschen($leist_id_loe) if($leist_id_loe);

  $leist_id_loe=abh($posnr,'ZUSATZGEBUEHREN1',$datum_l);
  loeschen($leist_id_loe) if($leist_id_loe);

  $leist_id_loe=abh($posnr,'ZUSATZGEBUEHREN2',$datum_l);
  loeschen($leist_id_loe) if($leist_id_loe);

  $leist_id_loe=abh($posnr,'ZUSATZGEBUEHREN3',$datum_l);
  loeschen($leist_id_loe) if($leist_id_loe);

  $leist_id_loe=abh($posnr,'ZUSATZGEBUEHREN4',$datum_l);
  loeschen($leist_id_loe) if($leist_id_loe);

  $leist_id_loe=abh($posnr,'ZWILLINGE',$datum_l);
  loeschen($leist_id_loe) if($leist_id_loe);


  $leist_id_loe=abh($posnr,'ZWEITESMAL',$datum_l);
  if($leist_id_loe) {
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
      $posnr=$wert_neu if($wert_neu);
      # Erneut speichern
      $hint=speichern($erg[2],$posnr,$begruendung,$datum_id_loe,$erg[5].':00',$erg[6].':00',$erg[7],$erg[8],$erg[9],'anteilig',$erg[12],$erg[13]);
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
    if ($werte && $l->leistungsdaten_werte($frau_id,"ID","POSNR in ($werte)","DATUM")) {
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
      $hint=speichern($erg[2],$posnr,$begruendung,$datum_id_loe,$erg[5],$erg[6],$erg[7],$erg[8],$erg[9],'anteilig',$erg[12],$erg[13]);
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
  $hint=speichern($frau_id,$posnr,$begruendung,$datum,$zeit_von,$zeit_bis,$entfernung_tag,$entfernung_nacht,$anzahl_frauen,$strecke,$dia_schl,$dia_text);
  if ($hint=~/FEHLER/g) {
    # jetzt alte Daten wieder speichern
    my $datum=$d->convert($erg[4]);
    # falls keine Uhrzeit erfasst wurde muss dies auf wieder so gespeichert
    # werden
    ($erg[5],$erg[6])=('','') if ($erg[5] eq '00:00' and $erg[6] eq '00:00');
    speichern($erg[2],$erg[1],$erg[3],$datum,$erg[5],$erg[6],$erg[7],$erg[8],$erg[9],'anteilig',$erg[12],$erg[13]);
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
  ($zeit_von,$zeit_bis) = $l->timetoblank($posnr,    # posnr
					  0,         # fuerzeit
					  $erg[4],   # datum
					  $erg[5],   # zeit von
					  $erg[6]);  # zeit bis
#  if ($zeit_von eq '00:00' && $zeit_bis eq '00:00') {
#    $zeit_von='';
#    $zeit_bis='';
#  }
  $anzahl_frauen = $erg[9] || '1';
  $erg[7] = 0 unless ($erg[7]);
  $entfernung_tag = $erg[7]*$anzahl_frauen;
  $entfernung_tag = sprintf "%.2f",$entfernung_tag;
  $entfernung_tag =~ s/\./,/g;
  $erg[8] = 0 unless ($erg[8]);
  $entfernung_nacht = $erg[8]*$anzahl_frauen;
  $entfernung_nacht = sprintf "%.2f",$entfernung_nacht;
  $entfernung_nacht =~ s/\./,/g;
  $strecke = 'gesamt';
  $dia_schl = $erg[12];
  $dia_schl = '' unless($dia_schl);
  $dia_text = $erg[13];
  $dia_text = '' unless($dia_text);
}
