#!/usr/bin/perl -w
# -d:DProf
# -d:ptkdb
# -wT

# extrahiert aus Schlüsseldateien des Trust Center ITSG den Schlüssel der
# Hebamme
# identisch zu key.pl -c
# aber mit Grafischer Oberfläche

# $Id: xkey.pl,v 1.2 2011-01-24 18:52:55 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2008 - 2011 Thomas Baum <thomas.baum@arcor.de>
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

BEGIN {
  if(eval "use Crypt::OpenSSL::X509;1") {
    warn "using Crypt::OpenSSL::X509";
    *main::ssl_func= \&get_all_x509;
  } else {
    warn "using OpenSSL command line";
    *main::ssl_func= \&get_all;
  }
#  *main::ssl_func= \&get_all;
}


use strict;
use Date::Calc qw(This_Year Decode_Month Add_Delta_DHMS);
use Getopt::Std;
use File::Copy;

use Tk;
use Tk::Dialog;
#use Tk::HList;
#use Tk::ItemStyle;


use lib '../';
use Heb;

my $h = new Heb;

my $openssl ='openssl';

$openssl = $h->win32_openssl() if ($^O =~ /MSWin32/);


if (!$openssl) {
  fehler("konnte openssl Installation nicht finden\n");
}

my %option = ();
getopts("cstvp:f:o:hu",\%option);

if ($option{h}) {
  print "
 usage:  $0 options dateien pfad
 -v <-> debug/verbose
";
  exit;
}


my $debug = $option{v} || 0;


my $ik_hebamme=$h->parm_unique('HEB_IK') || '';
my $counter=0; # Zählt die eingelesenen Zertifikate
my $file='';

my $mw = MainWindow->new(-title => 'tinyHeb Zertifikat einlesen',
                         -bg => 'white');

my $menuebar = $mw->Menu;
$mw->configure(-menu => $menuebar);

my $datei = $menuebar->cascade(-label => '~Datei');
$datei->command(
                -label => 'Beenden',
                -command => \&exit,
               );


my $z1_frame = $mw->Frame();
HebLabEntry($z1_frame,'IK der Hebamme',
            {-textvariable => \$ik_hebamme,
#             -state => 'disabled',
            -width => 12})->pack(-side => 'top',
                                -anchor => 'w',
                                );

my $z2_frame=$mw->Frame(
#		       -borderwidth => 3,
#		       -relief => 'raised'
		       );
HebLabEntry($z2_frame,'Dateiname Zertifikatdatei',
            {-textvariable => \$file,
#             -state => 'disabled',
             -width => 70})->pack(-side => 'left',
#                                  -anchor => 'w',
                                 );


my $button_f = $z2_frame->Frame();
$button_f->Label(-text => '',
		 -anchor => 'w')->pack(-side => 'top',
				       -anchor => 'w');

$button_f->Button(-text => 'Auswählen',
                  -command => \&get_filename,
                 )->pack(-side => 'bottom',
#			 -fill => 'both'
                         -anchor => 'w',
                        );
$button_f->pack(
		-side => 'left',
		-anchor => 'w',
	       );




my $z3_frame=$mw->Frame();
$z3_frame->Button(-text => 'Verarbeitung starten',
                  -command => \&process_file,
                 )->pack(-side => 'top',
			 -anchor => 'w'
			);


$z3_frame->Label(-text => 'Verarbeitungsstatus')->pack(-side => 'top',
						       -anchor => 'w',
						      );


my $erg = $z3_frame->Scrolled('Text',
#                             -scrollbars => 'oeoe',
                              -scrollbars => 'se',
                              -width => 80,
                              -height => 20,
                              )->pack(-side => 'bottom',
                                     );

$z1_frame->pack(-side => 'top',
                -expand => 1,
                -fill => 'both'
	       );
$z2_frame->pack(-side => 'top',
                -expand => 1,
                -fill => 'both'
	       );
$z3_frame->pack(-side => 'bottom',
                -expand => 1,
                -fill => 'both');


our $path = $ENV{HOME}; # für temporäre Dateien
if ($^O =~ /MSWin32/) {
  $path .='/tinyheb';
  mkdir "$path" if (!(-d "$path")); # Zielverzeichnis anlegen
} else {
  $path .='/.tinyheb';
}
		   
my $orig_path = $path;

