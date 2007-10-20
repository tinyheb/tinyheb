#!/usr/bin/perl -w
# -d:ptkdb
# -wT

# extrahiert aus Schlüsseldateien des Trust Center ITSG die einzelnen
# Schlüssel

# $Id: key.pl,v 1.11 2007-10-20 07:54:06 thomas_baum Exp $
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
# author: Thomas Baum
# datum : 03.10.2005

use strict;
use Date::Calc qw(This_Year Decode_Month Add_Delta_DHMS);
use Getopt::Std;
use File::Copy;

use lib '../';
use Heb_krankenkassen;
use Heb;

my $k = new Heb_krankenkassen;
my $h = new Heb;

my $openssl ='openssl';
my $root_cert_counter=0;

$openssl = $h->win32_openssl() if ($^O =~ /MSWin32/);


if (!defined($openssl)) {
  die "konnte openssl Installation nicht finden\n";
}

my %option = ();
getopts("cstvp:f:o:hu",\%option);

if ($option{h}) {
  print "
 usage:  $0 options dateien pfad
 -v <-> debug/verbose
 -p <-> path
 -f <-> file
 -o <-> output path
 -u <-> update auf Datenbank
 -t <-> hTml formatierte Ausgabe
 -s <-> speichert die einzelnen Zertifikate in jeweils eigener Datei
 -c <-> speichert Zertifikat der Hebamme im korrekten Verzeichnis
 -h <-> help
";
  exit;
}




use lib "../";
my $debug = $option{v} || 0;
my $save_cert = $option{c} || '';
my $eingabe = $option{f} || '';
my $pfad = $option{p} || '';
my $o_pfad = $option{o} || 'keys/';
my $html = $option{t} || '';
my $save = $option{s} || 0;



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
$path='/tmp/wwwrun/' if ($html);

if (!(-d "$o_pfad") && $save) {
  die "der Ausgabepfad: $o_pfad existiert nicht, bitte anlegen\n";
}

print "<table>" if $html;

		     

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
  unlink("$path/tmpcert.pem");
  open SCHREIB, ">$path/tmpcert.pem"
    or die "Konnte Datei nicht zum schreiben öffnen $!\n";
  
  print SCHREIB "-----BEGIN CERTIFICATE-----\n";
 LINE:while ($zeile=<FILE>) {
    my $ent = chomp($zeile);
    if (length($zeile)>1) {
      print SCHREIB $zeile."\n";
      $erg .= $zeile."\n";
    } else {
      print SCHREIB "-----END CERTIFICATE-----\n";
      close(SCHREIB);

      my $serial=get_serial("$path/tmpcert.pem") or 
	die "konnte Seriennummer eines Zertifikates nicht ermittlen\n";
      print "Seriennummer $serial\n" if $debug;

      my ($pubkey_laenge,$algorithmus)=get_public_key("$path/tmpcert.pem");
      print "public key: $pubkey_laenge, algo: $algorithmus\n" if $debug;

      $ik=get_ik("$path/tmpcert.pem");
      if ($pubkey_laenge < 2000) {
	print "Schlüssel zu kurz für IK: $ik Schlüssellänge: $pubkey_laenge < 2000 entweder die Datei annahme-pkcs.key oder gesamt-pkcs.key einspielen, die Vearbeitung wird abgebrochen\n";
	die;
      }


      print "Einlesen Schlüssel für IK: $ik\n" if $debug && $ik;
      if ($ik) {
	copy("$path/tmpcert.pem","$o_pfad/$ik.pem") if (-e "$path/tmpcert.pem" && $save);
      } else {
	print "keine IK Nummer im Zertifikat enthalten\n" if $debug;
	$root_cert_counter++;
	copy("$path/tmpcert.pem","$o_pfad/root$root_cert_counter.pem") if (-e "$path/tmpcert.pem" && $save);
      }
      if ($ik && $save_cert && $ik eq $h->parm_unique('HEB_IK')) {
	if (-e "$path/tmpcert.pem") {
	  copy("$path/tmpcert.pem","$orig_path/privkey/$ik.pem");
	  print "Habe Zerfikat fuer $ik nach $orig_path/privkey/$ik.pem kopiert\n";
	}
      }

      my($start,$ende)=get_dates("$path/tmpcert.pem");
      my $organisation=get_organisation("$path/tmpcert.pem");
      my $ansprechpartner=get_ansprechpartner("$path/tmpcert.pem");
      my $herausgeber=get_herausgeber("$path/tmpcert.pem");
      if ($ik && 
	  $herausgeber !~ /ITSG TrustCenter fuer sonstige Leistungserbringer/ && 
	  $herausgeber !~ /DKTIG TrustCenter fuer Krankenhaeuser und Leistungserbringer PKC/) {
	print "Herausgeber des Schlüssels/ Zertifikats ist nicht das Trustcenter für sonstige Leistungserbringer, Verarbeitung wird abgebrochen\n";
	die;
      }
#      create_parms($ik) if ($ik);
      print_html($ik,$organisation,$ansprechpartner,$start,$ende,$herausgeber,$serial,$pubkey_laenge,$algorithmus) if ($html && $ik);      

     if ($ik && $option{u} && $k->krankenkasse_sel('NAME',$ik)) {
	# kasse existiert update machen
	$k->krankenkassen_up_pubkey($erg,$ik);
      }

      $erg = '';
      $ik=0;

      # nächste Datei zum Schreiben öffnen
      unlink("$path/tmpcert.pem");
      open SCHREIB, ">$path/tmpcert.pem"
	or die "Konnte Datei nicht zum schreiben öffnen $!\n";
      print SCHREIB "-----BEGIN CERTIFICATE-----\n";

      print "------------------------------\n" if $debug;
    }
  }
  close (FILE);
  print SCHREIB "-----END CERTIFICATE-----\n";
  close (SCHREIB);
}
unlink("$path/tmpcert.pem");

