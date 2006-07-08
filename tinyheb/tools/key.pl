#!/usr/bin/perl -w
# -d:ptkdb
# -wT

# extrahiert aus Schlüsseldateien des Trust Center ITSG die einzelnen
# Schlüssel

# Copyright (C) 2005,2006 Thomas Baum <thomas.baum@arcor.de>
# Thomas Baum, Rubensstr. 3, 42719 Solingen, Germany

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
# author: Thomas Baum
# datum : 03.10.2005

use strict;
use Date::Calc qw(This_Year Decode_Month Add_Delta_DHMS);
use Getopt::Std;

use lib '../';
use Heb_krankenkassen;
use Heb;

my $k = new Heb_krankenkassen;
my $h = new Heb;

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

      my ($kname,$email)=$k->krankenkasse_sel('KNAME,EMAIL',$ik);
      if (defined($kname)) {
	my $test_ind = $h->parm_unique('IK'.$ik);
	if (defined($test_ind)) {
	  print "Datenannahmestelle $ik ist schon im Datenhaushalt mit: $test_ind\n";
	} else {
	  my ($ktr,$da)=$k->krankenkasse_ktr_da($ik);
	  print "Datenannahmestelle $ik ist nicht im Datenhaushalt,\nKTR: $ktr, DA: $da ";
	  if ($da == $ik || $da == 0) {
	    print "wird angelegt\n";
	    print "IK$ik. 00\n";
	    print "DTAUS$ik 1\n";
	    print "SCHL$ik 03\n";
	    print "SIG$ik 00\n";
	    print "MAIL$ik $email\n";
	    if ($option{u}) {
	      $h->parm_ins("IK$ik","00","Datenannahmestelle ($kname) Testindikator 0=Test, 1=Erprobungsphase,2=Produktion");
	      $h->parm_ins("DTAUS$ik","01","Datenaustauschreferenz für diese Datenannahmestelle ($kname)");
	      $h->parm_ins("SCHL$ik","03","Verschlüsselung für diese Datenannahmestelle ($kname)");
	      $h->parm_ins("SIG$ik","00","Signatur für diese Datenannahmestelle ($kname)");
	      $h->parm_ins("MAIL$ik",$email,"Mail Adresse der Datenanname stelle ($kname)");
	    }
	  } else {
	    print "wird nicht angelegt, weil keine Datenannahmestelle\n";
	  }
	}
      }
	

      if ($option{u} && $k->krankenkasse_sel('NAME',$ik)) {
	# kasse existiert update machen
	$k->krankenkassen_up_pubkey($erg,$ik);
      }
      $erg = '';
      $ik=0;
      print "------------------------------\n" if $debug;
    }
  }
  close (FILE);
  print SCHREIB "-----END CERTIFICATE-----\n";
  close (SCHREIB);
}
1;
