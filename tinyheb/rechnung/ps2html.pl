#!/usr/bin/perl -w
# -wT

# Erzeugen einer Rechnung und Druckoutput (Postscript)

# $Id: ps2html.pl,v 1.47 2007-10-17 15:36:45 thomas_baum Exp $
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

use PostScript::Simple;
use Date::Calc qw(Today);
use strict;
use CGI;
use CGI::Carp qw(fatalsToBrowser);

use lib "../";
use Heb;
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
my $rechnungsnr = 1+($h->parm_unique('RECHNR'));
my $datum = $ARGV[2] || $d->convert_tmj(sprintf "%4.4u-%2.2u-%2.2u",Today());
my $speichern = $q->param("speichern") || '';
my $posnr=-1;
my $heb_bundesland = $h->parm_unique('HEB_BUNDESLAND') || 'NRW';


# zunächst daten der Frau holen
my ($vorname,$nachname,$geb_frau,$geb_kind,$plz,$ort,$tel,$strasse,
    $anz_kinder,$entfernung_frau,$kv_nummer,$kv_gueltig,$versichertenstatus,
    $ik_krankenkasse,$naechste_hebamme,
    $begruendung_nicht_nae_heb) = $s->stammdaten_frau_id($frau_id);
$entfernung_frau =~ s/\./,/g;
$plz = sprintf "%5.5u",$plz;


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
$ort_krankenkasse = '' unless (defined($ort_krankenkasse));
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

# Betreff Zeile
$p->setfont($font_b,10);
my $betreff='Gebührenabrechnung nach';
if ($versichertenstatus ne 'privat') {
  $betreff.=" Hebammen-Vergütungsvereinbarung";
} else {
  # Abfragen, welche privat Gebührenordnung wird genutzt
  $betreff.=" Hebammen-Vergütungsvereinbarung ";
  if (uc $heb_bundesland eq 'NRW') {
    $betreff.="NRW";
  } elsif (uc $heb_bundesland eq 'BAYERN') {
    $betreff.="Bayern";
  } elsif (uc $heb_bundesland eq 'NIEDERSACHSEN') {
    $betreff.="Niedersachsen";
  } elsif (uc $heb_bundesland eq 'HESSEN') {
    $betreff.="Hessen";
  } elsif (uc $heb_bundesland eq 'HAMBURG') {
    $betreff.= "Hamburg";
  } elsif (uc $heb_bundesland eq 'RHEINLAND-PFALZ') {
    $betreff.="Rheinland-Pfalz";
  } elsif (uc $heb_bundesland eq 'THüRINGEN' || $heb_bundesland eq 'Thüringen') {
    $betreff.="Thüringen";
  } elsif (uc $heb_bundesland eq 'SACHSEN-ANHALT') {
    $betreff.="Sachsen-Anhalt";
  } elsif (uc $heb_bundesland eq 'SACHSEN') {
    $betreff.="Sachsen";
  }  else {
    $betreff.="PRIVAT GEBÜHRENORDNUNG UNBEKANNT, BITTE PARAMETER HEB_BUNDESLAND pflegen".uc $heb_bundesland;
  }
}

$p->text(2,19.7,$betreff);


fussnote(); # auf der ersten Seite explizit angeben

# Falz  ausgeben
$p->setlinewidth(0.02);
$p->line(0,19.2,0.5,19.2);
$p->line(20.4,19.2,21,19.2);
$p->setlinewidth(0.04);

# Rechnung ausgeben für Rechnungsteile A,B,C
$y1=18.5;
my $gsumme=0;
$gsumme +=print_teil('A') if ($l->leistungsdaten_offen($frau_id,'Leistungstyp="A"')>0);
$gsumme +=print_teil('B') if ($l->leistungsdaten_offen($frau_id,'Leistungstyp="B"')>0);
$gsumme +=print_teil('C') if ($l->leistungsdaten_offen($frau_id,'Leistungstyp="C"')>0);
$gsumme +=print_teil('D') if ($l->leistungsdaten_offen($frau_id,'Leistungstyp="D"')>0);

# Auslagen
$gsumme += print_material('M') if ($l->leistungsdaten_offen($frau_id,'Leistungstyp="M"','sort,ZUSATZGEBUEHREN1,DATUM'));


