#!/usr/bin/perl -wT
# -wT

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


#print "Content-Type: application/postscript\n";
my $frau_id = $q->param('frau_id') || -1;
#my $frau_id = $ARGV[0] || 6;
my $seite=1;
my $rechnungsnr = 1+($h->parm_unique('RECHNR'));
my $datum = $ARGV[2] || $d->convert_tmj(sprintf "%4.4u-%2.2u-%2.2u",Today());
my $posnr=-1;

# zunächst daten der Frau holen
my ($vorname,$nachname,$geb_frau,$geb_kind,$plz,$ort,$tel,$strasse,
    $bundesland,$entfernung_frau,$kv_nummer,$kv_gueltig,$versichertenstatus,
    $ik_krankenkasse,$naechste_hebamme,
    $begruendung_nicht_nae_heb) = $s->stammdaten_frau_id($frau_id);
$entfernung_frau =~ s/\./,/g;

my  ($name_krankenkasse,
     $plz_krankenkasse,
     $plz_post_krankenkasse,
     $ort_krankenkasse,
     $strasse_krankenkasse,
     $postfach_krankenkasse) = $k->krankenkasse_sel('NAME,PLZ_HAUS,PLZ_POST,ORT,STRASSE,POSTFACH',$ik_krankenkasse);


my $p = new PostScript::Simple(papersize => "A4",
#			       color => 1,
			       eps => 0,
			       units => "cm",
			       reencode => "ISOLatin1Encoding");


$p->newpage;

my $x1=12.6; # x werte für kisten
my $x2=19.4;

my $y_font = 0.410;
my $font ="Helvetica-iso";
my $font_b = "Helvetica-Bold-iso";

$p->setfont($font, 10);
$p->box($x1,27.2,$x2,28.2);# Kiste für Rechnung y1=28.2 y2=27.2
$p->setfont($font_b, 12);
$p->text(12.7,27.8,"Rechnung");
$p->setfont($font,10);
$p->text(15.1,27.8,"Nr.");
$p->text(15.1+2.4,27.8,$rechnungsnr);
$p->text(15.1,27.8-$y_font,"Datum");
$p->text(15.1+2.4,27.8-$y_font,$datum);

$p->box($x1,25.1,$x2,26.4); # Kiste für Krankenkasse y=25.1 y2=26.4
my $y1=27.7;
$p->setfont($font,8);
$p->text(12.7,$y1-3*$y_font,"Zahlungspflichtige Kasse (Rechnungsempfänger):");
$p->setfont($font,10);
$p->text(12.7,$y1-4*$y_font,"IK:");
$p->setfont($font_b,10);
$p->text(15.1,$y1-4*$y_font,$ik_krankenkasse);
$p->text(12.7,$y1-5*$y_font,$name_krankenkasse);
$p->setfont($font,10);
$p->text(12.7,$y1-6*$y_font,$plz_krankenkasse." ".$ort_krankenkasse) if ($plz_krankenkasse > 0);
$p->text(12.7,$y1-6*$y_font,$plz_post_krankenkasse." ".$ort_krankenkasse) if ($plz_krankenkasse == 0);

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
if ($datum_jmt >= $geb_kind_et) {
  $p->text(12.7,$y1-$y_font,"geboren am");
} else {
  $p->text(12.7,$y1-$y_font,"ET");
}
$p->text(15.1,$y1-$y_font,$geb_kind);

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
$p->setfont($font,10);
$y1=23.8;
$p->text($x1,$y1,$name_krankenkasse);
$p->text($x1,$y1-$y_font,$strasse_krankenkasse) if ($plz_post_krankenkasse == 0);
$p->text($x1,$y1-$y_font,"Postfach $postfach_krankenkasse") if ($plz_post_krankenkasse > 0);
$p->text($x1,$y1-3*$y_font,$plz_krankenkasse." ".$ort_krankenkasse) if ($plz_post_krankenkasse == 0);
$p->text($x1,$y1-3*$y_font,$plz_post_krankenkasse." ".$ort_krankenkasse) if ($plz_post_krankenkasse > 0);


# Betreff Zeile
$p->setfont($font_b,10);
$p->text(2,19.7,"Gebührenabrechnung nach HebGV");

fussnote(); # auf der ersten Seite explizit angeben

