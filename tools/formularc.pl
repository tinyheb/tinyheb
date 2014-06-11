#!/usr/bin/perl -w
# -d:ptkdb
# -wT

# Erzeugen Formular Versichertenbestätigung C und Druckoutput (Postscript)

# $Id$
# Tag $Name$

# Copyright (C) 2008 - 2013 Thomas Baum <thomas.baum@arcor.de>
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
use tiny_string_helpers;


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

# als erstes große Rahmenkiste endet unter geplanter Geburtsort
$p->box($x1,19.0-4.9,$x2,1.5);

# Überschrift
$p->setfont($font,10);
$p->text($x1,19.1,'Versichertenbestätigung C: Hebammenhilfe, Abrechnung über ein IK');

# Team oder Hebamem
$p->setfont($font,8);
$p->text($x1+13,19.1,'(Team oder einzelne Hebamme)');


# Horizontale Querlinien
my $y2=14.1;
$p->setlinewidth(0.05);
#$p->line($x1,15,$x2,15); #  Linie über geplanter Geburtsort
$p->setfont($font_b,8);
$p->text($x1+0.1,14.4,'Geplanter Geburtsort zum Zeitpunkt des 2. Vorgespräches:');
$p->line($x1,$y2,$x2,$y2); # Linie unter geplanter Geburtsort

$p->setfont($font_b,8);
$p->text($x1+0.1,13.0,'Bogen-');
$p->text($x1+0.1,13.0-$y_font,'nummer:');


# dicke Linie unter Datum Zeit
$p->line($x1,10.8,$x2,10.8);

my $x3=20.25;
$p->setlinewidth(0.03);

# noch 2 Kisten für Hausgeburt und Geburtshaus
$p->box($x1+8.5+2.3,14.7,$x1+8.9+2.3,14.3);
$p->setfont($font,8);
$p->text($x1+9.1,14.4,'Hausgeburt');

$p->box($x1+8.5+10.1,14.7,$x1+8.9+10.1,14.3);
$p->setfont($font,8);
$p->text($x1+9.1+3,14.4,'Geburtshaus, Hebammenpraxis, Entbindungsheim');


$p->line($x1,12.3,$x2,12.3); # Linie unter Leistungen
$p->setfont($font,10);
$p->text({align => 'right'},6.3,12.4,'Leistungen');

$p->line($x1,11.2,$x3,11.2); # Linie unter Positionsnummern
$p->setfont($font,10);
$p->text({align => 'right'},6.3,11.5,'Positionsnummern');

# jetzt dünne Linien für die einzelnen Bestätigungen
$p->setlinewidth(0.02);
$y1=10.3;
while ($y1 > 1.8) {
  $p->line($x1,$y1,$x2,$y1);
  $y1-=0.55;
}

# senkrechte Querlinien
#$p->line(12.2,19.0,12.2,15.0);
$p->setfont($font,8);
my $y4=18.5;
$p->text($x1+0.1,$y4,'Name der Hebamme (Stempel): '.$h->parm_unique('HEB_VORNAME').' '.$h->parm_unique('HEB_NACHNAME'));

$p->setfont($font_b,8);
$p->text(12.2+0.1,$y4,'IK Hebamme/Team: '.$h->parm_unique('HEB_IK'));
$y4-=2*$y_font;
$p->text(12.2+0.1,$y4,'errechneter ET:               ________________');
$y4-=2*$y_font;
$p->text(12.2+0.1,$y4,'Geburtstag des Kindes: ________________');
$y4-=$y_font;
#$p->text(12.2+0.1,$y4,$h->parm_unique('HEB_TEL'));

#$y4-=(2*$y_font);
#$p->text(12.2+0.1,$y4,'IK-Nummer der Hebamme: '.$h->parm_unique('HEB_IK'));
#$y4-=$y_font;
#$p->text(12.2+0.1,$y4,'IK-Nummer der Klinik:'.$h->parm_unique('HEB_IK_BELEG_KKH')) if ($h->parm_unique('HEB_IK_BELEG_KKH'));