# Prüfen auf Wegegeld
if ($l->leistungsdaten_offen($frau_id,'(ENTFERNUNG_T > 0 or ENTFERNUNG_N > 0)')>0) {
  neue_seite(7,'');
  $p->setfont($font_b,10);
  $p->text($x1,$y1,"Wegegeld");$y1-=$y_font;
  $p->setfont($font,10);
  $gsumme += print_wegegeld('N') if ($l->leistungsdaten_offen($frau_id,'ENTFERNUNG_N >0,ENTFERNUNG_N > 2','DATUM')>0);
  $gsumme += print_wegegeld('T') if ($l->leistungsdaten_offen($frau_id,'ENTFERNUNG_T >0, ENTFERNUNG_T > 2','DATUM')>0);
$gsumme += print_wegegeld('NK') if ($l->leistungsdaten_offen($frau_id,'ENTFERNUNG_N >0, ENTFERNUNG_N <= 2','DATUM')>0);
$gsumme += print_wegegeld('TK') if ($l->leistungsdaten_offen($frau_id,'ENTFERNUNG_T >0, ENTFERNUNG_T <= 2','DATUM')>0);
}


# Gesamtsumme ausgeben
$y1+=$y_font;$y1+=$y_font;
$y1-=0.05;
$p->setlinewidth(0.05);
$p->line(19.5,$y1,17.5,$y1);$y1-=$y_font-0.1;
$p->setfont($font_b,10);
$p->text(12.7,$y1,"Gesamtbetrag");
$p->setfont($font,10);
$gsumme = sprintf "%.2f",$gsumme;
$gsumme =~ s/\./,/g;
$p->text({align => 'right'},19.5,$y1,$gsumme." EUR"); # Gesamt Summe andrucken

$y1-=$y_font;$y1-=$y_font;
neue_seite(6);

# Begründungen ausgeben
print_begruendung() if ($l->leistungsdaten_offen($frau_id,'BEGRUENDUNG <> ""')>0);
$y1-=$y_font;
neue_seite(7);

# Prüfen ob auch elektronisch versand wird
if ($name_krankenkasse ne '' && $versichertenstatus ne 'privat' 
   && $versichertenstatus ne 'SOZ') {
  # prüfen ob zu ik Zentral IK vorhanden ist
  my $text='';
  my ($ktr,$zik)=$k->krankenkasse_ktr_da($ik_krankenkasse);
  my $test_ind = $k->krankenkasse_test_ind($ik_krankenkasse);
  my ($kname_zik)=$k->krankenkasse_sel("KNAME",$zik);
  if (defined($zik) && $zik > 0 && defined($test_ind) && $test_ind==1) {
    $p->text($x1,$y1,"Diese Rechnung wurde im Rahmen der Erprobungsphase des Datenaustausches im Abrechnungsverfahren");$y1-=$y_font;
    $p->text($x1,$y1,"nach §302 SGB V per E-Mail an die zuständige Datenannahmestelle ");$y1-=$y_font;
    $p->text($x1,$y1,"$zik ($kname_zik) geschickt.");$y1-=$y_font;$y1-=$y_font;
  } elsif (defined($zik) && $zik > 0 && defined($test_ind) && $test_ind==2) {
    $p->text($x1,$y1,"Diese Rechnung dient nur Ihren persönlichen Unterlagen, die Rechnung muss ausschließlich per");$y1-=$y_font;
    $p->text($x1,$y1,"E-Mail an die zuständige Datenannahmestelle geschickt werden.");$y1-=$y_font;
  }
}


# Abschlusstext ausgeben
neue_seite(7);
$p->text($x1,$y1, "Die abgerechneten Leistungen sind nach § 4 Nr. 14 UStG von der Umsatzsteuer befreit.");$y1-=$y_font;$y1-=$y_font;

if ($versichertenstatus ne 'privat' && $versichertenstatus ne 'SOZ') {
  $p->text($x1,$y1,"Bitte überweisen Sie den Gesamtbetrag innerhalb der gesetzlichen Frist von drei Wochen nach");$y1-=$y_font;
  $p->text($x1,$y1,"Rechnungseingang (§5 Abs. 4 HebGV) unter Angabe der Rechnungsnummer.");
} else {
  $p->text($x1,$y1,"Bitte überweisen Sie den Gesamtbetrag innerhalb der gesetzlichen Frist von 30 Tagen nach");$y1-=$y_font;
  $p->text($x1,$y1,"Rechnungseinang unter Angabe der Rechnungsnummer.");
}
$y1-=$y_font;$y1-=$y_font;$y1-=$y_font;
$p->text($x1,$y1,"Mit freundlichen Grüßen");