mkdir "$path" if(!(-d "$path"));
if (!(-d "$path/tmp")) { # Zielverzeichnis anlegen
  mkdir "$path/tmp";
}
$path.='/tmp';


MainLoop;

sub get_filename {
  $file = $mw->getOpenFile();
  print "FILE $file\n";
}


sub process_file {

  return fehler("Bitte Dateinamen angeben") unless ($file);
  return fehler("Bitte IK Hebamme angeben") unless ($ik_hebamme);

  # öffnen der Datei mit den Informationen
  open FILE, $file or fehler("Konnte Datei $file nicht zum Lesen öffnen $!\n");
  
  $counter=0;
  my $line_counter = 0; 
  my $zeile = '';
  
  # öffnen Datei zum schreiben
  unlink("$path/tmpcert.pem");
  open SCHREIB, ">$path/tmpcert.pem"
    or fehler("Konnte Datei nicht zum schreiben öffnen $!\n");
  
  print SCHREIB "-----BEGIN CERTIFICATE-----\n";
 LINE:while ($zeile=<FILE>) {
    my $ent = chomp($zeile);
    if (length($zeile)>1) {
      print SCHREIB $zeile."\n";
#      $erg .= $zeile."\n";
    } else {  
      print SCHREIB "-----END CERTIFICATE-----\n";
      close(SCHREIB);
      

      my ($ik,
	  $organisation,
	  $herausgeber,
	  $ansprechpartner,
	  $start,
	  $ende,
	  $serial,
	  $algorithmus,
	  $pubkey_laenge)=ssl_func("$path/tmpcert.pem");

      fehler("konnte Seriennummer eines Zertifikates nicht ermittlen") unless ($serial);
      print "Seriennummer $serial\n" if $debug;
      
      $counter++;
#      my ($pubkey_laenge,$algorithmus)=get_public_key("$path/tmpcert.pem");
      print "public key: $pubkey_laenge, algo: $algorithmus\n" if $debug;
      
      if ($pubkey_laenge < 2000) {
	fehler("Schlüssel zu kurz für IK: $ik Schlüssellänge: $pubkey_laenge < 2000 entweder die Datei annahme-pkcs.key oder gesamt-pkcs.key einspielen, die Vearbeitung wird abgebrochen\n");
	die;
      }
      
      
      print "Einlesen Schlüssel für IK: $ik\n" if $debug; 
      $erg->insert('end',"Einlesen Schlüssel für IK: $ik\n") if $debug;

      if ($ik && $ik eq $ik_hebamme) {
	if (-e "$path/tmpcert.pem") {
	  copy("$path/tmpcert.pem","$orig_path/privkey/$ik.pem");
	  print "Habe Zerfikat fuer $ik nach $orig_path/privkey/$ik.pem kopiert\n";
	  $erg->insert('end',"Habe Zerfikat fuer $ik nach $orig_path/privkey/$ik.pem kopiert\n");
	  $erg->yviewMoveto(1);
	  $mw->update;
	}
      }
      if ($counter % 100 == 0) {
	print "verarbeitete Zertifikate $counter\r" if $debug;
	$erg->insert('end',"verarbeitete Zertifikate $counter\n");
	$erg->yviewMoveto(1);
	$mw->update;
      }

      if ($ik && 
	  $herausgeber !~ /ITSG TrustCenter fuer sonstige Leistungserbringer/ && 
	  $herausgeber !~ /DKTIG TrustCenter fuer Krankenhaeuser und Leistungserbringer PKC/) {
	print "Herausgeber des Schlüssels/ Zertifikats ist nicht das Trustcenter für sonstige Leistungserbringer, Verarbeitung wird abgebrochen\n";
	fehler("Herausgeber des Schlüssels/ Zertifikats ist nicht das Trustcenter für sonstige Leistungserbringer, Verarbeitung wird abgebrochen\n");
	die;
      }
      # nächste Datei zum Schreiben öffnen
      unlink("$path/tmpcert.pem");
      open SCHREIB, ">$path/tmpcert.pem"
        or fehler("Konnte Datei nicht zum schreiben öffnen $!\n");
      print SCHREIB "-----BEGIN CERTIFICATE-----\n";

      print "------------------------------\n" if $debug;

    }
  }
  close (FILE);
  print SCHREIB "-----END CERTIFICATE-----\n";
  close (SCHREIB);

unlink("$path/tmpcert.pem");

print "verarbeitete Zertifikate $counter gesamt\n" if $debug;
$erg->insert('end',"verarbeitete Zertifikate $counter gesamt\n");
$erg->insert('end',"Bitte Ausgaben lesen und Programm beenden\n");

$erg->yviewMoveto(1);
$mw->update;

}

