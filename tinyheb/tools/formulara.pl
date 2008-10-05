#!/usr/bin/perl -w
# -d:ptkdb
# -wT

# Erzeugen Formular Versichertenbestätigung A und Druckoutput (Postscript)

# $Id: formulara.pl,v 1.1 2008-10-05 13:50:43 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2008 Thomas Baum <thomas.baum@arcor.de>
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

use lib "../";
#use Devel::Cover -silent => 'On';

use PostScript::Simple;
use Date::Calc qw(Today);
use strict;
use CGI;
use CGI::Carp qw(fatalsToBrowser);

use Heb;
use Heb_stammdaten;
use Heb_datum;

my $s = new Heb_stammdaten;
my $d = new Heb_datum;
my $h = new Heb;

my $q = new CGI;

my $frau_id = $q->param('frau_id') || -1;
my $seite=1;
my $datum = $d->convert_tmj(sprintf "%4.4u-%2.2u-%2.2u",Today());

# zunächst daten der Frau holen
my ($vorname,$nachname,$geb_frau,$geb_kind,$plz,$ort,$tel,$strasse,
    $anz_kinder,$entfernung_frau,$kv_nummer,$kv_gueltig,$versichertenstatus,
    $ik_krankenkasse,$naechste_hebamme,
    $begruendung_nicht_nae_heb,
    $kzetgt,$uhr_kind,$privat_faktor) = $s->stammdaten_frau_id($frau_id);

$entfernung_frau =~ s/\./,/g;
$plz = $plz ? sprintf "%5.5u",$plz : '';


my $font ="Helvetica-iso";
my $font_b = "Helvetica-Bold-iso";
my $y_font = 0.410;

my $p = new PostScript::Simple(papersize => "A4",
#			       color => 1,
			       eps => 0,
			       landscape => 1,
			       units => "cm",
			       reencode => "ISOLatin1Encoding");

my $x1=1;
my $x2=29;
my $y1=0;

$p->newpage;

# als erstes große Rahmenkiste
$p->box($x1,19.0,$x2,1.5);

# Name der Hebamme bei Teambetreuung
$p->setlinewidth(0.05);
$p->line($x1,18.4,12,18.4);
$p->setfont($font,8);
$p->text({align => 'center'},$x1+3,18.6,'Name der Hebamme bei Teambetreuung');
# senkrechte Linie
$p->line($x1+5.8,19,$x1+5.8,15);
# lfd. Heb. Nr.
$p->setfont($font,8);
$p->text({align => 'center'},$x1+6.4,18.5+0.255,'lfd. Heb.');
$p->text({align => 'center'},$x1+6.4,18.5,'Nr.');
$p->line($x1+7,19,$x1+7,15);
# IK der Hebamme
$p->text({align => 'center'},$x1+9,18.6,'IK der Hebamme');

$p->setlinewidth(0.02); # dünne Linien
my $i=1;
for ($i=1;$i<6;$i+=1) {
  $p->line($x1,18.4-$i*0.55,12,18.4-$i*0.55);
  $p->text({align => 'center'},$x1+6.4,18.6-$i*0.55,$i);
}     
$p->text({align => 'center'},$x1+6.4,18.6-$i*0.55,$i);     

# Überschrift
$p->setfont($font_b,12);
$p->text($x1,19.1,'Versichertenbestätigung A: Kurse, Abrechnung über ein oder mehrere IK');


# Horizontale Querlinien
my $y2=14.1;
$p->setlinewidth(0.05);
$p->line($x1,15,$x2,15);
#$p->line(20,$y2,$x2,$y2);

$y2=13.4;

# dicke Linie unter Bogennummer
$p->line($x1,13.4,$x2,13.4);

$p->setlinewidth(0.05);
$p->line(15,$y2,15,1.5); # Mittlere Linie dick

$y2-=0.9;
$p->line($x1,$y2,$x2,$y2);

