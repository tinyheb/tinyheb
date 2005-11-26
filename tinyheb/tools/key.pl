#!/usr/bin/perl -w
# -d:ptkdb
# -wT

# extrahiert aus Schlüsseldateien des Trust Center ITSG die unterschiedlichen
# dateien

# author: Thomas Baum
# datum : 03.10.2005

use strict;
use Date::Calc qw(This_Year Decode_Month Add_Delta_DHMS);
use Getopt::Std;

use lib '../';
use Heb_krankenkassen;

my $k = new Heb_krankenkassen;

my %option = ();
getopts("vp:f:o:hu",\%option);

if ($option{h}) {
  print "
 usage:  $0 options dateien pfad
 -v <-> debug/verbose
 -p <-> path
 -f <-> file
 -o <-> output path
 -u <-> update auf Datenbank
 -h <-> help
";
  exit;
}
use lib "../";
my $debug = $option{v} || 0;
my $eingabe = $option{f} || '';
my $pfad = $option{p} || '';
my $o_pfad = $option{o} || 'keys/';

#$eingabe = 'kostentraeger/'.$eingabe;
print "Einlesen der Daten von Datei: $eingabe\n" if $debug;

my @dateien = split ' ',$eingabe;

foreach my $file (@dateien) {
  $file = $pfad.$file;
  # öffnen der Datei mit den Informationen
  open FILE, $file or die "Konnte Datei $file nicht zum Lesen öffnen $!\n";
  
  my $line_counter = 0; 
  my $zeile = '';
  my $file_counter = 1; # Zähler für Ausgabe Datei
  my $erg = ''; # ergebnisstring für update auf Datenbank
  my $ik = 0;
  
  # öffnen Datei zum schreiben
  open SCHREIB, ">$o_pfad/datei$file_counter.pem"
    or die "Konnte Datei nicht zum schreiben öffnen $!\n";
  
  print SCHREIB "-----BEGIN CERTIFICATE-----\n";
 LINE:while ($zeile=<FILE>) {
    my $ent = chomp($zeile);
#    $zeile =~ s/\r\n//g;
#    print "laenge:",length($zeile),"z$zeile\n" if $debug;
    if (length($zeile)>1) {
      print SCHREIB $zeile."\n";
      $erg .= $zeile."\n";
    } else {
      print SCHREIB "-----END CERTIFICATE-----\n";
      close(SCHREIB);
      system("openssl x509 -in $o_pfad/datei$file_counter.pem -dates -subject -noout") if $debug;
      system("openssl x509 -in $o_pfad/datei$file_counter.pem -subject -noout > /tmp/key_temp.txt");
      open LESNAME, "/tmp/key_temp.txt";
      my $name=<LESNAME>;
      print "$file_counter --> $name";
      if ($name =~ /OU=IK(\d{9})/) {
	$ik=$1;
	print "IK Nummer :$1\n" if $debug;
	system("mv $o_pfad/datei$file_counter.pem $o_pfad/$1.pem");
	print "Verarbeitet: $1, $file_counter\n";
      }
      close(LESNAME);
      $file_counter++;
      open SCHREIB, ">$o_pfad/datei$file_counter.pem"
	or die "Konnte Datei nicht zum schreiben öffnen $!\n";
      print SCHREIB "-----BEGIN CERTIFICATE-----\n";
      print "------------------------------\n" if $debug;

      if ($option{u} && $k->krankenkasse_sel('NAME',$ik)) {
	# kasse existiert update machen
	$k->krankenkassen_up_pubkey($erg,$ik);
      }
      $erg = '';
      $ik=0;
    }
  }
  close (FILE);
  print SCHREIB "-----END CERTIFICATE-----\n";
  close (SCHREIB);
}
1;