# Prüfen ob es sich um elektronische Rechnung handelt und Begleitzettel für Urbelege
# ertellt werden muss
my $test_ind = $k->krankenkasse_test_ind($ik_krankenkasse);
if (defined($test_ind) && $test_ind==2) {
  # Begleitzettel für Urbeleg erstellen
  urbeleg();
}


# in Browser schreiben, falls Windows wird PDF erzeugt, sonst Postscript
my $all_rech=$p->get();
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

if ($speichern eq 'save') {
  # setzt alle Daten in der Datenbank auf Rechnung und speichert die Rechnung
  $datum = $d->convert($datum);
  $gsumme =~ s/,/\./g;
  $l->rechnung_ins($rechnungsnr,$datum,$gsumme,$frau_id,$ik_krankenkasse,$all_rech);
  rech_up('A');
  rech_up('B');
  rech_up('C');
  rech_up('D');
  rech_up('M');
}

#-----------------------------------------------------------------

sub rech_up {
  my ($typ)=@_;
    $l->leistungsdaten_offen($frau_id,"Leistungstyp='$typ'");
    while (my @erg=$l->leistungsdaten_offen_next()) {
      $l->leistungsdaten_up_werte($erg[0],"STATUS=20,RECHNUNGSNR='$rechnungsnr'");
    }
}


sub fussnote {
  $p->setfont($font, 10);
  $p->text(2,1.6, "Bankverbindung: Kto-Nr. ".$h->parm_unique('HEB_Konto').' '.$h->parm_unique('HEB_NAMEBANK').' BLZ '.$h->parm_unique('HEB_BLZ'));
  # Steuernummer ausgeben, wenn vorhanden
  if($h->parm_unique('HEB_STNR')) {
    $p->text(2,1.6-$y_font,'Steuernummer: '.$h->parm_unique('HEB_STNR'));
  }
}


sub kopfzeile {
  $seite++;
  $y1=27.8;
  $p->newpage;
  $p->setfont($font_b,10);
  $p->text(2,$y1,$h->parm_unique('HEB_VORNAME').' '.$h->parm_unique('HEB_NACHNAME'));
  $p->text(12.7,$y1,"Rechnung");
  $p->setfont($font,10);
  $p->text(15,$y1,"/Seite $seite");
  $y1-=$y_font;
  $p->text(2,$y1,"Hebamme");
  $p->text(12.7,$y1,"Nr.:");
  $p->text(15,$y1,$rechnungsnr);
  $p->text(17.3,$y1,$nachname);
  $y1-=0.1;
  $p->line(1.95,$y1,19.5,$y1);
  $y1-=$y_font,$y1-=$y_font;
}

sub wasserzeichen {
  if ($speichern ne 'save') {
    $p->setfont($font_b,60);
    $p->setcolour('grey70');
    $p->text( {rotate => 50,
	       align => 'center'},
	      21/2,28.6/2,"Rechnungsvorschau");
    $p->setcolour('black');
    $p->setfont($font,10);
  }
}


sub neue_seite {
  my ($abstand,$teil) = @_;
  $teil = '' if (!defined($teil));
  return if ($y1 > $abstand);
  kopfzeile();
  fussnote();
  wasserzeichen();
  $posnr=-1;
  my $text='';
  $text = 'A. Mutterschaftsvorsorge' if ($teil eq 'A');
  $text = 'B. Geburt' if ($teil eq 'B');
  $text = 'C. Wochenbett' if ($teil eq 'C');
  $text = 'D. sonstige Leistungen' if ($teil eq 'D');
  $text = 'Wegegeld bei Nacht' if ($teil eq 'N');
  $text = 'Wegegeld bei Tag' if ($teil eq 'T');
  $text = 'Wegegeld bei Tag Entfernung nicht mehr als 2 KM' if ($teil eq 'TK');
  $text = 'Wegegeld bei Nacht Entfernung nicht mehr als 2 KM' if ($teil eq 'NK');
  $text = 'Auslagen' if ($teil eq 'M');
  if ($teil eq 'A' or $teil eq 'B' or $teil eq 'C' or $teil eq 'D' or $teil eq 'M') {
    $p->setfont($font_b,10);
    $p->text($x1,$y1,$text);$y1-=$y_font;$y1-=$y_font;
    $p->setfont($font,10);
  }
  if ($teil eq 'N' || $teil eq 'T' || $teil eq 'TK' || $teil eq 'NK') {
    $p->setfont($font,10);
    $p->text($x1,$y1,$text);$y1-=$y_font;
  }
}    