print "</table>" if $html;



sub get_ik {
  # holt ik Nummer aus Zertifikat
  my ($cert_name) = @_;
  system("$openssl x509 -in $cert_name -subject -noout") if $debug;
  open LESNAME,"$openssl x509 -in $cert_name -subject -noout |" or 
    die "konnte aus Zertifikat keine IK Nummer ermitteln\n";
  my $name=<LESNAME>;
  close(LESNAME);
  if ($name =~ /OU=IK(\d{9})/) {
    return $1;
  } else {
    return undef;
  }
}

sub get_dates {
  # holt Gültigkeitszeitraum aus Zertifikat
  my ($cert_name) = @_;
  system("$openssl x509 -in $cert_name -dates -noout") if $debug;
  open LESNAME,"$openssl x509 -in $cert_name -dates -noout |" or 
    die "konnte aus Zertifikat keine Gültigkeitsdauer ermitteln\n";
  my $guelt_von=undef;
  my $guelt_bis=undef;
  while (my $name=<LESNAME>) {
    if ($name =~ /^notBefore=(.*?)$/) {
      $guelt_von=$1;
    }
    if ($name =~ /^notAfter=(.*?)$/) {
      $guelt_bis=$1;
    }
  }
  close(LESNAME);
  return ($guelt_von,$guelt_bis);
}

sub get_serial {
  # holt Serien-Nummer aus Zertifikat
  my ($cert_name) = @_;
  system("$openssl x509 -in $cert_name -serial -noout") if $debug;
  open LESNAME,"$openssl x509 -in $cert_name -serial -noout |" or 
    die "konnte aus Zertifikat keine Seriennummer ermitteln\n";
  my $name=<LESNAME>;
  close(LESNAME);
  if ($name =~ /^serial=(.*?)$/) {
    return hex($1);
  } else {
    return undef;
  }
}

sub get_organisation {
  # holt Organisation aus Zertifikat
  my ($cert_name) = @_;
  system("$openssl x509 -in $cert_name -subject -noout") if $debug;
  open LESNAME,"$openssl x509 -in $cert_name -subject -noout |" or 
    die "konnte aus Zertifikat keine Organisation ermitteln\n";
  my $name=<LESNAME>;
  close(LESNAME);
  if ($name =~ /OU=(.*?)\/OU=/) {
    return $1;
  } else {
    return undef;
  }
}


sub get_ansprechpartner {
  # holt Organisation aus Zertifikat
  my ($cert_name) = @_;
  system("$openssl x509 -in $cert_name -subject -noout") if $debug;
  open LESNAME,"$openssl x509 -in $cert_name -subject -noout |" or 
    die "konnte aus Zertifikat keinen Ansprechpartner ermitteln\n";
  my $name=<LESNAME>;
  close(LESNAME);
  if ($name =~ /CN=(.*?)$/) {
    return $1;
  } else {
    return undef;
  }
}

sub get_herausgeber {
  # holt Herausgeber aus Zertifikat
  my ($cert_name) = @_;
  system("$openssl x509 -in $cert_name -subject -noout") if $debug;
  open LESNAME,"$openssl x509 -in $cert_name -subject -noout |" or 
    die "konnte aus Zertifikat keinen Herausgeber (Issuer) ermitteln\n";
  my $name=<LESNAME>;
  close(LESNAME);
  if ($name =~ /O=(.*?)\/OU/) {
    return $1;
  } else {
    return undef;
  }
}


