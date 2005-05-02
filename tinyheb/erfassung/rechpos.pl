#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# author: Thomas Baum
# 09.04.2005
# Rechnungspositionen erfassen für einzelne Rechnungsposition

use strict;
use CGI;
use Date::Calc qw(Today);

use lib "../";
use Heb_stammdaten;
use Heb_datum;
use Heb_leistung;
use Heb;

my $q = new CGI;
my $s = new Heb_stammdaten;
my $d = new Heb_datum;
my $l = new Heb_leistung;
my $h = new Heb;

my $debug=1;
my $script='';

my $TODAY = $d->convert_tmj(sprintf "%4.4u-%2.2u-%2.2u",Today());
my $TODAY_jmt = sprintf "%4.4u%2.2u%2.2u",Today();
my @aus = ('Neu','Ändern');

my $frau_id = $q->param('frau_id') || 0;
my $posnr = $q->param('posnr') || '';
my $begruendung = $q->param('begruendung') || '';
my $datum = $q->param('datum') || $TODAY;
$datum = $d->convert_tmj($datum);
my $zeit_von = $q->param('zeit_von') || '';
my $zeit_bis = $q->param('zeit_bis') || '';
my $entfernung_tag = $q->param('entfernung_tag') || 0;
my $entfernung_nacht = $q->param('entfernung_nacht') || 0;
my $leist_id = $q->param('leist_id') || 0;
my $anzahl_frauen = $q->param('anzahl_frauen') || '';
my $strecke = $q->param('strecke') || 'gesamt';
my $abschicken = $q->param('abschicken');
my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $func = $q->param('func') || 0;

print $q->header ( -type => "text/html", -expires => "-1d");

if ($auswahl eq 'Neu' && defined($abschicken)) {
  speichern();
}

if ($auswahl eq 'Ändern' && defined($abschicken)) {
  aendern();
}

if ($func == 3) {
  loeschen();
}

if ($func == 2) {
  hole_daten();
  $auswahl='Ändern';
}

print '<head>';
print '<title>Rechnungen</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="leistungen.js"></script>';
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
print '<body id="rechpos_window" bgcolor=white>';

# Formular für eigentliche Erfassung ausgeben
print '<form name="rechpos" action="rechpos.pl" method="get" target=rechpos bgcolor=white>';
print '<table border="0" width="100%" align="left">';

# Leistungspositionen 
# z1 s1
print '<h3>Leistungspositionen</h3>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><table border="0" align="left">';
print '<tr>';
print '<td><b>Datum:</b></td>';
print '<td><b>Posnr:</b></td>';
print '<td><b>E. Preis:</b></td>';
print '<td><b>Wochentag:</b></td>';
print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' name='datum' value='$datum' size='10' onblur='datum_check(this);wo_tag(document.rechpos.datum.value,document.rechpos.zeit_von.value,document.rechpos);'></td>";
# Auswahlbox für Positionsnummern
printauswahlboxposnr();

print "<td><input type='text' class='disabled' disabled name='preis' value='' size='6'></td>";
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
print "<td><input type='text' disabled class='disabled' name='zeit_von' value='$zeit_von' size='5' onblur='uhrzeit_check(this);wo_tag(document.rechpos.datum.value,document.rechpos.zeit_von.value,document.rechpos);'></td>";
print "<td><input type='text' disabled class='disabled' name='zeit_bis' value='$zeit_bis' size='5' onblur='uhrzeit_check(this)'></td>";
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
print "<td><input type='text' name='entfernung_tag' value='$entfernung_tag' size='6'></td>";
print "<td><input type='text' name='entfernung_nacht' value='$entfernung_nacht' size='6'></td>";
print "<td><input type='text' name='anzahl_frauen' value='$anzahl_frauen' size='2'></td>";
print "<td><input type='radio' name='strecke' value='gesamt' checked>gesamt";
print "<input type='radio' name='strecke' value='anteilig'>anteilig";
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
  print '<option';
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
print '</tr>';
print '</table>';
print '</form>';
print '</tr>';
print '</table>';
# //  auswahl_wechsel(document.rechpos);
print <<SCRIPTE;
<script>
//  set_focus(document.krankenkassen);
  open("list_posnr.pl?frau_id=$frau_id","list_posnr");
  posnr_wechsel(document.rechpos); // funktion wurde dynamisch generiert.
  wo_tag(document.rechpos.datum.value,document.rechpos.zeit_von.value,document.rechpos);
  document.rechpos.datum.focus();