sub print_begruendung {
    while (my @erg=$l->leistungsdaten_offen_next()) {
      my ($bez,$fuerzeit,$epreis)=$l->leistungsart_such_posnr("KBEZ",$erg[1],$erg[4]);
      my $datum = $d->convert_tmj($erg[4]);
      $p->text($x1,$y1,"Begründung für $bez am $datum : $erg[3]");$y1-=$y_font;
      neue_seite(4);
    }
    $y1-=$y_font;
  }


sub print_material {
  my ($typ) = @_;
  my $summe=0;
  my $posnr=-1;
  my $zus_posnr=-1;
  neue_seite(6);
  $p->setfont($font_b,10);
  $p->text($x1,$y1,'Auslagen');$y1-=$y_font;$y1-=$y_font;
  $p->setfont($font,10);
  NEXT: while (my @erg=$l->leistungsdaten_offen_next()) {
    my ($bez,$epreis,$zus1)=$l->leistungsart_such_posnr("KBEZ,EINZELPREIS,ZUSATZGEBUEHREN1 ",$erg[1],$erg[4]);

    if($erg[1] =~ /^\d{1,3}$/) { # 
      $bez = substr($bez,0,50);
      my $laenge_bez = length($bez)*0.2/2;
      if ($posnr ne $erg[1]) {
	# bei posnr wechsel posnr schreiben
	$p->text({align => 'center'},$x1+1,$y1,$erg[1]);
	$posnr=$erg[1];
	$p->text($x1+2,$y1,$bez);
      } else {
	# Hochkomma ausgeben, wenn keine Zeitangabe notwendig
	$p->text({align => 'center'},$x1+2+$laenge_bez,$y1,"\"");
      }
    } elsif($erg[1] =~ /^[A-Z]\d{1,3}$/) {
      # zugeordnete Posnr holen
      my $go_datum = $erg[4];
      $go_datum =~ s/-//g;
      $zus1=70 if ((!defined($zus1) or $zus1 eq '') and
		   $go_datum < 20070801);
      $zus1=800 if ((!defined($zus1) or $zus1 eq '') and
		   $go_datum >= 20070801);

      my($bez_zus)=$l->leistungsart_such_posnr("KBEZ","$zus1",$erg[4]);
      $bez_zus = substr($bez_zus,0,50);
      my $laenge_bez_zus = length($bez_zus)*0.2/2;
      if ($zus_posnr ne $zus1) {
	# bei übergeordneter posnr wechsel posnr schreiben
	$p->text({align => 'center'},$x1+1,$y1,$zus1);
	$zus_posnr=$zus1;
	$posnr=$erg[1];
	$p->text($x1+2,$y1,$bez_zus);$y1-=$y_font;
	$p->text($x1+2,$y1,$bez);
      } elsif ($posnr ne $erg[1]) {
	$posnr=$erg[1];
	# bei wechsel posnr schreiben
	$p->text($x1+2,$y1,$bez);
      } else {
	# Hochkomma ausgeben, wenn kein Wechsel vorhanden
	$p->text({align => 'center'},$x1+2+$laenge_bez_zus,$y1,'"');	
      }
    }
    my $datum = $d->convert_tmj($erg[4]);
    $p->text({align => 'right'},15,$y1,$datum); # Datum andrucken
    my $gpreis = sprintf "%.2f",$erg[10];
    $summe+=$gpreis;$gpreis =~ s/\./,/g;
    $p->text({align => 'right'},17.3,$y1,$gpreis." EUR"); # Preis andrucken
    $y1-=$y_font;
    neue_seite(4,'M');
  }
  $y1+=$y_font-0.05;
  $p->line(17.4,$y1,15.1,$y1);$y1-=$y_font-0.1;
  my $psumme = sprintf "%.2f",$summe;$psumme =~ s/\./,/g;
  $p->text({align => 'right'},17.3,$y1,$psumme." EUR"); # Gesamt Summe andrucken
  $p->text({align => 'right'},19.5,$y1,$psumme." EUR"); # Gesamt erneut Summe andrucken
  $y1-=$y_font;$y1-=$y_font;
  return $summe;
}


