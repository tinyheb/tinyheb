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
use Getopt::Std;

my %option = ();
getopts("vcoundp:f:h",\%option);

if ($option{h}) {
  print "
 usage:  $0 options dateien pfad
 -v <-> debug/verbose
 -c <-> check
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

foreach my $file (@dateien) {
  $file = $pfad.$file;
# öffnen der Datei mit den Informationen
open FILE, $file or die "Konnte Datei $file nicht zum Lesen öffnen $!\n";
 
my $line_counter = 0; 
my $zeile = '';

LINE:while ($zeile=<FILE>) {
  chomp($zeile);
  $zeile =~ s/\'\x0d//g;
#  print "zeile1 $zeile\n" if $debug;
  next LINE if ($zeile =~ /\AUNA/); # Beginn überspringen
  next LINE if ($zeile =~ /\AUNB/); # Beginn überspringen

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
    print "--------------KRANKENKASSE ANFANG\n" if $debug;
    until ($zeile =~ /\AUNT/) {
      print "ZEILE $zeile\n" if $debug;
      if ($zeile =~ /\AIDK\+(\d{9})\+(\d{2})\+(\D{0,30})/) {
	$idk = $1;
	$kname = $3;
	$kname =~ s/\?\+/ und /g;
	$kname =~ s/\+/ /g;
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
	# Art der Verknüpfung ist 9 = Verweis auf Papierannahmestelle
	# Verweis ist nicht auf sich selbst
	# Art der Anlieferung ist 7 = digitalisiert
	# oder Papierannahmestelle (9) und Abrechnungscode 50 = Hebamme
	$erg[9]=-1 unless(defined($erg[9]));
	if (($erg[1]==3 && $erg[5]==7 && $erg[2]!=$idk ) || ($erg[1]==9 && $erg[9]==50) && $erg[2] != $idk) {
	  $zentral_idk=$erg[2];
	  $bemerkung = "Zentral IK ohne Kommentar $zeile" if ($erg[1]==3 && $erg[5]==7);
	  $bemerkung = "Papierannahmestelle für Hebammen wegen Abrechnungscode $erg[9] und $zeile" if ($erg[1]==9 && $erg[9]==50);
	}
	# Art der Verknüpfung = 1 Verweis auf Kostenträger
	# Abrechnungscode = 00 alle Leistungsarten oder 50 Hebammen
	# Verweis ist nicht auf sich selbst
	if (($erg[1]==1 && ($erg[9]==00 || $erg[9]==50) && $erg[2]!=$idk)) {
	  $zentral_idk=$erg[2];
	  $bemerkung = "Verweis auf zentralen Kostenträger w/ $zeile";
	}
#	print "--> @erg\n";
      }
      $bemerkung =~ s/'//g;

      if ($zeile =~ /\ANAM\+/) {
	$zeile =~ s/\?\+/ und /g;
	$zeile =~ s/  / /g;
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
	  $erg[4] = '' unless(defined($erg[4]));
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
    $kasse .= "$bemerkung\n";

    print $kasse if($ausgabe);
    print "--------------KRANKENKASSE ENDE\n" if $debug;
    my ($k_ik,$k_kname,$k_name,$k_strasse,$k_plz_haus,$k_plz_post,$k_ort,$k_postfach,$k_asp_name,$k_asp_tel,$k_zik,$k_bemerkung)= $k->krankenkassen_krank_ik($idk);
    if ($check) {
      my ($ik_n,$kname_n,$name_n,$strasse_n,$plz_haus_n,$plz_post_n,$ort_n,$postfach_n,$asp_name_n,$asp_tel_n,$zik_n,$bemerkung_n) = split "\t",$kasse;
      $plz_haus_n=0 if ($plz_haus_n eq '');
      $plz_post_n=0 if ($plz_post_n eq '');
      $bemerkung_n='' unless (defined($bemerkung_n));
      if (!defined($k_ik)) {
	print "Neue Kasse: $kasse";
	$c_neu++;
	$k->krankenkassen_ins($idk,$kname_n,$name_n,$strasse_n,$plz_haus_n,$plz_post_n,$ort_n,$postfach_n,$asp_name_n,$asp_tel_n,$zik_n,$bemerkung_n) if ($update);
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
	    $k_zik eq $zik_n
	   ) {
	  $c_gleich++;
	} else {
	  $c_ungleich++;
	  if ($aus_ungleich) {
	    print "----geaenderte Kasse $k_ik\n";
	    print "war schon im Datenhaushalt neu aus Datei $file\n" if(defined($alle_kassen{$k_ik}));
	    print "ALT\t\tNEU\n";
	    print "NAME $k_name\t\t$name_n\n" if(!($k_name eq $name_n));
	    print "KNAME $k_kname\t\t$kname_n\n" if(!($k_kname eq $kname_n));
	    print "$k_strasse\t\t$strasse_n\n" if(!($k_strasse eq $strasse_n));
	    print "$k_plz_haus\t\t$plz_haus_n\n" if(!($k_plz_haus == $plz_haus_n));
	    print "$k_plz_post\t\t$plz_post_n\n" if(!($k_plz_post == $plz_post_n));
	    print "$k_ort\t\t$ort_n\n" if(!($k_ort eq $ort_n));
	    print "$k_postfach\t\t$postfach_n\n" if(!($k_postfach eq $postfach_n));
	    print "$k_asp_name\t\t$asp_name_n\n" if(!($k_asp_name eq $asp_name_n));
	    print "$k_asp_tel\t\t$asp_tel_n\n" if(!($k_asp_tel eq $asp_tel_n));
	    print "$k_zik\t\t$zik_n\n" if(!($k_zik eq $zik_n));
	    print "$k_bemerkung\t\t$bemerkung_n\n" if(!($k_bemerkung eq $bemerkung_n));
	  }
	  # update auf Datenbank
	  $k->krankenkassen_update($kname_n,$name_n,$strasse_n,$plz_haus_n,$plz_post_n,$ort_n,$postfach_n,$asp_name_n,$asp_tel_n,$zik_n,$bemerkung_n,$k_ik) if ($update);
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
