#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

sub BEGIN {
  $ENV{DISPLAY} = "schloesser:0.0";
}

# author: Thomas Baum
# 31.03.2004
# Leistungserfassung Frame 2

use strict;
use CGI;
use Date::Calc qw(Today);

use lib "../";
use Heb_stammdaten;
use Heb_datum;
use Heb_leistung;

my $q = new CGI;
my $k = new Heb_stammdaten;
my $d = new Heb_datum;
my $l = new Heb_leistung;

my $debug=1;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();
my @aus = ('Anzeigen','Ändern','Neu','Löschen');
my @par;

my $datum = $q->param('datum_leistung');
my $uhrzeit = $q->param('uhrzeit_leistung');
my $dauer = $q->param('dauer_leistung');
my $frau_id = $q->param('frau_id');

my $datum_tmj = $datum;
$datum_tmj = sprintf "%2.2u.%2.2u.%4.4u",split('\.',$datum_tmj);
$datum = $d->convert($datum) if ($datum ne '');
my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
my $gruppen_auswahl = $q->param('gruppen_auswahl') || 0;
my $func = $q->param('func') || 0;

my $z_art_sonntag="n";
my $z_art_samstag="n";
my $z_art_nacht="n";
my ($posnr,$preis,$prozent);
my ($sonntag,$nacht,$samstag);
my ($fuerzeit);

my @type_ar = ('A','B','C','D','W');
my $type = $type_ar[$gruppen_auswahl];

print $q->header ( -type => "text/html", -expires => "-1d");

if (($auswahl eq 'Neu') && defined($abschicken)) {
  speichern();
  $auswahl = 'Anzeigen';
}

print '<head>';
print '<title>Leistungserfassung</title>';
print '<script language="javascript" src="leistungen.js"></script>';
print '<script language="javascript" src="stammdaten.js"></script>';
print '<script language="javascript" src="../Heb.js"></script>';
print '</head>';

# style-sheet ausgeben
print <<STYLE;
  <style type="text/css">
  .disabled { color:black; background-color:gainsboro}
  .betrag { color:black; background-color:white;text-align:right;border-style:none}
  .enabled { color:black; background-color:white}
  .invisible { color:white; background-color:white;border-style:none}
  .td { border-width: 1;border: solid; color:black}
  </style>
STYLE

# Alle Felder zur Eingabe ausgeben
print '<body id="leistungen_window_2" bgcolor=white>';

print '<form name="leistungen_f2" action="leistungserfassung_f2.pl" method="get" target=leistungserfassung_f2 onSubmit="leistung_speicher(document.leistungen_f2)" bgcolor=white>';

# verborgende Werte für Zustand
print "<input type='hidden' name='datum_leistung' value='$datum_tmj'>";
print "<input type='hidden' name='uhrzeit_leistung' value='$uhrzeit'>";
print "<input type='hidden' name='dauer_leistung' value='$dauer'>";
print "<input type='hidden' name='frau_id' value='$frau_id'>";
print "<input type='hidden' name='gruppen_auswahl' value='$gruppen_auswahl'>";

print "&nbsp;";
if ($type eq 'A') {
  print '<h2>A. Leistungen der Mutterschaftsvorsorge und Schwangerenbetreuung</h2>';
} elsif ($type eq 'B') {
  print '<h2>B. Geburtshilfe</h2>';
} elsif ($type eq 'C') {
  print '<h2>C. Leistungen während des Wochenbetts</h2>';
} elsif ($type eq 'D') {
  print '<h2>D. Sonstige Leistungen</h2>';
} elsif ($type eq 'W') {
  print '<h2>Erklärungen zur Gebührenberechnung - Wegegeld</h2>';
}
print_table_erfasste($type);
print "<br>\n";
print_table($type);