sub print_wegegeld {
  my ($tn) = @_;
  my $text='';
  my $preis=0;
  my $summe=0;
  neue_seite(5);
  $text ='Wegegeld bei Nacht' if ($tn eq 'N');
  $text ='Wegegeld bei Tag' if ($tn eq 'T');
  $text ='Wegegeld bei Tag Entfernung nicht mehr als 2 KM' if ($tn eq 'TK');
  $text ='Wegegeld bei Nacht Entfernung nicht mehr als 2 KM' if ($tn eq 'NK');
  $p->text($x1,$y1,$text);$y1-=$y_font;
  while (my @erg=$l->leistungsdaten_offen_next()) {
    neue_seite(5,$tn);
    # richtige Positionsnummer Suchen
    my $go_datum = $erg[4];
    $go_datum =~ s/-//g;
    my $posnr=0;
    if ($go_datum < 20070801) {
      # Gebührenordnung mit alten Posnr
      $posnr = 94 if ($tn eq 'N');
      $posnr = 93 if ($tn eq 'T');
      $posnr = 91 if ($tn eq 'TK');
      $posnr = 92 if ($tn eq 'NK');
    } else {
      # Gebührenordnung ab 01.08.2007 mit neuen PosNr
      $posnr = 330 if ($tn eq 'N');
      $posnr = 320 if ($tn eq 'T');
      $posnr = 300 if ($tn eq 'TK');
      $posnr = 310 if ($tn eq 'NK');
    }
    ($preis)=$l->leistungsart_such_posnr("EINZELPREIS","$posnr",$erg[4]);


    if ($versichertenstatus eq 'privat') {
      if (uc $heb_bundesland eq 'NIEDERSACHSEN' ||
	  uc $heb_bundesland eq 'HESSEN' ||
	  uc $heb_bundesland eq 'BAYERN' ||
	  uc $heb_bundesland eq 'HAMBURG') {
	$preis *= $h->parm_unique('PRIVAT_FAKTOR');
	$preis = sprintf "%.2f",$preis;
      }
    }
    $preis =~ s/\./,/g;

    my $datum = $d->convert_tmj($erg[4]);
    $p->text({align => 'right'},4,$y1,$datum); # Datum andrucken
    my $entf=0;
    $entf = sprintf "%.2f",$erg[7] if ($tn eq 'T');
    $entf = sprintf "%.2f",$erg[8] if ($tn eq 'N');
    my $entfp = $entf;
    $entfp =~ s/\./,/g;
    $preis =~s/\./,/g;
    $p->text({align => 'right'},7,$y1,"$entfp km") if ($entf>=2);
    $p->text(8,$y1,"(Anteil $erg[9] Besuche)") if ($erg[9]>1); # Anzahl Frauen
    $p->text({align => 'right'},13.0,$y1,"á $preis EUR");
    $preis =~ s/,/\./g;
    my $teilsumme = 0;
    $teilsumme = ($preis * $entf) if ($entf>=2);
    $teilsumme = $preis if($entf<2);
    $teilsumme = sprintf "%.2f",$teilsumme;
    $summe += $teilsumme;
    my $gpreis = sprintf "%.2f",$preis * $entf;
    $gpreis = $preis if($entf<2);
    $gpreis =~s/\./,/g;
    $p->text({align => 'right'},17.3,$y1,$gpreis." EUR"); # Preis andrucken
    $y1-=$y_font;
  }
  $y1+=$y_font-0.05;
  $p->line(17.4,$y1,15.1,$y1);$y1-=$y_font-0.1;
  my $psumme = sprintf "%.2f",$summe;$psumme =~ s/\./,/g;
  $p->text({align => 'right'},17.3,$y1,$psumme." EUR"); # Gesamt Summe andrucken
  $p->text({align => 'right'},19.5,$y1,$psumme." EUR"); # Gesamt erneut Summe andrucken
  $y1-=$y_font;$y1-=$y_font;
  $summe = sprintf "%.2f",$summe; # w/ Rundungsfehler-
  return $summe;
}

