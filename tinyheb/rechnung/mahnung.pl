#!/usr/bin/perl -w
# -wT

# Erzeugen einer Mahnung und Druckoutput (Postscript)

# Copyright (C) 2006 Thomas Baum <thomas.baum@arcor.de>
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

use PostScript::Simple;
use Date::Calc qw(Today);
use strict;
use CGI;

use lib "../";
use Heb_stammdaten;
use Heb_krankenkassen;
use Heb_leistung;
use Heb_datum;

my $s = new Heb_stammdaten;
my $k = new Heb_krankenkassen;
my $l = new Heb_leistung;
my $d = new Heb_datum;
my $h = new Heb;

my $q = new CGI;

my @kinder = ('Einlinge','Zwillinge','Drillinge','Vierlinge');
my $frau_id = $q->param('frau_id') || -1;
#my $frau_id = $ARGV[0] || 6;
my $seite=1;
my $rechnr = $q->param('rechnr') || 0;
my $datum = $ARGV[2] || $d->convert_tmj(sprintf "%4.4u-%2.2u-%2.2u",Today());
my $speichern = $q->param("speichern") || '';
my $posnr=-1;

# zunächst daten der Frau holen
my ($vorname,$nachname,$geb_frau,$geb_kind,$plz,$ort,$tel,$strasse,
    $anz_kinder,$entfernung_frau,$kv_nummer,$kv_gueltig,$versichertenstatus,
    $dummy,$naechste_hebamme,
    $begruendung_nicht_nae_heb) = $s->stammdaten_frau_id($frau_id);
$entfernung_frau =~ s/\./,/g;
$plz = sprintf "%5.5u",$plz;


# rechnungsinfos holen
$l->rechnung_such("RECH_DATUM,MAHN_DATUM,BETRAGGEZ,BETRAG,STATUS,IK","RECHNUNGSNR=$rechnr");
my ($rech_datum,$mahn_datum,$betraggez,$betrag,$status,$ik_krankenkasse)=$l->rechnung_such_next();
$rech_datum = $d->convert_tmj($rech_datum);

my  ($name_krankenkasse,
     $kname_krankenkasse,
     $plz_krankenkasse,
     $plz_post_krankenkasse,
     $ort_krankenkasse,
     $strasse_krankenkasse,
     $postfach_krankenkasse) = $k->krankenkasse_sel('NAME,KNAME,PLZ_HAUS,PLZ_POST,ORT,STRASSE,POSTFACH',$ik_krankenkasse);

$name_krankenkasse = '' unless (defined($name_krankenkasse));
$kname_krankenkasse = '' unless (defined($kname_krankenkasse));
$plz_krankenkasse = 0 unless (defined($plz_krankenkasse));
$plz_post_krankenkasse = 0 unless (defined($plz_post_krankenkasse));
$strasse_krankenkasse = '' unless (defined($strasse_krankenkasse));
$postfach_krankenkasse = '' unless (defined($postfach_krankenkasse));
$plz_krankenkasse = sprintf "%5.5u",$plz_krankenkasse;
$plz_post_krankenkasse = sprintf "%5.5u",$plz_post_krankenkasse;


my $font ="Helvetica-iso";
my $font_b = "Helvetica-Bold-iso";
my $y_font = 0.410;

my $p = new PostScript::Simple(papersize => "A4",
#			       color => 1,
			       eps => 0,
			       units => "cm",
			       reencode => "ISOLatin1Encoding");

my $x1=2;
my $y1=0;

$p->newpage;
wasserzeichen();
anschrift();

my $mahnnr=1;
$mahnnr = $status - 24 if ($status > 25);

# Betreff Zeile
$p->setfont($font_b,12);
$p->text(2,19.7,"$mahnnr. Mahnung");
$p->setfont($font,10);

fussnote(); # auf der ersten Seite explizit angeben

# Falz  ausgeben
$p->setlinewidth(0.015);
$p->line(0,19,0.3,19);
$p->line(20.7,19,21,19);
$p->setlinewidth(0.04);

# Mahnungsssummen ausgeben
$y1=18.5;
$p->setfont($font_b,10);
$p->text($x1,$y1,"Rechnungs-Nummer: $rechnr vom $rech_datum");
$y1-=$y_font;$y1-=$y_font;