# leere Zeile
print '<tr><td>&nbsp;</td></tr>';
print "\n";

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td>';
print "<select name='auswahl' size=1 onChange='auswahl_wechsel(document.leistungen_f2)'>";
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
print '<td>';
print '<input type="button" name="reset" value="Inhalt löschen"';
print ' onClick="loeschen()">';
print '</td>';
print '<td><input type="submit" name="abschicken" value="Speichern"></td>';
print '<td><input type="button" name="vorheriger" value="vorheriger Datensatz" onclick="prev_satz(document.leistungen_f2)"></td
>';
print '<td><input type="button" name="naechster" value="nächster Datensatz" onclick="next_satz(document.leistungen_f2)"></td>';
print '<td><input type="button" name="datum_uhrzeit" value="neues Datum/ Uhrzeit" onClick="datum_uhrzeit_neu(parent.leistungserfassung_f1.document)"></td>';
print '</tr>';
print '</table>';
print '</form>';
print '</tr>';
print '</table>';
print <<SCRIPTE;
<script>
  set_focus(document.leistungen_f2);
  auswahl_wechsel(document.leistungen_f2);
</script>
SCRIPTE

print "</body>";
print "</html>";

sub print_table {
  my ($type) = @_;
  print "<h3>weitere Erfassung für $datum_tmj $uhrzeit</h3>";
  print '<table border="1" width="100%" align="center">';
  print '<tbody><tr>';
  print '<th align=left>Pos. Nr</th>';
  print '<th align=left>Bezeichnung</th>';
  print '<th align=left>Anwählen</th>';
  print '<th align=left>Betrag</th>';
  print '</tr>';

  $l->leistungsart_such($datum,$type);
  while (my @werte = $l->leistungsart_such_next() ) {  
    $z_art_sonntag="n";
    ($posnr,$preis,$prozent) = ($werte[1],$werte[4],$werte[5]);
    ($sonntag,$nacht,$samstag) = ($werte[6],$werte[7],$werte[8]);
    ($fuerzeit) = ($werte[9]);
    $z_art_sonntag = 'n';
    if ($sonntag =~ /^\+/) {
      $z_art_sonntag = '+';
      $sonntag =~ s/\+//;
    }
    $z_art_samstag = 'n';
    if ($samstag =~ /^\+/) {
      $z_art_samstag = '+';
      $samstag =~ s/\+//;
    }
    print "<tr>";
    print "<td>$posnr</td>";
    print "<td>$werte[2]</td>";
    print "<td>";
    my ($p_datum,$p_zeit,$p_status,$p_preis) = ($l->leistungsdaten_such_posnr($datum,$uhrzeit.':00',$posnr,$frau_id));
    my $checked = '';
    $checked = 'checked' if (defined($p_preis));
    $checked = 'checked' if (defined($q->param('box_name_'.$posnr)));
    $p_preis = '' if(!defined($p_preis));
    print "<input type='checkbox' $checked name='box_name_$posnr' id='box_id_$posnr' value='$werte[0]' onClick='process_$posnr()'>";
    print '</td>';
    print "<td><input type='text' class='betrag' disabled name='box_name_preis_$posnr' id='betrag' value='$p_preis' size=6></td>";
    print '<script>';
    print "function process_$posnr(betrag_ursp) {";
    print_allg();
    print_sonntag();
    print_samstag();
    print '}</script>';
    print "</tr>\n";
  }
  print "</tbody><br></table>";
}



sub print_table_erfasste {
  my ($type) = @_;
  print "<h3>bisher erfasst</h3>";
  print '<table border="1" width="100%" align="center">';
  print '<tbody><tr>';
  print '<th align=left>Pos. Nr</th>';
  print '<th align=left>Bezeichnung</th>';
  print '<th align=left>Datum</th>';
  print '<th align=left>Uhrzeit</th>';
  print '<th align=right>Betrag</th>';
  print '</tr>';

  $l->leistungsdaten_such_posnr_datum($frau_id,$type);
  my $date = $datum_tmj;
  $date =~ s/-/\./g;
  while (my @werte = $l->leistungsdaten_such_posnr_datum_next() ) {  
    my ($datum,$zeit,$status,$posnr,$bezeichnung,$preis) = 
      ($werte[0],$werte[1],$werte[2],$werte[3],$werte[4],$werte[5]);
    my ($h,$m,$s) = unpack('A2xA2xA2',$zeit);
    $zeit = "$h:$m";
    print "<tr><td>$posnr</td><td>$bezeichnung</td><td>$datum</td><td>$zeit</td><td align=right>$preis</td></tr>" if ($zeit ne $uhrzeit || $datum_tmj ne $datum);
  }
  print "</tbody><br></table>";
}