sub print_teil {
  my ($teil) = @_;

  my $text='';
  my $summe=0;
  neue_seite(6);
  $text = 'A. Mutterschaftsvorsorge' if ($teil eq 'A');
  $text = 'B. Geburt' if ($teil eq 'B');
  $text = 'C. Wochenbett' if ($teil eq 'C');
  $text = 'D. sonstige Leistungen' if ($teil eq 'D');
  $p->setfont($font_b,10);
  $p->text($x1,$y1,$text);$y1-=$y_font;$y1-=$y_font;
  $p->setfont($font,10);
  while (my @erg=$l->leistungsdaten_offen_next()) {
    my @erg2=$l->leistungsdaten_such_id($erg[0]);
    my ($bez,$fuerzeit,$epreis)=$l->leistungsart_such_posnr("KBEZ,FUERZEIT,EINZELPREIS ",$erg[1],$erg[4]);

    if ($epreis == 0) { # prozentuale Berechnung
      $epreis=$erg[10];
      $epreis = sprintf "%.2f",$epreis;
    }

    if ($versichertenstatus eq 'privat') {
      $epreis *= $h->parm_unique('PRIVAT_FAKTOR');
      $epreis = sprintf "%.2f",$epreis;
    }
    
    my $fuerzeit_flag='';
    ($fuerzeit_flag,$fuerzeit)=$d->fuerzeit_check($fuerzeit);
    $bez = substr($bez,0,50);
    my $laenge_bez = length($bez)*0.2/2;
    if ($posnr != $erg[1]) {
      # bei posnr wechsel posnr schreiben
      $p->text({align => 'center'},$x1+1,$y1,$erg[1]);
      $posnr=$erg[1];
      $p->text($x1+2,$y1,$bez);
#      print "fuerzeit $fuerzeit\n";
      $y1-=$y_font if (defined($fuerzeit) && $fuerzeit > 0);
    } else {
      # Hochkomma ausgeben, wenn keine Zeitangabe notwendig
      if (!(defined($fuerzeit) && $fuerzeit > 0)) {
	$p->text({align => 'center'},$x1+2+$laenge_bez,$y1,"\"");
      }
    }
    
    # prüfen ob Zeitangabe notwendig 
    my $vk = 1;
    if (defined($fuerzeit) && $fuerzeit > 0) {
      # fuerzeit ausgeben
      $p->text($x1+2,$y1,$erg2[5].'-'.$erg2[6]); # Zeit von bis
      # prüfen, ob Minuten genau abgerechnet werden muss
      if ($fuerzeit_flag ne 'E') { # nein

	my $dauer = $d->dauer_m($erg2[6],$erg2[5]);
	$vk = sprintf "%3.1u",($dauer / $fuerzeit);
	$vk++ if ($vk*$fuerzeit < $dauer);
	$vk = sprintf "%1.1u",$vk;
	$epreis =~ s/\./,/g;
	$p->text($x1+5.5,$y1,$vk." x ".$fuerzeit." min á ".$epreis." EUR");
      }
      if ($fuerzeit_flag eq 'E') { # ja
	my $dauer = $d->dauer_m($erg2[6],$erg2[5]);
	$vk = sprintf "%3.2f",($dauer / $fuerzeit);
	$epreis =~ s/\./,/g;
	$vk =~ s/\./,/g;
	$p->text($x1+5.5,$y1,$dauer." min = ".$vk." h á ".$epreis." EUR");
      }
    }

    # datum 4
    my $datum = $d->convert_tmj($erg[4]);
    my $gpreis = 0;
    $vk =~ s/,/\./g;	$epreis =~ s/,/\./g;
    $gpreis = sprintf "%.2f",$vk * $epreis;


    $summe+=$gpreis;$gpreis =~ s/\./,/g;
    $p->text({align => 'right'},15,$y1,$datum); # Datum andrucken
    $p->text({align => 'right'},17.3,$y1,$gpreis." EUR"); # Preis andrucken
    $y1-=$y_font;
    neue_seite(4,$teil);
  }
  $y1+=$y_font-0.05;
  $p->line(17.4,$y1,15.1,$y1);$y1-=$y_font-0.1;
  my $psumme = sprintf "%.2f",$summe;$psumme =~ s/\./,/g;
  $p->text({align => 'right'},17.3,$y1,$psumme." EUR"); # Gesamt Summe andrucken
  $p->text({align => 'right'},19.5,$y1,$psumme." EUR"); # Gesamt erneut Summe andrucken
  $y1-=$y_font;$y1-=$y_font;
  neue_seite(6);
  return $summe;
}