sub get_public_key {
  # holt länge des public key und algorithmus aus Zertifikat
  my ($cert_name) = @_;
  system("$openssl x509 -in $cert_name -certopt no_header -certopt no_serial -certopt no_subject -certopt no_sigdump -certopt no_validity -certopt no_issuer -certopt no_signame -noout -text") if $debug;
  open LESNAME,"$openssl x509 -in $cert_name -certopt no_header -certopt no_subject -certopt no_sigdump -certopt no_validity -certopt no_serial -certopt no_version -certopt no_issuer -certopt no_signame -noout -text |" or 
    die "konnte aus Zertifikat keinen Public key ermitteln\n";

  my $pubkey_laenge=0;
  my $algorithmus='';
  while(my $zeile=<LESNAME>) {
    if ($zeile =~ /Public Key Algorithm: (.*?)$/) {
      $algorithmus = $1;
    }
    if ($zeile =~ /Public Key: \((\d{1,4}) bit/) {
      $pubkey_laenge = $1;
    }
  }
  close(LESNAME);
  return ($pubkey_laenge,$algorithmus) if ($pubkey_laenge > 0 && $algorithmus ne '');
  return undef;
}


sub print_html {
  # ausgabe der ermittleten Infos als HTML
  my ($ik,$organisation,$ansprechpartner,$guelt_von,$guelt_bis,$herausgeber,$serial,$pubkey_laenge,$algorithmus)=@_;

  my ($kname)=$k->krankenkasse_sel('KNAME',$ik);
  my $print_name = $kname;
  $print_name ='' unless(defined($kname));
  print "<tr><td>";

  print "<h2>&nbsp;</h2>\n";
  print '<table border="1" align="left" style="margin-bottom: +2em; width: 16cm; empty-cells: show">';
  print "<caption style='caption-side: top;'><h2>$ik $print_name</h2></caption>\n";
  print "<tr>\n";
  print "<th style='width:2cm; text-align:left'>Feld</th><th style='width:9cm; text-align:left'>Wert</th></tr>\n";
  print "<tr><td>Seriennummer</td><td style='vertical-align:top'>$serial</td></tr>\n";
  print "<tr><td>Organisation</td><td style='vertical-align:top'>$organisation</td></tr>\n";
  print "<tr><td>Ansprechpartner</td><td style='vertical-align:top'>$ansprechpartner</td></tr>\n";
  print "<tr><td>Gültig von</td><td style='vertical-align:top'>$guelt_von</td></tr>\n";
  print "<tr><td>Gültig bis</td><td style='vertical-align:top'>$guelt_bis</td></tr>\n";
  print "<tr><td>Herausgeber</td><td style='vertical-align:top'>$herausgeber</td></tr>\n";
  print "<tr><td>Länge des Schlüssels</td><td style='vertical-align:top'>$pubkey_laenge bit</td></tr>\n";
  print "<tr><td>Algorithmus des Schlüssels</td><td style='vertical-align:top'>$algorithmus</td></tr>\n";
  my $test_ind = $h->parm_unique('IK'.$ik);
  my ($ktr,$da)=$k->krankenkasse_ktr_da($ik);
  my $status_edi='';
  $status_edi = 'bisher kein Schlüssel' unless(defined($test_ind));
  $status_edi .= ', wird nicht angelegt, weil keine Datenannahmestelle' if($da != $ik && $da != 0 || !(defined($kname)));
  $status_edi='Testphase' if (defined($test_ind) && $test_ind == 0);
  $status_edi='Erprobungsphase' if (defined($test_ind) && $test_ind == 1);
  $status_edi='Echtbetrieb' if (defined($test_ind) && $test_ind == 2);
  print "<tr><td>Status Datenaustausch</td><td style='vertical-align:top'>$status_edi</td></tr>\n";
  print "</table><br/><br/>\n\n";
  print "</td></tr>";
}



sub create_parms {
  # legt Parameter an, falls zur Datennahmestelle noch keine
  # vorhanden sind
  my ($ik)=@_;
  my ($kname,$email)=$k->krankenkasse_sel('KNAME,EMAIL',$ik);
  if (defined($kname)) {
    my $test_ind = $h->parm_unique('IK'.$ik);
    if (defined($test_ind)) {
      print "Datenannahmestelle $ik ist schon im Datenhaushalt mit: $test_ind\n";
      print "<br/>" if ($html);
    } else {
      my ($ktr,$da)=$k->krankenkasse_ktr_da($ik);
      print "$ik ist nicht im Datenhaushalt,\nKTR: $ktr, DA: $da ";
      print "<br/>" if ($html);
      if ($da == $ik || $da == 0) {
	print "wird als Datenannahmestelle angelegt\n";
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
	print "wird nicht angelegt, weil keine Datenannahmestelle\n" if(!$html);
      }
    }
  } else {
    print "ist weder Datenannahmestelle noch Krankenkasse\n" if(!$html);
    print "<br/>" if ($html);
  }
  
}

1;