# Rechnung ausgeben für Rechnungsteile A,B,C
$y1=18.5;
my $gsumme=0;
$gsumme +=print_teil('A') if ($l->leistungsdaten_offen($frau_id,'Leistungstyp="A"')>0);
$gsumme +=print_teil('B') if ($l->leistungsdaten_offen($frau_id,'Leistungstyp="B"')>0);
$gsumme +=print_teil('C') if ($l->leistungsdaten_offen($frau_id,'Leistungstyp="C"')>0);
$gsumme +=print_teil('D') if ($l->leistungsdaten_offen($frau_id,'Leistungstyp="D"')>0);

# Prüfen auf Wegegeld
if ($l->leistungsdaten_offen($frau_id,'(ENTFERNUNG_T > 0 or ENTFERNUNG_N > 0)')>0) {
  $p->setfont($font_b,10);
  neue_seite(7,'');
  $p->text($x1,$y1,"Wegegeld");$y1-=$y_font;
  $p->setfont($font,10);
  $gsumme += print_wegegeld('N') if ($l->leistungsdaten_offen($frau_id,'ENTFERNUNG_N >0,ENTFERNUNG_N >= 2','DATUM')>0);
  $gsumme += print_wegegeld('T') if ($l->leistungsdaten_offen($frau_id,'ENTFERNUNG_T >0, ENTFERNUNG_T >= 2','DATUM')>0);
$gsumme += print_wegegeld('NK') if ($l->leistungsdaten_offen($frau_id,'ENTFERNUNG_N >0, ENTFERNUNG_N < 2','DATUM')>0);
$gsumme += print_wegegeld('TK') if ($l->leistungsdaten_offen($frau_id,'ENTFERNUNG_T >0, ENTFERNUNG_T < 2','DATUM')>0);
}

$gsumme += print_material('M') if ($l->leistungsdaten_offen($frau_id,'Leistungstyp="M"')>0);

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

# Abschlusstext ausgeben
neue_seite(7);
$p->text($x1,$y1,"Bitte überweisen Sie den Gesamtbetrag innerhalb der gesetzlichen Frist von drei Wochen nach");$y1-=$y_font;
$p->text($x1,$y1,"Rechnungseingang (§5 Abs. 4 HebGV) unter Angabe der Rechnungsnummer.");
$y1-=$y_font;$y1-=$y_font;$y1-=$y_font;
$p->text($x1,$y1,"Mit freundlichen Grüßen");

# write the output to a file
$p->output("/tmp/wwwrun/file.ps");
my $speichern = $q->param("speichern") || '';