</script>
SCRIPTE
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
  print "<td><select name='posnr' onchange='posnr_wechsel(document.rechpos)' size=1>";
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

}

sub printbox {
  my ($wahl) = @_;
  #  print "WAHL $wahl\n";
  $l->leistungsart_such($TODAY_jmt,$wahl);
  while (my @werte = $l->leistungsart_such_next() ) {  
    my ($l_posnr,$l_bez,$l_preis,$l_fuerzeit)=($werte[1],$werte[21],$werte[4],$werte[9]);
    print "<option value='$l_posnr' ";
    print ' selected' if ($posnr eq $l_posnr);
    print " >";
    $script .= "if(formular.posnr.value == '$l_posnr') {formular.preis.value=$l_preis;\n";
    if ($l_fuerzeit > 0) {
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
      $script .= "formular.begruendung.focus();\n";
    }
    $script.="}\n";
    print "$l_posnr&nbsp;$l_bez";
    print '</option>';
  }
}



#---------------------------------------------------
# Routinen zum Speichern und Ändern
sub speichern {
#  print "speichern";
#  print "speichern $frau_id $datum $zeit_von 10 <br>\n";
  # Datum konvertieren
  my $datum_l = $d->convert($datum);
  # Entfernung konvertieren
  $entfernung_tag =~ s/,/\./g;
  $entfernung_nacht =~ s/,/\./g;
  # entfernung berechnen
  $anzahl_frauen++ if($anzahl_frauen eq '' || $anzahl_frauen == 0);
  if ($strecke eq 'gesamt') {
    $entfernung_tag /= $anzahl_frauen;
    $entfernung_nacht /= $anzahl_frauen;
  }
  # hier muss noch der Preis berechnet werden in Abhängigkeit der Dauer
  my $preis=0;
  my ($l_epreis,$l_fuerzeit) = $l->leistungsart_such_posnr('EINZELPREIS,FUERZEIT',$posnr,$datum_l);
  if ($l_fuerzeit > 0) {
    my $dauer = $d->dauer_m($zeit_bis,$zeit_von);
    $preis = sprintf "%3.3u",($dauer / $l_fuerzeit);
    $preis++ if ($preis*$l_fuerzeit < $dauer);
    $preis = $preis*$l_epreis;
  } else {
    $preis = $l_epreis;
  }
  
  # Wenn Sonntag angegeben ist, prüfen ob Sonntag und richtige PosNr

  # einfügen in Datenbank
  $leist_id=$l->leistungsdaten_ins($posnr,$frau_id,$begruendung,$datum_l,$zeit_von.':00',$zeit_bis.':00',$entfernung_tag,$entfernung_nacht,$anzahl_frauen,$preis,'',10);
  $entfernung_tag*=$anzahl_frauen;
  $entfernung_nacht*=$anzahl_frauen;
  $strecke='gesamt';
}


sub loeschen {
#  print "loeschen\n";
  $l->leistungsdaten_delete($frau_id,$leist_id);
  $leist_id=0;
}

sub aendern {
  return if ($frau_id==0 || $leist_id ==0);
  loeschen();
  speichern();

}


sub hole_daten {
#  print "hole daten\n";
  my @erg=$l->leistungsdaten_such_id($leist_id);
  $frau_id = $erg[2] || 0;
  $posnr = $erg[1] || '';
  $begruendung = $erg[3] || '';
  $datum = $erg[4];
  $zeit_von = $erg[5] || '';
  $zeit_bis = $erg[6] || '';
  $anzahl_frauen = $erg[9] || '1';
  $entfernung_tag = $erg[7]*$anzahl_frauen || 0;
  $entfernung_tag = sprintf "%.2f",$entfernung_tag;
  $entfernung_nacht = $erg[8]*$anzahl_frauen || 0;
  $entfernung_nacht = sprintf "%.2f",$entfernung_nacht;
  $strecke = 'gesamt';
}