sub get_all {
  my ($cert_name) = @_;
  system("$openssl x509 -in $cert_name -subject -dates -serial -noout -certopt no_header -certopt no_subject -certopt no_sigdump -certopt no_validity -certopt no_serial -certopt no_version -certopt no_issuer -certopt no_signame -text") if $debug;
  open LESNAME,"$openssl x509 -in $cert_name -subject -dates -serial -noout -certopt no_header -certopt no_subject -certopt no_sigdump -certopt no_validity -certopt no_serial -certopt no_version -certopt no_issuer -certopt no_signame -text |" or 
    fehler("konnte aus Zertifikat keine Organisation ermitteln\n");

  my $guelt_von=undef;
  my $guelt_bis=undef;
  my $herausgeber=undef;
  my $ansprechpartner=undef;
  my $organisation=undef;
  my $serial=undef;
  my $ik=undef;
  my $algorithmus=undef;
  my $pubkey_laenge=undef;

  while (my $name=<LESNAME>) {
    if ($name =~ /^notBefore=(.*?)$/) {
      $guelt_von=$1;
    }
    if ($name =~ /^notAfter=(.*?)$/) {
      $guelt_bis=$1;
    }
    if ($name =~ /OU=(.*?)\/OU=/) {
      $organisation=$1;
    }
    if ($name =~ /O=(.*?)\/OU/) {
      $herausgeber=$1;
    }
    if ($name =~ /CN=(.*?)$/) {
      $ansprechpartner=$1;
    }
    if ($name =~ /^serial=(.*?)$/) {
      $serial=hex($1);
    }
    if ($name =~ /OU=IK(\d{9})/) {
      $ik=$1;
    }
    if ($name =~ /Public Key Algorithm: (.*?)$/) {
      $algorithmus = $1;
    }
    if ($name =~ /Public[- ]Key: \((\d{1,4}) bit/) {
      $pubkey_laenge = $1;
    }
  }
  close(LESNAME);
  return ($ik,$organisation,$herausgeber,$ansprechpartner,$guelt_von,$guelt_bis,$serial,$algorithmus,$pubkey_laenge);

}


sub get_all_x509 {
  my ($cert_name) = @_;
  my $x509 = Crypt::OpenSSL::X509->new_from_file($cert_name);

  my $guelt_von=$x509->notBefore();
  my $guelt_bis=$x509->notAfter();
  my $herausgeber=$x509->issuer();
  my $ansprechpartner=undef;
  my $organisation='';
  my $serial=hex($x509->serial());
  my $ik=undef;
  my $algorithmus='';
  my $pubkey=$x509->pubkey();
  my $modulus=$x509->modulus();
  my $pubkey_laenge=length($modulus)*4;
  my $cert=$x509->as_string(1);

  my $name = $x509->subject();


  (undef,undef,$organisation,$ik,$ansprechpartner) = split ',',$name;
  $organisation = '' unless($organisation);
  $organisation =~ s/ OU=//;
  $ik = '' unless($ik);
  $ik =~ s/ OU=IK//;
  $ansprechpartner='' unless($ansprechpartner);
  $ansprechpartner =~ s/ CN=//;

  (undef,$herausgeber) = split ',',$herausgeber;
  $herausgeber =~ s/ O=//;

  return ($ik,$organisation,$herausgeber,$ansprechpartner,$guelt_von,$guelt_bis,$serial,$algorithmus,$pubkey_laenge);

}




sub fehler {
  my ($text)=@_;
  $mw->messageBox(-title => 'Nachricht',
                  -type => 'OK',
                  -message => "$text\n",
                  -default => 'OK'
                 );
}


sub HebLabEntry {
  my ($parent,$label,$parms)=@_;

  my $n_f = $parent->Frame();
  $n_f->Label(-text => $label,
              -anchor => 'w')->pack(-side => 'top',-anchor => 'w');
  $n_f->Entry(%$parms)->pack(-side => 'bottom',-anchor => 'w');
  return $n_f;
}


1;