# prüfen ob ET oder Geburtsdatum
my $geb_datum_et='';
my $geb_datum_gt='';
my $geb_kind_et=$d->convert($geb_kind);
$geb_kind_et =~ s/-//g if($geb_kind_et);
my $datum_jmt=$d->convert($datum);
$datum_jmt =~ s/-//g if($datum_jmt);
# zeilen nur ausgeben, wenn geb Kind gültig ist
if ($geb_kind_et && $geb_kind_et ne 'error') {
  if($datum_jmt >= $geb_kind_et && !$kzetgt || $kzetgt == 1) {
    # geburtsdatum
    $geb_datum_gt=$geb_kind;
  } else {
    # errechneter Termin
    $geb_datum_et=$geb_kind;
  }
}


$p->setfont($font_b,12);
$p->text($x1+0.1,$y2+0.2,"Geburtsvorbereitung in der Gruppe - Errechneter ET: $geb_datum_et");

$p->text(15+0.1,$y2+0.2,"Rückbildungsgymnastik - Geburtstag des Kindes: $geb_datum_gt");


# jetzt dünne Linien für die einzelnen Bestätigungen
$p->setlinewidth(0.02);
$y1=$y2-0.7;
while ($y1 > 1.8) {
  $p->line($x1,$y1,$x2,$y1);
  $y1-=0.45;
}

foreach my $posnr ('070','270') {

  # Überschrift Datum,...
  $y1=$y2-0.6;
  $p->setfont($font,8);
  $p->text({align => 'center'},$x1+1,$y1,'Datum');
  
  # Senkrechte Querlinie und Uhrzeit von
  $p->line($x1+2.1,$y2,$x1+2.1,1.5);
  $y1=$y2-0.6;
  $p->setfont($font,8);
  $p->text({align => 'center'},$x1+2.9,$y1,'Uhrzeit von');
  
  # Senkrechte Querlinie und Uhrzeit bis
  $p->line($x1+3.7,$y2,$x1+3.7,1.5);
  $y1=$y2-0.6;
  $p->setfont($font,8);
  $p->text({align => 'center'},$x1+4.5,$y1,'Uhrzeit bis');
  
  # fette Linie nach Uhrzeit bis
  $p->setlinewidth(0.05);
  $p->line($x1+5.3,$y2,$x1+5.3,1.5); 
  
  # lfd. Heb. Nr.
  $p->setlinewidth(0.02);
  $p->setfont($font,8);
  $p->text({align => 'center'},$x1+5.9,$y1+0.255,'lfd. Heb.');
  $p->text({align => 'center'},$x1+5.9,$y1,'Nr.');
  
  # fette Linie nach lfd. Heb. Nr
  $p->setlinewidth(0.05);
  $p->line($x1+6.4,$y2,$x1+6.4,1.5); 
  
  # lfd. Posnr
  $p->setlinewidth(0.02);
  $p->setfont($font_b,8);
  $p->text({align => 'center'},$x1+6.8,$y1,$posnr);

  # fette Linie nach lfd. Heb. Nr
  $p->setlinewidth(0.05);
  $p->line($x1+7.2,$y2,$x1+7.2,1.5); 
  
  # Unterschrift
  $p->setlinewidth(0.02);
  $p->setfont($font_b,8);
  $p->text({align => 'center'},$x1+10.5,$y1,"Unterschrift der Versicherten");

  $x1=15;
}


# senkrechte Querlinien
$p->setlinewidth(0.05);
$p->line(12,19.0,12,15);
$p->setfont($font_b,8);
my $y4=18.5;
$p->text(12.2+0.1,$y4,'Hebamme: ');
$y4-=$y_font;
$p->setfont($font,8);
$p->text(12.2+0.1,$y4,$h->parm_unique('HEB_VORNAME').' '.$h->parm_unique('HEB_NACHNAME'));
$y4-=$y_font;
$p->text(12.2+0.1,$y4,$h->parm_unique('HEB_STRASSE'));
$y4-=$y_font;
$p->text(12.2+0.1,$y4,$h->parm_unique('HEB_PLZ').' '.$h->parm_unique('HEB_ORT'));
$y4-=$y_font;
$p->text(12.2+0.1,$y4,$h->parm_unique('HEB_TEL'));