# in Browser schreiben
open (FILE,"/tmp/wwwrun/file.ps") or die "Can't open file.ps: $!\n";
print $q->header ( -type => "application/postscript", -expires => "-1d");
my $in='';
my $all_rech='';
while ($in =<FILE>) {
  if ($in =~ /%%Title:/) {
    print "%%Title: $nachname","_",$vorname,"\n";
    $all_rech .= "%%Title: $nachname"."_".$vorname."\n";
  } else {
    $all_rech.=$in;
    print $in;
  }
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
#$p->text(2,1.6, "Bankverbindung: Kto-Nr. 280727 Sparkasse Herrieden BLZ 765 500 00");
$p->text(2,1.6, "Bankverbindung: Kto-Nr. ".$h->parm_unique('HEB_Konto').' '.$h->parm_unique('HEB_NAMEBANK').' BLZ '.$h->parm_unique('HEB_BLZ'));
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

sub neue_seite {
  my ($abstand,$teil) = @_;
  $teil = '' if (!defined($teil));
  return if ($y1 > $abstand);
  kopfzeile();
  fussnote();
  $posnr=-1;
  my $text='';
  $text = 'A. Mutterschaftsvorsorge' if ($teil eq 'A');
  $text = 'B. Geburt' if ($teil eq 'B');
  $text = 'C. Wochenbett' if ($teil eq 'C');
  $text = 'D. sonstige Leistungen' if ($teil eq 'D');
  $text ='Wegegeld bei Nacht' if ($teil eq 'N');
  $text ='Wegegeld bei Tag' if ($teil eq 'T');
  $text ='Wegegeld bei Tag Entfernung nicht mehr als 2 KM' if ($teil eq 'TK');
  $text ='Wegegeld bei Nacht Entfernung nicht mehr als 2 KM' if ($teil eq 'NK');
  $text = 'Materialpauschalen' if ($teil eq 'M');
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
  neue_seite(6);
  $p->setfont($font_b,10);
  $p->text($x1,$y1,'Materialpauschalen');$y1-=$y_font;$y1-=$y_font;
  $p->setfont($font,10);
  while (my @erg=$l->leistungsdaten_offen_next()) {
    my ($bez,$epreis)=$l->leistungsart_such_posnr("KBEZ,EINZELPREIS ",$erg[1],$erg[4]);
    $p->text($x1,$y1,$bez);
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
  $text ='Wegegeld bei Nacht' if ($tn eq 'N');
  $text ='Wegegeld bei Tag' if ($tn eq 'T');
  $text ='Wegegeld bei Tag Entfernung nicht mehr als 2 KM' if ($tn eq 'TK');
  $text ='Wegegeld bei Nacht Entfernung nicht mehr als 2 KM' if ($tn eq 'NK');
  $p->text($x1,$y1,$text);$y1-=$y_font;
  while (my @erg=$l->leistungsdaten_offen_next()) {
    if($tn eq 'N') {
      ($preis)=$l->leistungsart_such_posnr("EINZELPREIS",'94',$erg[4]);
      $preis =~ s/\./,/g;
    }
    if ($tn eq 'T') {
      ($preis)=$l->leistungsart_such_posnr("EINZELPREIS",'93',$erg[4]);
      $preis =~ s/\./,/g;
    }
    if ($tn eq 'TK') {
      ($preis)=$l->leistungsart_such_posnr("EINZELPREIS",'91',$erg[4]);
      $preis =~ s/\./,/g;
    }
    if ($tn eq 'NK') {
      ($preis)=$l->leistungsart_such_posnr("EINZELPREIS",'92',$erg[4]);
      $preis =~ s/\./,/g;
    }
    my $datum = $d->convert_tmj($erg[4]);
    $p->text({align => 'right'},4,$y1,$datum); # Datum andrucken
    my $entf=0;
    $entf = sprintf "%.1f",$erg[7] if ($tn eq 'T');
    $entf = sprintf "%.1f",$erg[8] if ($tn eq 'N');
    my $entfp = $entf;
    $entfp =~ s/\./,/g;
    $preis =~s/\./,/g;
    $p->text({align => 'right'},7,$y1,"$entfp km") if ($entf>=2);
    $p->text(8,$y1,"(Anteil $erg[9] Besuche)") if ($erg[9]>1); # Anzahl Frauen
    $p->text({align => 'right'},12.5,$y1,"á $preis");
    $preis =~ s/,/\./g;
    $summe += $preis * $entf if ($entf>=2);
    $summe += $preis if($entf<2);
    my $gpreis = sprintf "%.2f",$preis * $entf;
    $gpreis = $preis if($entf<2);
    $gpreis =~s/\./,/g;
    $p->text({align => 'right'},17.3,$y1,$gpreis." EUR"); # Preis andrucken
    $y1-=$y_font;
    neue_seite(4,$tn);
  }
  $y1+=$y_font-0.05;
  $p->line(17.4,$y1,15.1,$y1);$y1-=$y_font-0.1;
  my $psumme = sprintf "%.2f",$summe;$psumme =~ s/\./,/g;
  $p->text({align => 'right'},17.3,$y1,$psumme." EUR"); # Gesamt Summe andrucken
  $p->text({align => 'right'},19.5,$y1,$psumme." EUR"); # Gesamt erneut Summe andrucken
  $y1-=$y_font;$y1-=$y_font;
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
    if (defined($fuerzeit) && $fuerzeit > 0) {
      # fuerzeit ausgeben
      $p->text($x1+2,$y1,$erg2[5].'-'.$erg2[6]); # Zeit von bis
      my $dauer = $d->dauer_m($erg2[6],$erg2[5]);
      my $vk = sprintf "%3.1u",($dauer / $fuerzeit);
      $vk++ if ($vk*$fuerzeit < $dauer);
      $vk = sprintf "%1.1u",$vk;
      $epreis =~ s/\./,/g;
      $p->text($x1+5.5,$y1,$vk." x ".$fuerzeit." min á ".$epreis." EUR");
    }

    # datum 4
    my $datum = $d->convert_tmj($erg[4]);
    my $gpreis = sprintf "%.2f",$erg[10];
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