sub print_allg {
  print <<SCRIPT_ALLG;
  var preis=new Number('$preis');
  var wotag=wo_tag(parent.leistungserfassung_f1.document.leistungen_f1.datum_leistung.value,parent.leistungserfassung_f1.document.leistungen_f1.uhrzeit_leistung.value);
  //alert("wotag"+wotag);

  // prüfen ob Preis zeitabhängig ist
  if('$fuerzeit' > '0') {
    preis = zeit_preis($preis,parent.leistungserfassung_f1.document.leistungen_f1.dauer_leistung.value,$fuerzeit);
  }
  // prüfen, ob Preis prozentual berechnet wird
  if ('$prozent' != '0.00') {
    preis = round($prozent * betrag_ursp);
  }
  // wert einsetzen
  if (document.leistungen_f2.box_name_$posnr.checked) {
    document.leistungen_f2.box_name_preis_$posnr.value=preis;
  } else {
    document.leistungen_f2.box_name_preis_$posnr.value="";
  }
SCRIPT_ALLG
}

sub print_sonntag {
  if ($sonntag ne '0' && $sonntag ne '' && $sonntag ne 'NULL') {
    print <<SCRIPT_SONNTAG;
    if (wotag==0 && document.leistungen_f2.box_name_$posnr.checked) {
      alert("sonntags zuschlag"+'$sonntag');
      document.leistungen_f2.box_name_$sonntag.checked=true;
      process_$sonntag($preis); // Original Betrag mitgeben
      if ('$z_art_sonntag' != '+') {
	// es handelt sich nicht um Zuschlag, sondern andere Leistung
	document.leistungen_f2.box_name_$posnr.checked=false;
	document.leistungen_f2.box_name_preis_$posnr.value="";
      }
    } else {
      if(wotag==0) {
         process_$sonntag(0);
         document.leistungen_f2.box_name_$sonntag.checked=false;
      }
    }
SCRIPT_SONNTAG
  }
}

sub print_samstag {
  if ($samstag ne '0' && $samstag ne 'NULL' && $samstag ne '') {
    print <<SCRIPT_SAMSTAG;
    if (wotag==6 && document.leistungen_f2.box_name_$posnr.checked) {
      alert("samstag zuschlag"+'$samstag');
      document.leistungen_f2.box_name_$samstag.checked=true;
      process_$samstag($preis); // Original Betrag mitgeben
      if ('$z_art_samstag' != '+') {
	// es handelt sich nicht um Zuschlag, sondern andere Leistung
	document.leistungen_f2.box_name_$posnr.checked=false;
	document.leistungen_f2.box_name_preis_$posnr="";
      }
    } else {
      if(wotag==6) {
         process_$samstag(0);
         document.leistungen_f2.box_name_$samstag.checked=false;
      }
    }
SCRIPT_SAMSTAG
  }
}

# speichern von Daten
sub speichern {
# zunächst bisherige Daten löschen
$l->leistungsdaten_delete($datum,$uhrzeit.':00',$frau_id,$type);
my @parms = $q->param;
  for (my $i=0;$i <= $#parms;$i++) {
    if ($parms[$i] =~ /box_name_/g) {
      my $fk_leistungsart = $q->param($parms[$i]) || '';
      my $box_name_preis = $parms[$i];
      $box_name_preis =~ s/box_name_/box_name_preis_/g;
      my $preis=$q->param($box_name_preis);
#      print "speichern $frau_id $datum $uhrzeit $dauer $fk_leistungsart 10 $preis<br>\n" if(defined($preis));
      $l->leistungsdaten_ins($fk_leistungsart,$frau_id,'',$datum,$uhrzeit.':00',$dauer.':00',0,10,$preis) if (defined($preis));
    }
  }
}