$y4-=(2*$y_font);
$p->text(12.2+0.1,$y4,'IK-Nummer der Hebamme: '.$h->parm_unique('HEB_IK'));
$y4-=$y_font;
$p->text(12.2+0.1,$y4,'IK-Nummer der Klinik:'.$h->parm_unique('HEB_IK_BELEG_KKH')) if ($h->parm_unique('HEB_IK_BELEG_KKH'));

# Querlinie vor Angaben der Versicherten
$p->line(20,19.0,20,13.4);
$y4=18.5;
$p->setfont($font_b,8);
$p->text(20.2+0.1,$y4,'Angaben zur Versicherten (Mitglied)');
$y4-=$y_font;
$p->setfont($font,8);
$p->text(20.2+0.1,$y4,'Name: '.$nachname.", ".$vorname) if($vorname && $nachname);
$p->text(20.2+0.1,$y4,'Name: ') unless($vorname && $nachname);
$y4-=$y_font;
$p->text(20.2+0.1,$y4,"Mitgl-Nr.: $kv_nummer");
$y4-=$y_font;
$p->text(20.2+0.1,$y4,"V-Status: $versichertenstatus");
$y4-=$y_font;
my ($m,$j)=unpack("A2A2",$kv_gueltig);
$p->text(20.2+0.1,$y4,"gültig bis: $m/$j") if ($kv_gueltig);
$p->text(20.2+0.1,$y4,"gültig bis:") unless ($kv_gueltig);


$p->setlinewidth(0.02);

$x1=20.2+0.1;
$p->setfont($font_b,10);
$p->text($x1,14.4,'Rechnungsnummer:');
$p->setfont($font,10);
$p->text($x1,13.7,'Bogennummer:');



# Datum Zeit und entsprechende vertikale Linie
#$x1=2.8;
#$p->line($x1,11.4,$x1,1.5);

#$p->text($x1-1.3,10.9,'Datum');
#$p->text($x1+1.5,10.9,'Zeit');


# in Browser schreiben, falls Windows wird PDF erzeugt, sonst Postscript
my $all_rech=$p->get();
$all_rech =~ s/Portrait/Landscape/;
if ($q->user_agent !~ /Windows/) {
  print $q->header ( -type => "application/postscript", -expires => "-1d");
  $all_rech =~ s/PostScript::Simple generated page/${nachname}_${vorname}/g;
  print $all_rech;
}

if ($q->user_agent =~ /Windows/) {
  print $q->header ( -type => "application/pdf", -expires => "-1d");
  if (!(-d "/tmp/wwwrun")) {
    mkdir "/tmp" if (!(-d "/tmp"));
    mkdir "/tmp/wwwrun";
  }
  unlink('/tmp/wwwrun/file.ps');
  $p->output('/tmp/wwwrun/file.ps');

  if ($^O =~ /linux/) {
    system('ps2pdf /tmp/wwwrun/file.ps /tmp/wwwrun/file.pdf');
  } elsif ($^O =~ /MSWin32/) {
    unlink('/tmp/wwwrun/file.pdf');
    my $gswin=$h->suche_gswin32();
    system("$gswin -q -dCompatibilityLevel=1.2 -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=/tmp/wwwrun/file.pdf -c .setpdfwrite -f /tmp/wwwrun/file.ps");
  } else {
    die "kein Konvertierungsprogramm ps2pdf gefunden\n";
  }

  open AUSGABE,"/tmp/wwwrun/file.pdf" or
    die "konnte Datei nicht konvertieren in pdf\n";
  binmode AUSGABE;
  binmode STDOUT;
  while (my $zeile=<AUSGABE>) {
    print $zeile;
  }
  close AUSGABE;
}

