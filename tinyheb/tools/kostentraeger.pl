#!/usr/bin/perl -wT
# -d:ptkdb
# -wT

# extrahiert aus Kostenträger Dateien die benötigten Daten

# Copyright (C) 2005,2006 Thomas Baum <thomas.baum@arcor.de>
# Thomas Baum, 42719 Solingen, Germany

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


use strict;
use Date::Calc qw(This_Year Decode_Month Add_Delta_DHMS);
use Getopt::Std;

my %option = ();
getopts("vcoundp:f:h",\%option);

if ($option{h}) {
  print "
 usage:  $0 options dateien pfad
 -v <-> debug/verbose
 -c <-> check (unbedingt notwendig, wenn update gemacht werden soll)
 -o <-> formatierte ausgabe
 -u <-> update
 -n <-> not equal ausgabe ungleiche kassen
 -d <-> delete (prüfen auf gelöschte kassen)
 -p <-> path
 -f <-> file
 -h <-> help
";
  exit;
}
use lib "../";
use Heb_krankenkassen;

my $k = new Heb_krankenkassen;

my $debug = 0;
my $check = 0; # prüfen gegen Datenbank
my $ausgabe = 0; # formatierte ausgabe der kassen ein-/ausschalten
my $update = 0; # soll update auf Datenbank gemacht werden
my $aus_ungleich =0; # ungleiche KK ausgeben
my $loeschen=0; # prüfen auf gelöschte kassen
$debug = 1 if($option{v});
$check = 1 if($option{c});
$ausgabe = 1 if($option{o});
$update = 1 if($option{u});
$aus_ungleich = 1 if($option{n});
$loeschen = 1 if($option{d});

my $c_gleich = 0; # wie viele kassen sind gleich geblieben
my $c_ungleich = 0; # wie viele kassen geändert
my $c_neu = 0; # wie viele kassen neu

my %alle_kassen; # alle in der Datei enthaltenen kassen

my $eingabe = $option{f} || '';
my $pfad = $option{p} || '';

#$eingabe = 'kostentraeger/'.$eingabe;
print "Einlesen der Daten von Datei: $eingabe\n" if $debug;

my @dateien = split ' ',$eingabe;
my $k_typ='';

