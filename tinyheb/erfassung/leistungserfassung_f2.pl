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

my $datum = $q->param('datum') || $TODAY;
my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
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

print_table('A');
print_table('B');
print "</body>";
print "</html>";

sub print_table {
  my ($type) = @_;
  print '&nbsp;';
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
    if ($werte[6] =~ /^\+/) {
      $z_art_sonntag = '+';
      $werte[6] =~ s/\+//;
    }
    print "<tr>";
    print "<td>$werte[1]</td>";
    print "<td>$werte[2]</td>";
    print <<SCRIPT_KNOPF;
  <td>
  <input type="checkbox" name="box_name_$werte[1]" id="box_id_$werte[1]" onClick="process_$werte[1]()">
  </td>
  <script>
    function process_$werte[1](betrag_ursp) {
      // alert("Klick auf $werte[1]");
      // Betrag füllen, wenn gefüllt
	var tag=window.document.getElementById("td_$werte[1]_betrag");	
	if (document.leistungen_f2.box_name_$werte[1].checked) {
          if('$werte[4]' != '0.00') {
	     tag.firstChild.data="$werte[4]";
             tag.firstChild.className="td"; 
           
          }
          if ('$werte[5]' != '0.00') {
             var summe = $werte[5];
             summe = summe * betrag_ursp;
 	     tag.firstChild.nodeValue=summe;
          }
	  // prüfen ob es abhängige Werte gibt
	  // Sonntags Arbeit
	    if ( wo_tag(parent.leistungserfassung_f1.document.leistungen_f1.datum_leistung.value)==0 ) {
	      //alert("Sonntag");
	      if('$werte[6]' != '0') {
		alert("zuschlag"+'$werte[6]');
		document.leistungen_f2.box_name_$werte[6].checked=true;
		process_$werte[6]($werte[4]); // Original Betrag mitgeben
                if ('$z_art_sonntag' != '+') {
                // es handelt sich nicht um Zuschlag, sondern andere Leistung
                  document.leistungen_f2.box_name_$werte[1].checked=false;
                  tag.firstChild.nodeValue=" ";
                }
	      }
	    }
	} else {
	  tag.firstChild.data="0.00";
          tag.firstChild.className='td';
	}
	  
    }
  </script>
SCRIPT_KNOPF
    print "<td align=right id='td_$werte[1]_betrag'>&nbsp;</td>\n";
    print "</tr>\n";
  }
  print "</tbody><br></table>";
}