$p->setfont($font,10);
my $offen = $betrag - $betraggez;
$offen = sprintf "%.2f",$offen;
$offen =~ s/\./,/g;
$p->text($x1,$y1,"Gesamtbetrag der Rechnung:");
$betrag = sprintf "%.2f",$betrag;
$betrag =~ s/\./,/g;
$p->text({align => 'right'},17.3,$y1,$betrag." EUR");
$y1-=$y_font;
$p->text($x1,$y1,"bisher eingegangen:");
$betraggez = sprintf "%.2f",$betraggez;
$betraggez =~ s/\./,/g;
$p->text({align => 'right'},17.3,$y1,$betraggez." EUR");
$y1-=0.05;
$p->line(17.4,$y1,15.1,$y1);$y1-=$y_font-0.1;
$p->text($x1,$y1,"offenstehender Betrag:");
$p->text({align => 'right'},17.3,$y1,$offen." EUR");
$y1-=$y_font;

# Abschlusstext ausgeben
$y1-=$y_font;
if ($versichertenstatus ne 'privat') {
  # gesetzlich
  $p->text($x1,$y1,"Sehr geehrte Damen und Herren,");
  $y1-=$y_font;$y1-=$y_font;
  $p->text($x1,$y1,"bisher konnte ich keinen vollständigen Zahlungseingang feststellen. Nach §5 Absatz 4 HebGV sind");
  $y1-=$y_font;
  $p->text($x1,$y1,"Krankenkassen verpflichtet, Hebammenrechnungen spätestens innerhalb von drei Wochen zu");
  $y1-=$y_font;
  $p->text($x1,$y1,"begleichen. Ich bitte Sie, den ausstehenden Betrag unter Angabe der Rechnungsnummer umgehend");
  $y1-=$y_font;
  $p->text($x1,$y1,"zu begleichen.");
} else {
  # Privat
  $p->text($x1,$y1,"Sehr geehrte Frau ".$nachname.",");
  $y1-=$y_font;$y1-=$y_font;
  $p->text($x1,$y1,"bisher konnte ich keinen vollständigen Zahlungseingang feststellen. Ich bitte Sie, den");
  $y1-=$y_font;
  $p->text($x1,$y1,"ausstehenden Betrag unter Angabe der Rechnungsnummer umgehend zu begleichen.");
}
  $y1-=$y_font;$y1-=$y_font;
  $p->text($x1,$y1,"Falls Sie den offenstehenden Betrag bereits beglichen haben, betrachten Sie dieses Schreiben als");
  $y1-=$y_font;
  $p->text($x1,$y1,"gegenstandslos.");

$y1-=$y_font;$y1-=$y_font;$y1-=$y_font;
$p->text($x1,$y1,"Mit freundlichen Grüßen");

# in Browser schreiben, falls Windows wird PDF erzeugt, sonst Postscript
my $all_rech=$p->get();
if ($q->user_agent !~ /Windows/) {
  print $q->header ( -type => "application/postscript", -expires => "-1d");
  $all_rech =~ s/PostScript::Simple generated page/${nachname}_${vorname}/g;
  print $all_rech;
}