foreach my $file (@dateien) {
  $k_typ = substr($file,0,2); # Krankenkassentyp z.B. AO=AOK
  $file = $pfad.$file;
  # öffnen der Datei mit den Informationen
  open (FILE, "<:raw",$file) or die "Konnte Datei $file nicht zum Lesen öffnen $!\n";
 
my $line_counter = 0; 
my $zeile = '';

LINE:while ($zeile=<FILE>) {
  $zeile =~ s/\'\x0d\x0a//g;
  next LINE if ($zeile =~ /\AUNA/); # Beginn überspringen
  
  if ($zeile =~ /\AUNB/) {
    my @erg = split '\+',$zeile;
    $k_typ = substr($erg[7],0,2);
    print "K_TYP neu ermittelt: $k_typ\n" if $debug;
    next LINE;
  }

  if ($zeile =~ /UNH/) { # Krankenkasse kommt
    my $kasse=''; # ergebniss hier ablegen
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
    my $zik_typ = 0; # Typ der Zentral IK 0 keine Zuordnung
    my $beleg_ik = 0; # Gibt es Belegannahmestelle
    my $email = ''; # E-Mail Adresse bei Datenannahmestellen
    my $ktr=0; # Kostenträger zu dieser Krankenkasse
    my $da=0; # Datenannahmestelle zu dieser Krankenkasse
    print "--------------KRANKENKASSE ANFANG\n" if $debug;
    until ($zeile =~ /\AUNT/) {
      print "ZEILE $zeile\n" if $debug;
      if ($zeile =~ /\AIDK\+(\d{9})\+(\d{2})\+(.+)/) {
	$idk = $1;
	$kname = $3;
	$kname =~ s/\?\+/ und /g;
	$kname =~ s/\+/ /g;
	$kname =~ s/\?'/'/g;
	$kname =~ s/  / /g;
	$kname =~ s/ $//;
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
	# Art der Verknüpfung ist 3 = Verweis auf Dateiannahmestelle oder
	# Art der Anlieferung ist 7 = digitalisiert
	# und Abrechnungscode 50 = Hebamme, 00 = alle Leistungsarten
	# 99 für nicht aufgeführte Gruppen
	$erg[9]=-1 unless(defined($erg[9]));
	if ($erg[1]==3 && $erg[5]==7 && 
	    ($erg[9]==00 || $erg[9]==50 || ($erg[9]==99 && $zik_typ < 3))) {
	  # aok haben ring geschlossen über typ 2 Verbindungen, die dürfen
	  # hier nicht berücksichtigt werden
	  if ((uc $k_typ eq 'AO' && $zik_typ < 3) ||
	      # wenn keine aok und es ist schon kostenträger vorhanden,
	      # darf nur mit datenannahmestelle überschrieben werden
	      # wenn kostenträger die gleiche kasse ist
	      ((uc $k_typ ne 'AO') && $idk != $erg[2] && 
	       ($zentral_idk==$idk || $zentral_idk==0))) {
	    $zentral_idk=$erg[2];
	    $da=$zentral_idk;
	    $bemerkung .= "Zentral IK mit Entschlüsselungsbefugnis w/ $zeile\n";
	    $zik_typ=3; # Datenannamestelle mit Entschlüsselungsbefugnis
	  }
	}

	if ($erg[1]==2 && $erg[5]==7 &&
	    ($erg[9]==00 || $erg[9]==50)) {
	  if ($zik_typ < 2) {
	    $zentral_idk=$erg[2];
	    $bemerkung .= "Zentral IK ohne Entschlüsselungsbefugnis w/ $zeile\n";
	    $da=$zentral_idk;
	    $zik_typ=2; # Datenannahmestelle ohne Entschlüsselungsbefugnis
	  }
	}

	# Art der Verknüpfung = 1 Verweis auf Kostenträger
	# Abrechnungscode = 00 alle Leistungsarten oder 50 Hebammen
	if ($erg[1]==1 && ($erg[9]==00 || $erg[9]==50)) {
	  $ktr=$erg[2];
	  $bemerkung .= "Verweis auf zentralen Kostenträger w/ $zeile\n";
	  if ($da == $idk && $erg[2]==$idk) {
	    $zik_typ=3;
	    $zentral_idk=$idk;
	    $ktr=$idk;
	  } elsif ($zik_typ < 3 || $erg[2]!=$idk) {
	    $zentral_idk=$erg[2];
	    $zik_typ=1; # zentraler Kostenträger
	    $ktr=$erg[2];
	  }
	}

	# Art der Verknüpfung ist 9 = Verweis auf Papierannahmestelle
	# Verweis ist nicht auf sich selbst
	# Abrechnungscode 50=Hebamme oder 99 für nicht aufgeführte Gruppen
	# Abrechnungscode 00=für alle Leistungsarten
	# Art der Datenanlieferung ist 21=Rechnung Papier oder 
	# Art der Datenanlieferung ist 28 beinhaltet 21
	#
	if ($erg[1]==9 && 
	    ($erg[9]==50 || $erg[9]==99 || $erg[9]==0) && 
	    ($erg[5]==28 || $erg[5]==21) &&
	    $erg[2] != $idk) {
	  $beleg_ik=$erg[2];
	  $bemerkung .= "Belegannahme w/ $zeile\n";
	}
	#	print "--> @erg\n";
      }
      $bemerkung =~ s/'//g;
      
      # DatenFernUebertragung
      if ($zeile =~ /\ADFU\+/) { 
	my @erg = split '\+',$zeile;
	$email=$erg[7] if ($erg[2] == 70);
	$email =~ s/'//g;
      }

      if ($zeile =~ /\ANAM\+/) {
	$zeile =~ s/\?\+/ und /g;
	my @erg = split '\+',$zeile;
	shift @erg;
	shift @erg;
	$name=join " ",@erg;
	$name =~ s/\?'/'/g;
	$name =~ s/  / /g;
	$name =~ s/ $//;
	print "--> NAME $name\n" if $debug;
      }

      if ($zeile =~ /\AANS\+/) {
	my @erg = split '\+',$zeile;
	if ($erg[1]==1) {
	  $erg[4]='' if(!defined($erg[4]));
	  print "Postanschrift strasse $erg[4]\n" if $debug;
	  $ans_haus{plz}=$erg[2];
	  $ans_haus{ort}=$erg[3];
	  $ans_haus{strasse}=$erg[4];
	}
	if ($erg[1]==2) {
	  print "Postfachanschrift ort $erg[3]\n" if $debug;
	  $ans_post{plz}=$erg[2];
	  $ans_post{ort}=$erg[3];
	  $erg[4] = '' unless(defined($erg[4]));
	  $erg[4] =~ s/Postfach//g;
	  $ans_post{postfach}=$erg[4];
	}
	print "--> @erg" if $debug;
      }
      if ($zeile =~ /\AASP\+/) {
	my @erg = split '\+',$zeile;
	$erg[4]='' if(!defined($erg[4]));
	$asp_name = $erg[4];
	$asp_tel = $erg[2];
	print "--> TEL $asp_tel\n" if $debug;
	print "--> Ansprechpartner $asp_name\n" if $debug;
      }
      print "$zeile\n" if $debug;
      $zeile=<FILE>;
#      chomp($zeile);
      $zeile =~ s/\'\x0d\x0a//g;
    }
    $kasse .= "$idk\t$kname\t$name\t";
    $kasse .= $ans_haus{strasse} if defined($ans_haus{strasse});
    if (defined($ans_haus{plz})) {
      $kasse .= "\t$ans_haus{plz}\t";
    } else {
      $kasse .= "\t\t";
    }
    $kasse .= "$ans_post{plz}" if defined($ans_post{plz});
    if (defined($ans_haus{ort})) {
      $kasse .= "\t$ans_haus{ort}\t";
    } else {
      if (defined($ans_post{ort})) {
	$kasse .= "\t$ans_post{ort}\t";
      } else {
	$kasse .= "\t\t";
      }
    }
    $kasse .=  "$ans_post{postfach}" if defined($ans_post{postfach});
    $asp_name = '' unless(defined($asp_name));
    $kasse .= "\t$asp_name\t";
    $asp_tel = '' unless(defined($asp_tel));
    $kasse .= "$asp_tel\t";
    $kasse .= "$zentral_idk\t";
    $kasse .= "$bemerkung\t";
    $kasse .= "\t"; # Pubkey überspringen
    $kasse .= "$zik_typ\t";
    $kasse .= "$beleg_ik\t";
    if ($email ne '') {
      $kasse .= "$kname <$email>\t\n";
    } else {
      $kasse .="\t\n";
    }

    print $kasse if($ausgabe);
    print "--------------KRANKENKASSE ENDE\n" if $debug;
    my ($k_ik,$k_kname,$k_name,$k_strasse,$k_plz_haus,$k_plz_post,$k_ort,$k_postfach,$k_asp_name,$k_asp_tel,$k_zik,$k_bemerkung,$k_pubkey,$k_zik_typ,$k_beleg_ik,$k_email)= $k->krankenkassen_krank_ik($idk);
    $k_email='' unless(defined($k_email));
    if ($check) {
      my ($ik_n,$kname_n,$name_n,$strasse_n,$plz_haus_n,$plz_post_n,$ort_n,$postfach_n,$asp_name_n,$asp_tel_n,$zik_n,$bemerkung_n,$pubkey_n,$zik_typ_n,$beleg_ik_n,$email_n) = split "\t",$kasse;
      $plz_haus_n=0 if ($plz_haus_n eq '');
      $plz_post_n=0 if ($plz_post_n eq '');
      $bemerkung_n='' unless (defined($bemerkung_n));
      if (!defined($k_ik)) {
	print "Neue Kasse: $kasse";
	$c_neu++;
	$k->krankenkassen_ins($idk,$kname_n,$name_n,$strasse_n,$plz_haus_n,$plz_post_n,$ort_n,$postfach_n,$asp_name_n,$asp_tel_n,$zik_n,$bemerkung_n,$zik_typ_n,$beleg_ik_n,$email_n) if ($update);
      }
      if (defined($k_ik)) {
	if ($k_kname eq $kname_n && 
	    $k_name eq $name_n && 
	    $k_strasse eq $strasse_n &&
	    $k_plz_haus == $plz_haus_n &&
	    $k_plz_post == $plz_post_n &&
	    $k_ort eq $ort_n &&
	    $k_postfach eq $postfach_n &&
	    $k_asp_name eq $asp_name_n &&
	    $k_asp_tel eq $asp_tel_n  &&
	    $k_zik eq $zik_n &&
	    $k_bemerkung eq $bemerkung_n &&
	    $k_zik_typ == $zik_typ_n &&
	    $k_beleg_ik == $beleg_ik_n &&
	    $k_email eq $email_n
	   ) {
	  $c_gleich++;
	} else {
	  $c_ungleich++;
	  if ($aus_ungleich) {
	    print "----geaenderte Kasse $k_ik $k_kname\n";
	    print "war schon im Datenhaushalt neu aus Datei $file\n" if(defined($alle_kassen{$k_ik}));
	    print "ALT\t\t\tNEU\n";
	    print "NAME $k_name\t\t$name_n\n" if(!($k_name eq $name_n));
	    print "KNAME $k_kname\t\t$kname_n\n" if(!($k_kname eq $kname_n));
	    print "$k_strasse\t\t$strasse_n\n" if(!($k_strasse eq $strasse_n));
	    print "PLZ_HAUS $k_plz_haus\t\t$plz_haus_n\n" if(!($k_plz_haus == $plz_haus_n));
	    print "PLZ_POST $k_plz_post\t\t$plz_post_n\n" if(!($k_plz_post == $plz_post_n));
	    print "$k_ort\t\t$ort_n\n" if(!($k_ort eq $ort_n));
	    print "POSTFACH $k_postfach\t\t$postfach_n\n" if(!($k_postfach eq $postfach_n));
	    print "$k_asp_name\t\t$asp_name_n\n" if(!($k_asp_name eq $asp_name_n));
	    print "$k_asp_tel\t\t$asp_tel_n\n" if(!($k_asp_tel eq $asp_tel_n));
	    print "ZIK\t$k_zik\t\t$zik_n\n" if(!($k_zik eq $zik_n));
	    print "ZIK_TYP\t$k_zik_typ\t\t$zik_typ_n\n" if (!($k_zik_typ == $zik_typ_n));
	    print "BELEG_IK\t$k_beleg_ik\t$beleg_ik_n\n" if (!($k_beleg_ik == $beleg_ik_n));
	    print "EMAIL\t$k_email\t$email_n\n" if (!($k_email eq $email_n));
	    print "BEM\t$k_bemerkung\t\t$bemerkung_n\n" if(!($k_bemerkung eq $bemerkung_n));
	  }
	  # update auf Datenbank
	  $k->krankenkassen_update($kname_n,$name_n,$strasse_n,$plz_haus_n,$plz_post_n,$ort_n,$postfach_n,$asp_name_n,$asp_tel_n,$zik_n,$bemerkung_n,$zik_typ,$beleg_ik_n,$email_n,$k_ik) if ($update);
	}
      }
    }
    $alle_kassen{$idk}=$kasse;
  }
}
close FILE;
}

# prüfen ob Krankenkassen nicht mehr existieren
my $c_geloescht=0;
if ($loeschen) {
  my $ik=0;
  while ($ik = $k->krankenkasse_next_ik($ik)) {
    if (!defined($alle_kassen{$ik})) {
      print "Kasse $ik existiert nicht mehr\n";
      $c_geloescht++;
    }
  }
}
print "SUMMEN\n";
print "gleiche Kassen: $c_gleich\n";
print "ungleiche Kassen: $c_ungleich\n";
print "neue Kassen: $c_neu\n";
print "gelöschte Kassen: $c_geloescht\n";

1;
