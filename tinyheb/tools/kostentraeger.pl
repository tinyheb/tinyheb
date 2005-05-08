#!/usr/bin/perl -wT
# -d:ptkdb
# -wT

# version 0.0.1
# extrahiert aus Kostenträger Dateien die benötigten Daten

# author: Thomas Baum
# datum : 24.03.2005
# version : 0.0.1 

use strict;
use Date::Calc qw(This_Year Decode_Month Add_Delta_DHMS);

my $debug = 0;

my $eingabe = $ARGV[0];

#$eingabe = 'kostentraeger/'.$eingabe;
print "Einlesen der Daten von Datei: $eingabe\n" if $debug;

# öffnen der Datei mit den Informationen
open FILE, $eingabe or die "Konnte Datei $eingabe nicht zum Lesen öffnen$!\n";
 
my $line_counter = 0; 
my $zeile = '';

LINE:while ($zeile=<FILE>) {
  chomp($zeile);
  $zeile =~ s/\'\x0d//g;
#  print "zeile1 $zeile\n" if $debug;
  next LINE if ($zeile =~ /\AUNA/); # Beginn überspringen
  next LINE if ($zeile =~ /\AUNB/); # Beginn überspringen

  if ($zeile =~ /UNH/) { # Krankenkasse kommt
    my $idk =0;
    my $zentral_idk = 0;
    my %ans_haus;
    my %ans_post;
    my $kname = '';
    my $guelt_ab=0;
    my $name = '';
    my $asp_name = ''; # Ansprechpartner
    my $asp_tel = ''; # Tel. Ansprechpartner
    my $bemerkung = ''; # zusätzliche Informationen zur KK
    print "--------------KRANKENKASSE ANFANG\n" if $debug;
    until ($zeile =~ /\AUNT/) {
      if ($zeile =~ /\AIDK\+(\d{9})\+(\d{2})\+(\D{0,30})/) {
	$idk = $1;
	$kname = $3;
	print "--> IK: $idk\n" if $debug;
	print "--> Kurzbezeichnung: $kname\n" if $debug;
      }
      if ($zeile =~ /\AVDT\+(\d{8})/) {
	$guelt_ab=$1;
	print "--> gültig ab $guelt_ab\n" if $debug;
      }
      if ($zeile =~ /\AFKT\+(\w{2})/) {
	print "--> Schlüssel-KZ $1\n" if $debug;
      }
      if ($zeile =~ /\AVKG/) {
	my @erg = split '\+',$zeile;
#	print "Verweis für Hebammen an IK $erg[2] Leistungserbringergruppe $erg[3] Standort des Leistungserbringers Bundesland $erg[7] Standort nach KV Bezirk $erg[8] Abrechnungscode $erg[9]\n" if ($erg[1]==9 && $erg[9]==50);

#	print "Verweis Zentralstelle an IK $erg[2] Leistungserbringergruppe $erg[3] Abrechnungscode $erg[9]\n" if ($erg[1]==3 && $erg[5]==7);

	if (($erg[1]==3 && $erg[5]==7 && $erg[2]!=$idk ) || ($erg[1]==9 && $erg[9]==50) && $erg[2] != $idk) {
	  $zentral_idk=$erg[2];
	  $bemerkung = "Zentral IK ohne Kommentar $zeile" if ($erg[1]==3 && $erg[5]==7);
	  $bemerkung = "Papierannahmestelle für Hebammen wegen Abrechnungscode $erg[9] und $zeile" if ($erg[1]==9 && $erg[9]==50);
#	  print "$zentral_idk Zentral IK oder Hebamme\n";
	}
#	print "--> @erg\n";
      }

      if ($zeile =~ /\ANAM\+/) {
	my @erg = split '\+',$zeile;
	shift @erg;
	shift @erg;
	$name=join " ",@erg;
	print "--> NAME $name\n" if $debug;

      }

      if ($zeile =~ /\AANS\+/) {
	my @erg = split '\+',$zeile;
	if ($erg[1]==1) {
	  print "Postanschrift strasse $erg[4]\n" if $debug;
	  $ans_haus{plz}=$erg[2];
	  $ans_haus{ort}=$erg[3];
	  $ans_haus{strasse}=$erg[4];
	}
	if ($erg[1]==2) {
	  print "Postfachanschrift ort $erg[3]\n" if $debug;
	  $ans_post{plz}=$erg[2];
	  $ans_post{ort}=$erg[3];
	  $erg[4] =~ s/Postfach//g;
	  $ans_post{postfach}=$erg[4];
	}
	print "--> @erg" if $debug;
      }
      if ($zeile =~ /\AASP\+/) {
	my @erg = split '\+',$zeile;
	$asp_name = $erg[4];
	$asp_tel = $erg[2];
	print "--> TEL $asp_tel\n" if $debug;
	print "--> Ansprechpartner $asp_name\n" if $debug;
      }
      print "$zeile\n" if $debug;
      $zeile=<FILE>;
      chomp($zeile);
      $zeile =~ s/\'\x0d//g;
    }
    print "$idk\t$kname\t$name\t";
    print $ans_haus{strasse} if defined($ans_haus{strasse});
    if (defined($ans_haus{plz})) {
      print "\t$ans_haus{plz}\t";
    } else {
      print "\t\t";
    }
    print "$ans_post{plz}" if defined($ans_post{plz});
    if (defined($ans_haus{ort})) {
      print "\t$ans_haus{ort}\t";
    } else {
      if (defined($ans_post{ort})) {
	print "\t$ans_post{ort}\t";
      } else {
	print "\t\t";
      }
    }
    print "$ans_post{postfach}" if defined($ans_post{postfach});
    print "\t$asp_name\t";
    print "$asp_tel\t";
    print "$zentral_idk\t";
    print "$bemerkung\n";
    print "--------------KRANKENKASSE ENDE\n" if $debug;
  }
}
close FILE;

1;