sub anschrift {
  # gibt Anschrift, Rechnungsnummer, etc. aus
  my $x1=12.6; # x werte für kisten
  my $x2=19.4;

  $p->setfont($font, 10);
  $p->box($x1,27.2,$x2,28.2);# Kiste für Rechnung y1=28.2 y2=27.2
  $p->setfont($font_b, 12);
  $p->text(12.7,27.8,"Rechnung");
  $p->setfont($font,10);
  $p->text(15.1,27.8,"Nr.");
  $p->text(15.1+2.4,27.8,$rechnungsnr);
  $p->text(15.1,27.8-$y_font,"Datum");
  $p->text(15.1+2.4,27.8-$y_font,$datum);
  
  my $y1=27.7;
  # Kiste für Krankenkassen nur ausgeben, wenn keine privat Rechnung
  if ($versichertenstatus ne 'privat') {
    $p->box($x1,25.1,$x2,26.4); # Kiste für Krankenkasse y=25.1 y2=26.4
    $p->setfont($font,8);
    if ($versichertenstatus ne 'SOZ') {
      $p->text(12.7,$y1-3*$y_font,"Zahlungspflichtige Kasse (Rechnungsempfänger):");
    } else {
      $p->text(12.7,$y1-3*$y_font,"Rechnungsempfänger:");
    }
    $p->setfont($font,10);
    $p->text(12.7,$y1-4*$y_font,"IK:");
    $p->setfont($font_b,10);
    $p->text(15.1,$y1-4*$y_font,$ik_krankenkasse);
    $p->text(12.7,$y1-5*$y_font,$kname_krankenkasse);
    $p->setfont($font,10);
    $p->text(12.7,$y1-6*$y_font,$plz_krankenkasse." ".$ort_krankenkasse) if ($plz_krankenkasse ne '' && $plz_krankenkasse > 0);
    $p->text(12.7,$y1-6*$y_font,$plz_post_krankenkasse." ".$ort_krankenkasse) if ($plz_krankenkasse ne '' && $plz_krankenkasse == 0);
    
    $y1=24.6;
    $p->box($x1,23.8,$x2,$y1);# Kiste für Mitglied y1=23.8 y2=24.6
    $p->setfont($font,8);
    $y1+=0.1;
    $p->text(12.7,$y1,"Mitglied");
    $p->setfont($font_b,10);
    $p->text(12.7,$y1-$y_font,$nachname.", ".$vorname);
    $p->setfont($font,10);
    $p->text(12.7,$y1-2*$y_font,"geboren am");
    $p->text(15.1,$y1-2*$y_font,$geb_frau);
    
    $y1=23.8;
    my $groesse_kiste = 2.1;
    $groesse_kiste-=(2.9*$y_font) if($versichertenstatus eq 'SOZ');
    $p->box($x1,$y1-$groesse_kiste,$x2,$y1);# Anschrift und Versichertenstatus y1=21.7 y2=23.8
    $y1=23.4;
    $p->text(12.7,$y1,$plz." ".$ort);
    $p->text(12.7,$y1-$y_font,$strasse);
    if($versichertenstatus ne 'SOZ') {
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
    }
    
    $y1=21.3;
    $y1+=(3*$y_font) if($versichertenstatus eq 'SOZ');
    $p->box($x1,$y1-0.5,$x2,$y1);# Kiste für Kind y1=20.8 y2=21.3
    $p->setfont($font,8);
#    $y1=21.35;
    $y1+=0.05;
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
  $ort_krankenkasse_beleg = '' unless (defined($ort_krankenkasse_beleg));
  
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


sub urbeleg {
  $p->newpage;
  wasserzeichen();
  anschrift();
  # Betreff Zeile
  $p->setfont($font_b,10);
  if ($versichertenstatus ne 'privat') {
    $p->text(2,19.7,"Begleitzettel für Urbelege, Rechnung $rechnungsnr");
  }
  $y1=18.5;

  $p->setfont($font,10);  
  $p->text($x1,$y1,"Anzahl der übermittelten Belege: ");
  $y1-=$y_font;$y1-=$y_font;$y1-=$y_font;
  $p->text($x1,$y1,"Mit freundlichen Grüßen");
  fussnote(); # auf der ersten Seite explizit angeben
}