# Querlinie vor Angaben der Versicherten
#$p->line(20,19.0,20,15.0);
$y4=18.5;
$p->setfont($font_b,8);
$p->text(20.2+0.1,$y4,'Name der Versicherten');
$y4-=$y_font;
$p->setfont($font,8);
$p->text(20.2+0.1,$y4,$nachname.", ".$vorname) if($vorname && $nachname);
#$p->text(20.2+0.1,$y4,'Name: ') unless($vorname && $nachname);
$y4-=7*$y_font;
$p->setfont($font_b,8);
$p->text(20.2+0.1,$y4,"Vers-Nr.: $kv_nummer");
$p->setfont($font,8);
$y4-=$y_font;
#$p->text(20.2+0.1,$y4,"V-Status: $versichertenstatus");
#$y4-=$y_font;
#my ($m,$j)=unpack("A2A2",$kv_gueltig);
#$p->text(20.2+0.1,$y4,"gültig bis: $m/$j") if ($kv_gueltig);
#$p->text(20.2+0.1,$y4,"gültig bis:") unless ($kv_gueltig);

$p->setlinewidth(0.05);
$p->line(6.4,$y2,6.4,1.5); # erste Linie dick

$p->setlinewidth(0.02);
$x1=6.9;
$p->setfont($font,6);
$p->text({align => 'center'},$x1-0.25,10.9,'A/E');
$p->text({rotate => 90},$x1-0.25,11.45,'0200');
$p->text({rotate => 90},$x1-0.25,12.4,'Vorgespräch');

$p->line($x1,$y2,$x1,1.5);
$x1+=0.5;
$p->text({rotate => 90},$x1-0.25,11.45,'0300');
$p->text({rotate => 90},$x1-0.25,12.4,'Vorsorge');

$p->line($x1,$y2,$x1,1.5);
$x1+=0.6;
$p->text({rotate => 90},$x1-0.15,11.45,'040x');
$p->text({rotate => 90},$x1-0.4,12.4,'Entnahme von');
$p->text({rotate => 90},$x1-0.1,12.4,'Körpermaterial');

$p->line($x1,$y2,$x1,1.5);
$x1+=0.6;
$p->text({align => 'center'},$x1-0.25,10.9,'A/E');
$p->text({rotate => 90},$x1-0.25,11.45,'060x');
$p->text({rotate => 90},$x1-0.25,12.4,'CTG');

$p->line($x1,$y2,$x1,1.5);
$x1+=0.6;
$p->text({align => 'center'},$x1-0.25,10.9,'A/E');
$p->text({rotate => 90},$x1-0.25,11.45,'0800');
$p->text({rotate => 90},$x1-0.4,12.4,'Einzelgeburts-');
$p->text({rotate => 90},$x1-0.1,12.4,'vorbereitung');

$p->line($x1,$y2,$x1,1.5);
$x1+=0.6;
$p->text({align => 'center'},$x1-0.25,10.9,'A/E');
$p->text({rotate => 90},$x1-0.25,11.25,'050x,051x');
$p->text({rotate => 90},$x1-0.25,12.4,'Hilfeleistung');

$p->line($x1,$y2,$x1,1.5);
$x1+=0.6;
$p->text({align => 'center'},$x1-0.25,10.9,'Z');
$p->text({rotate => 90},$x1-0.25,11.25,'090x,091x');
$p->text({rotate => 90},$x1-0.4,12.4,'Geburtshilfe im');
$p->text({rotate => 90},$x1-0.1,12.4,'Krankenhaus');

$p->line($x1,$y2,$x1,1.5);
$x1+=0.6;
$p->text({align => 'center'},$x1-0.25,10.9,'Z');
$p->text({rotate => 90},$x1-0.4,11.45,'1000-');
$p->text({rotate => 90},$x1-0.1,11.45,'1110');
$p->text({rotate => 90},$x1-0.4,12.4,'Geburtshilfe');
$p->text({rotate => 90},$x1-0.1,12.4,'außerkl. Einricht.');

$p->line($x1,$y2,$x1,1.5);
$x1+=0.7;
$p->text({align => 'center'},$x1-0.25,10.9,'Z');
$p->text({rotate => 90},$x1-0.4,11.45,'1200,');
$p->text({rotate => 90},$x1-0.1,11.45,'1210');
$p->text({rotate => 90},$x1-0.25,12.4,'Hausgeburt');

$p->line($x1,$y2,$x1,1.5);
$x1+=0.65;
$p->text({align => 'center'},$x1-0.25,10.9,'Z');
$p->text({rotate => 90},$x1-0.4,11.45,'130x,');
$p->text({rotate => 90},$x1-0.15,11.45,'131x');
$p->text({rotate => 90},$x1-0.4,12.4,'Hilfe bei');
$p->text({rotate => 90},$x1-0.15,12.4,'Fehlgeburt');

