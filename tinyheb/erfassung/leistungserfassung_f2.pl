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


my $speichern = $q->param('Speichern');

my $datum = $q->param('datum_leistung');
$datum = $d->convert($datum) if ($datum ne '');
my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
my $gruppen_auswahl = $q->param('gruppen_auswahl') || 0;
my $func = $q->param('func') || 0;

print $q->header ( -type => "text/html", -expires => "-1d");

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
  .invisible { color:white; background-color:white;border-style:none}
  .td { border-width: 1;border: solid; color:green}
  </style>
STYLE

# Alle Felder zur Eingabe ausgeben
print '<body id="leistungen_window_2" bgcolor=white>';

print '<form name="leistungen_f2" action="leistungserfassung_f2.pl" method="get" target=leistungserfassung_f2 bgcolor=white>';

print_table($gruppen_auswahl);

print "</body>";
print "</html>";

sub print_table {
  my ($type_ix) = @_;
  my @type_ar = ('A','B','C','D','W');
  my $type = $type_ar[$type_ix];
  print "$type&nbsp;";
  if ($type_ix == 0) {
    print '<h2>A. Leistungen der Mutterschaftsvorsorge und Schwangerenbetreuung</h2>';
  } elsif ($type_ix == 1) {
    print '<h2>B. Geburtshilfe</h2>';
  } elsif ($type_ix == 2) {
    print '<h2>C. Leistungen während des Wochenbetts</h2>';
  } elsif ($type_ix == 3) {
    print '<h2>D. Sonstige Leistungen</h2>';
  } elsif ($type_ix == 4) {
    print '<h2>Erklärungen zur Gebührenberechnung - Wegegeld</h2>';
  }
  print '<table border="1" width="100%" align="center">';
  print '<tbody><tr>';
  print '<th align=left>Pos. Nr</th>';
  print '<th align=left>Bezeichnung</th>';
  print '<th align=left>Anwählen</th>';
  print '<th align=left>Betrag</th>';
  print '</tr>';

  $l->leistungsart_such($datum,$type);
  while (my @werte = $l->leistungsart_such_next() ) {  
    my $z_art_sonntag="n";
    my ($posnr,$preis,$prozent) = ($werte[1],$werte[4],$werte[5]);
    my ($sonntag,$nacht,$samstag) = ($werte[6],$werte[7],$werte[8]);
    my ($fuerzeit) = ($werte[9]);
    if ($sonntag =~ /^\+/) {
      $z_art_sonntag = '+';
      $sonntag =~ s/\+//;
    }
    print "<tr>";
    print "<td>$posnr</td>";
    print "<td>$werte[2]</td>";
    print <<SCRIPT_KNOPF;
  <td>
  <input type="checkbox" name="box_name_$posnr" id="box_id_$posnr" onClick="process_$posnr()">
  </td>
  <script>
    function process_$posnr(betrag_ursp) {
      // alert("Klick auf $posnr");
        var preis=new Number('$preis');
        var wotag=wo_tag(parent.leistungserfassung_f1.document.leistungen_f1.datum_leistung.value);
	var tag=window.document.getElementById("td_$posnr\_betrag");	

	if (document.leistungen_f2.box_name_$posnr.checked) {
          // prüfen, ob Preis von Zeit Abhängig ist
          if('$fuerzeit' > '0') {
             preis = zeit_preis($preis,parent.leistungserfassung_f1.document.leistungen_f1.dauer_leistung.value,$fuerzeit);
          }
          if(preis > 0) {
	     tag.firstChild.data=preis;
             tag.firstChild.className="td"; 
           
          }
          if ('$prozent' != '0.00') {
             summe = round($prozent * betrag_ursp);
 	     tag.firstChild.nodeValue=summe;
          }
	  // prüfen ob es abhängige Werte gibt
	  // Sonntags Arbeit
	    if ( wotag==0 && '$sonntag' != '0') {
	      alert("zuschlag"+'$sonntag');
	      document.leistungen_f2.box_name_$sonntag.checked=true;
	      process_$sonntag($preis); // Original Betrag mitgeben
              if ('$z_art_sonntag' != '+') {
              // es handelt sich nicht um Zuschlag, sondern andere Leistung
                document.leistungen_f2.box_name_$posnr.checked=false;
                tag.firstChild.nodeValue="0.00";
	      }
	    }
	} else {
        // Knopf ist abgeschaltet worden
          if (wotag==0 && '$sonntag' != '0') {
            document.leistungen_f2.box_name_$sonntag.checked=false;
            process_$sonntag(0);
          }
	  tag.firstChild.data="0.00";
          tag.firstChild.className='td';
	}
	  
    }
  </script>
SCRIPT_KNOPF
    print "<td align=right id='td_$posnr\_betrag'>&nbsp;</td>\n";
    print "</tr>\n";
  }
  print "</tbody><br></table>";
}