if ($q->user_agent =~ /Windows/) {
  print $q->header ( -type => "application/pdf", -expires => "-1d");
  mkdir "/tmp/wwwrun" if(!(-d "/tmp/wwwrun"));
  $p->output('/tmp/wwwrun/file.ps');

  if ($^O =~ /linux/) {
    system('ps2pdf /tmp/wwwrun/file.ps /tmp/wwwrun/file.pdf');
  } elsif ($^O =~ /MSWin32/) {
    unlink('/tmp/wwwrun/file.pdf');
    my $gswin=suche_gswin32();

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

if ($speichern eq 'save') {
  # setzt alle Daten in der Datenbank auf Mahnung und speichert die Rechnung
  $datum = $d->convert($datum);
  $status=$mahnnr+25;
  $status=29 if($status > 29);
  $l->rechnung_up_werte($rechnr,"STATUS=$status,MAHN_DATUM='$datum'");

  # update auf einzelne Leistungspositionen muss noch erfolgen
  $l->leistungsdaten_such_rechnr("ID",$rechnr);
  while (my ($id)=$l->leistungsdaten_such_rechnr_next()) {
    $l->leistungsdaten_up_werte($id,"STATUS=$status");
  }

}

#-----------------------------------------------------------------

sub fussnote {
  $p->setfont($font, 10);
  $p->text(2,1.6, "Bankverbindung: Kto-Nr. ".$h->parm_unique('HEB_Konto').' '.$h->parm_unique('HEB_NAMEBANK').' BLZ '.$h->parm_unique('HEB_BLZ'));
  # Steuernummer ausgeben, wenn vorhanden
  if($h->parm_unique('HEB_STNR')) {
    $p->text(2,1.6-$y_font,'Steuernummer: '.$h->parm_unique('HEB_STNR'));
  }
}


sub wasserzeichen {
  if ($speichern ne 'save') {
    $p->setfont($font_b,60);
    $p->setcolour('grey70');
    $p->text( {rotate => 50,
	       align => 'center'},
	      21/2,28.6/2,"Mahnungsvorschau");
    $p->setcolour('black');
    $p->setfont($font,10);
  }
}


sub anschrift {
  # gibt Anschrift, Rechnungsnummer, etc. aus
  my $x1=12.6; # x werte für kisten
  my $x2=19.4;

  my $y1=27.7;
  # Kiste für Krankenkassen nur ausgeben, wenn keine privat Rechnung
  if ($versichertenstatus ne 'privat') {
    $p->box($x1,25.1,$x2,26.4); # Kiste für Krankenkasse y=25.1 y2=26.4
    $p->setfont($font,8);
    $p->text(12.7,$y1-3*$y_font,"Zahlungspflichtige Kasse (Rechnungsempfänger):");
    $p->setfont($font,10);
    $p->text(12.7,$y1-4*$y_font,"IK:");
    $p->setfont($font_b,10);
    $p->text(15.1,$y1-4*$y_font,$ik_krankenkasse);
    $p->text(12.7,$y1-5*$y_font,$name_krankenkasse);
    $p->setfont($font,10);
    $p->text(12.7,$y1-6*$y_font,$plz_krankenkasse." ".$ort_krankenkasse) if ($plz_krankenkasse ne '' && $plz_krankenkasse > 0);
    $p->text(12.7,$y1-6*$y_font,$plz_post_krankenkasse." ".$ort_krankenkasse) if ($plz_krankenkasse ne '' && $plz_krankenkasse == 0);
    
    $p->box($x1,23.8,$x2,24.6);# Kiste für Mitglied y1=23.8 y2=24.6
    $p->setfont($font,8);
    $y1=24.7;
    $p->text(12.7,$y1,"Mitglied");
    $p->setfont($font_b,10);
    $p->text(12.7,$y1-$y_font,$nachname.", ".$vorname);
    $p->setfont($font,10);
    $p->text(12.7,$y1-2*$y_font,"geboren am");
    $p->text(15.1,$y1-2*$y_font,$geb_frau);
    
    $p->box($x1,21.7,$x2,23.8);# Anschrift und Versichertenstatus y1=21.7 y2=23.8
    $y1=23.4;
    $p->text(12.7,$y1,$plz." ".$ort);
    $p->text(12.7,$y1-$y_font,$strasse);
    $p->text(12.7,$y1-2*$y_font,"Mitgl-Nr.");
    $p->setfont($font_b,10);
    $p->text(15.1,$y1-2*$y_font,$kv_nummer);
    $p->setfont($font,10);
    $p->text(12.7,$y1-3*$y_font,"V-Status:");
    $p->setfont($font_b,10);
    $p->text(15.1,$y1-3*$y_font,$versichertenstatus);
    $p->setfont($font,10);
    $p->text(12.7,$y1-4*$y_font,"gült.bis:");
    $p->setfont($font_b,10);
    my ($m,$j) = unpack("A2A2",$kv_gueltig);
    $p->text(15.1,$y1-4*$y_font,"$m/$j");
    
    
    $p->box($x1,20.8,$x2,21.3);# Kiste für Kind y1=20.8 y2=21.3
    $p->setfont($font,8);
    $y1=21.35;
    $p->text(12.7,$y1,"Kind:");
    $p->setfont($font,10);
    # prüfen ob ET oder Geburtsdatum
    my $geb_kind_et=$d->convert($geb_kind);$geb_kind_et =~ s/-//g;
    my $datum_jmt=$d->convert($datum);$datum_jmt =~ s/-//g;
    # zeilen nur ausgeben, wenn geb Kind gültig ist
    if ($geb_kind_et ne 'error') {
      if ($datum_jmt >= $geb_kind_et) {
	$p->text(12.7,$y1-$y_font,"geboren am");
      } else {
	$p->text(12.7,$y1-$y_font,"ET");
      }
      
      $p->text(15.1,$y1-$y_font,$geb_kind) if($anz_kinder < 2);
      $p->text(15.1,$y1-$y_font,$geb_kind. ' ('.$kinder[$anz_kinder-1].')') if($anz_kinder > 1);
    } else {
      $p->text(12.7,$y1-$y_font,"unbekannt");
    }
  }
  
  # Anschrift der Hebamme
  $p->setfont($font,10);
  $x1=2; $y1=27.8;
  $p->text($x1,$y1,$h->parm_unique('HEB_VORNAME').' '.$h->parm_unique('HEB_NACHNAME'));
  $y1 -= $y_font;
  $p->text($x1,$y1,$h->parm_unique('HEB_STRASSE'));
  $y1 -= $y_font;
  $p->text($x1,$y1,$h->parm_unique('HEB_PLZ').' '.$h->parm_unique('HEB_ORT'));
  $y1 -= $y_font;
  $p->text($x1,$y1,$h->parm_unique('HEB_TEL'));
  $y1 -= $y_font;
  $p->text($x1,$y1,'IK: '.$h->parm_unique('HEB_IK'));
  
  # Absender 
  $p->line($x1,24.6,$x1+9,24.6);
  $p->setfont($font,8);
  my $absender=$h->parm_unique('HEB_VORNAME').' '.$h->parm_unique('HEB_NACHNAME').', '.$h->parm_unique('HEB_STRASSE').', '.$h->parm_unique('HEB_PLZ').' '.$h->parm_unique('HEB_ORT');
  $p->text($x1,24.7,$absender);
  
  # Empfänger
  # zunächst richtige Annahmestelle für Belege holen
  # und zu dieser Anschrift holen,
  
  my ($beleg_ik,$beleg_typ)=$k->krankenkasse_beleg_ik($ik_krankenkasse);
  my $beleg_parm = $h->parm_unique('BELEGE');
  $beleg_ik=$ik_krankenkasse if(!(defined($beleg_parm)) || $beleg_parm != 1);
  my  ($name_krankenkasse_beleg,
       $kname_krankenkasse_beleg,
       $plz_krankenkasse_beleg,
       $plz_post_krankenkasse_beleg,
       $ort_krankenkasse_beleg,
       $strasse_krankenkasse_beleg,
       $postfach_krankenkasse_beleg) = $k->krankenkasse_sel('NAME,KNAME,PLZ_HAUS,PLZ_POST,ORT,STRASSE,POSTFACH',$beleg_ik);
  
  $name_krankenkasse_beleg = '' unless (defined($name_krankenkasse_beleg));
  $kname_krankenkasse_beleg = '' unless (defined($kname_krankenkasse_beleg));
  $plz_krankenkasse_beleg = 0 unless (defined($plz_krankenkasse_beleg));
  $plz_post_krankenkasse_beleg = 0 unless (defined($plz_post_krankenkasse_beleg));
  $strasse_krankenkasse_beleg = '' unless (defined($strasse_krankenkasse_beleg));
  $postfach_krankenkasse_beleg = '' unless (defined($postfach_krankenkasse_beleg));
  
  $plz_krankenkasse_beleg = sprintf "%5.5u",$plz_krankenkasse_beleg;
  $plz_post_krankenkasse_beleg = sprintf "%5.5u",$plz_post_krankenkasse_beleg;
  
  
  # nur dann, wenn keine privat Rechnung
  if ($versichertenstatus ne 'privat') {
    $p->setfont($font,10);
    $y1=23.8;
    $p->text($x1,$y1,$kname_krankenkasse_beleg);
    $p->text($x1,$y1-$y_font,$strasse_krankenkasse_beleg) if ($plz_post_krankenkasse_beleg ne '' && $plz_post_krankenkasse_beleg == 0);
    $p->text($x1,$y1-$y_font,"Postfach $postfach_krankenkasse_beleg") if ($plz_post_krankenkasse_beleg ne '' && $plz_post_krankenkasse_beleg > 0);
    $p->text($x1,$y1-3*$y_font,$plz_krankenkasse_beleg." ".$ort_krankenkasse_beleg) if ($plz_post_krankenkasse_beleg ne '' && $plz_post_krankenkasse_beleg == 0);
    $p->text($x1,$y1-3*$y_font,$plz_post_krankenkasse_beleg." ".$ort_krankenkasse_beleg) if ($plz_post_krankenkasse_beleg ne '' && $plz_post_krankenkasse_beleg > 0);
  }
  
  if ($versichertenstatus eq 'privat') {
    $p->setfont($font,10);
    $y1=23.8;
    $p->text($x1,$y1,$vorname.' '.$nachname);
    $p->text($x1,$y1-$y_font,$strasse);
    $p->text($x1,$y1-3*$y_font,$plz.' '.$ort);
  }
}


sub suche_gswin32 {
  my $gswin32='';
  my $i=0;
  # Suche unterhalb /gs
  while ($i<100) {
    my $pfad="/gs/gs8.$i/bin/gswin32c";
    $gswin32=$pfad if (-e "$pfad.exe");
    $i++;
  }

  $i=0;
  # Suche unterhalb /Programme/gs
  while ($i<100) {
    my $pfad="/Programme/gs/gs8.$i/bin/gswin32c";
    $gswin32=$pfad if (-e "$pfad.exe");
    $i++;
  }

  return $gswin32;
}