$p->line($x1,$y2,$x1,1.5);
$x1+=0.8;
$p->text({align => 'center'},$x1-0.35,10.9,'E');
$p->text({rotate => 90},$x1-0.4,11.45,'160x,');
$p->text({rotate => 90},$x1-0.1,11.45,'161x');
$p->text({rotate => 90},$x1-0.55,12.4,'Hilfe bei');
$p->text({rotate => 90},$x1-0.35,12.4,'nicht vollendeter');
$p->text({rotate => 90},$x1-0.15,12.4,'Geburt');

$p->line($x1,$y2,$x1,1.5);
$x1+=0.65;
$p->text({align => 'center'},$x1-0.25,10.9,'A/E');
$p->text({rotate => 90},$x1-0.25,11.45,'170x,');
$p->text({rotate => 90},$x1-0.25,11.45,'171x');
$p->text({rotate => 90},$x1-0.4,12.4,'Hilfe bei Geburt');
$p->text({rotate => 90},$x1-0.15,12.4,'2. Hebamme');

$p->line($x1,$y2,$x1,1.5);
$x1+=0.65;
$p->text({align => 'center'},$x1-0.25,10.9,'');
$p->text({rotate => 90},$x1-0.25,11.45,'240x');
$p->text({rotate => 90},$x1-0.4,12.4,'Erstuntersuchung');
$p->text({rotate => 90},$x1-0.15,12.4,'U1');


$p->line($x1,$y2,$x1,1.5);
$x1+=0.65;
$p->text({align => 'center'},$x1-0.25,10.9,'');
$p->text({align => 'center'},$x1-0.25,10.9,'Z');
$p->text({rotate => 90},$x1-0.25,11.45,'3810');
$p->text({rotate => 90},$x1-0.4,12.4,'Neugeborenen-');
$p->text({rotate => 90},$x1-0.1,12.4,'Screening');


$p->line($x1,$y2,$x1,1.5);
$x1+=0.65;
$p->text({align => 'center'},$x1-0.25,10.9,'');
$p->text({rotate => 90},$x1-0.25,11.45,'250x');
$p->text({rotate => 90},$x1-0.4,12.4,'Entnahme von');
$p->text({rotate => 90},$x1-0.15,12.4,'Körpermaterial');

$p->line($x1,$y2,$x1,1.5);
$x1+=0.75;
$p->text({align => 'center'},$x1-0.3,10.9,'A/E');
$p->text({rotate => 90},$x1-0.4,11.45,'260x,');
$p->text({rotate => 90},$x1-0.15,11.45,'261x');
$p->text({rotate => 90},$x1-0.4,12.4,'Überwachnung');
$p->text({rotate => 90},$x1-0.15,12.4,'ärztl. Anordnung');


$p->line($x1,$y2,$x1,1.5);
$x1+=0.7;
$p->text({align => 'center'},$x1-0.25,10.9,'A');
$p->text({rotate => 90},$x1-0.4,11.45,'1800,');
$p->text({rotate => 90},$x1-0.15,11.45,'1810');
$p->text({rotate => 90},$x1-0.4,12.4,'Wochenbett-');
$p->text({rotate => 90},$x1-0.15,12.4,'betreuung');


$p->line($x1,$y2,$x1,1.5);
$x1+=0.75;
$p->text({align => 'center'},$x1-0.35,10.9,'A');
$p->text({rotate => 90},$x1-0.4,11.45,'2100,');
$p->text({rotate => 90},$x1-0.2,11.45,'2110');
$p->text({rotate => 90},$x1-0.55,12.4,'Wobettbetreuung');
$p->text({rotate => 90},$x1-0.35,12.4,'in außerklinischer');
$p->text({rotate => 90},$x1-0.15,12.4,'Einrichtung');




$p->line($x1,$y2,$x1,1.5);
$x1+=0.8;
$p->text({align => 'center'},$x1-0.35,10.9,'A');
$p->text({rotate => 90},$x1-0.4,11.45,'200x,');
$p->text({rotate => 90},$x1-0.2,11.45,'201x');
$p->text({rotate => 90},$x1-0.55,12.4,'Wochenbett-');
$p->text({rotate => 90},$x1-0.35,12.4,'betreuung im');
$p->text({rotate => 90},$x1-0.15,12.4,'Krankenhaus');


$p->line($x1,$y2,$x1,1.5);
$x1+=0.7;
$p->text({rotate => 90},$x1-0.4,11.45,'3900,');
$p->text({rotate => 90},$x1-0.15,11.45,'3910');
$p->text({rotate => 90},$x1-0.4,12.4,'Fäden/Klammern');
$p->text({rotate => 90},$x1-0.15,12.4,'bei Naht entf.');



$p->line($x1,$y2,$x1,1.5);
$x1+=0.8;
$p->text({align => 'center'},$x1-0.35,10.9,'E');
$p->text({rotate => 90},$x1-0.4,11.45,'2800,');
$p->text({rotate => 90},$x1-0.1,11.45,'2810');
$p->text({rotate => 90},$x1-0.55,12.4,'Beratung Stillen/');
$p->text({rotate => 90},$x1-0.35,12.4,'Ernährung');
$p->text({rotate => 90},$x1-0.15,12.4,'Säugling');

$p->setlinewidth(0.05);
$p->line($x1,$y2,$x1,1.5); # letzte Linie auch dick
# noch Kiste um Name der Versicherten
$p->box($x1,$y2,$x2,19.0);
# Linie über Rechnungsnummer
$p->line($x1,$y2+0.8,$x2,$y2+0.8); 


$p->setlinewidth(0.02);


# Rechnungsnummer da jetzt $x1 auf richtigem Wert steht
$x1+=0.1;
$p->setfont($font_b,8);
$p->text($x1,14.4,"Rechnungsnummer:");

# unter Rechnungsnummer jetzt Erläuterungstext
$p->setfont($font_b,8);
$p->text($x1,14.4-0.6,'Zutreffende Leistungen bitte ankreuzen');
$p->setfont($font,8);
$y1=14.4-0.9;
$p->text($x1,$y1,'A/E = Zeitangabe von/bis');
$y1=14.4-1.2;
$p->text($x1,$y1,'Z = Zeitpunkt der Geburt');
$y1-=0.35;
$p->text($x1,$y1,'A = Zeitpunkt des Beginns der Leistung');
$y1-=0.35;
$p->text($x1,$y1,'sonst: keine Zeitangabe erforderlich');


# Texte Entbindungstermin etc. da jetzt $x1 auf richtigem Wert steht
$x1+=0.1;
$p->setfont($font_b,8);
#$p->text($x1,14.4,"Entbindungstermin:");
# prüfen ob ET oder Geburtsdatum
my $geb_kind_et=$d->convert($geb_kind);
$geb_kind_et =~ s/-//g if($geb_kind_et);
my $datum_jmt=$d->convert($datum);
$datum_jmt =~ s/-//g if($datum_jmt);
# zeilen nur ausgeben, wenn geb Kind gültig ist
if ($geb_kind_et && $geb_kind_et ne 'error') {
  if($datum_jmt >= $geb_kind_et && !$kzetgt || $kzetgt == 1) {
    # geburtsdatum
    $p->text($x1+6.7,14.4,"$geb_kind");
  } else {
    # errechneter Termin
    $p->text($x1+2.8,14.4,"$geb_kind");
  }
}



#$p->setfont($font_b,8);
#$p->text($x1+4.5,14.4,"Tag der Geburt:");

$p->text($x1+2.5,11.5,"Unterschrift der Versicherten");

# Datum Zeit und entsprechende vertikale Linie
$x1=2.8;
$p->line($x1,11.2,$x1,1.5);

$p->text($x1-1.3,10.9,'Datum');
$p->text($x1+1.5,10.9,'Zeit');





# in Browser schreiben, falls Windows wird PDF erzeugt, sonst Postscript
my $all_rech=$p->get();
$all_rech =~ s/Portrait/Landscape/;
if ($q->user_agent !~ /Windows/) {
  my $filename = string2filename("Versichertenbestaetigung_Hilfe_${nachname}.ps");
  print $q->header ( -type => "application/postscript", -expires => "-1d", -content_disposition => "inline; filename=$filename");
  $all_rech =~ s/PostScript::Simple generated page/${nachname}_${vorname}/g;
  print $all_rech;
}

if ($q->user_agent =~ /Windows/) {
  my $filename = string2filename("Versichertenbestaetigung_Hilfe_${nachname}.pdf");
  print $q->header ( -type => "application/pdf", -expires => "-1d", -content_disposition => "inline; filename=$filename");
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
    $gswin='"'.$gswin.'"';
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

