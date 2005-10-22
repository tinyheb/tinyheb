#!/usr/bin/perl -wT

# 08.10.2005
# Package für elektronische Rechnungen

# author: Thomas Baum

package Heb_Edi;

use strict;
use Date::Calc qw(Today_and_Now);
use File::stat;
use MIME::QuotedPrint qw(encode_qp);

use Heb;
use Heb_leistung;
use Heb_krankenkassen;
use Heb_stammdaten;
use Heb_datum;

my $debug=1;
my $h = new Heb;
my $l = new Heb_leistung;
my $k = new Heb_krankenkassen;
my $s = new Heb_stammdaten;
my $d = new Heb_datum;

my $delim = "'\r\n"; # Trennzeichen
my $crlf = "\r\n";

our $path = $ENV{HOME}.'/.tinyheb'; # für temporäre Dateien
our $dbh;

sub new {
  my($class) = @_;
  my $self = {};
  $dbh = Heb->connect;
  bless $self, ref $class || $class;
  return $self;
}



sub gen_auf {
  # generiert Auftragsdatei wie den Richtlinien für den Datenaustausch mit 
  # den geetzlichen Krankenkassen beschrieben.

  shift; # package Namen vom Stack nehmen

  my ($test_ind,$transfer_nr,$ik_empfaenger,
      $dateigroesse_nutz,$dateigroesse_ueb,
      $schl_ind,$sig_ind) = @_;

  my $default_n = '0';
  my $default_an = ' ';

  my $satzlaenge=348;
  my $i=0;
  my $st='!' x $satzlaenge;

  # 1. Teil Allgemeine Beschreibung der Krankenkassen-Kommunikation
  substr($st,1,6)='500000'; # Krankenkasse-Kommunikation Konstante 500000
  substr($st,7,2)='01'; # Version der Auftragsstruktur '01' erste Version
  substr($st,9,8)= sprintf "%8.8u",348; # Länge Auftragsdatei Konstant 348
  substr($st,17,3)= '000'; # Laufende Nummer bei Teillieferung 000 komplett
  if ($test_ind > 0) { # prüfen ob Test oder Produktion
    substr($st,20,5) = 'ESOL0'; # Produktion (siehe 3.2.3)
  } else {
    substr($st,20,5) = 'TSOL0'; # Test (siehe 3.2.3)
  }
  substr($st,25,3) = sprintf "%3.3u",substr((sprintf "%5.5u",$transfer_nr),2,3); # Transfernummer
  substr($st,28,5) = '     '; # Verfahrenkennung Spezifikation (optional)
  substr($st,33,15) = sprintf "%15s", $h->parm_unique('HEB_IK'); #Absender Eigner der Daten
  substr($st,48,15) = sprintf "%15s", $h->parm_unique('HEB_IK'); #Absender physikalisch
  substr($st,63,15) = sprintf "%15s", $ik_empfaenger; # Empfänger, der die Daten nutzen soll und im Besitz des Schlüssels ist, um verschlüsselte Infos zu entschlüsseln
  substr($st,78,15) = sprintf "%15s", $ik_empfaenger; # Empfänger, der die Daten physikalisch empfangen soll
  substr($st,93,6) = '000000'; # Fehlernr bei Rücksendung von Dateien
  substr($st,99,6) = '000000'; # Maßnahme laut Fehlerkatalog

  substr($st,105,11) = "SL".substr($h->parm_unique('HEB_IK'),2,6).'S'.$d->monat(); # Dateiname
  
  my $erstelldatum = sprintf "%4.4u%2.2u%2.2u%2.2u%2.2u%2.2u",Today_and_Now(); # Datum Erstellung der Datei
  substr($st,116,14) = $erstelldatum;
  substr($st,130,14) = sprintf "%4.4u%2.2u%2.2u%2.2u%2.2u%2.2u",Today_and_Now(); # Datum Start der Übertragung
  substr($st,144,14) = sprintf "%14.14u",$default_n; # Datum Empfangen Start
  substr($st,158,14) = sprintf "%14.14u",$default_n; # Datum Empfangen Ende
  substr($st,172,6) = '000000'; # Versionsnummer Datei muss auf 000000 stehen
  substr($st,178,1) = '0'; # wird nichts genutzt muss auf 0 stehen
  substr($st,179,12) = sprintf "%12.12u", $dateigroesse_nutz; # Dateigröße Nutzdaten (unverschlüsselt)
  substr($st,191,12) = sprintf "%12.12u", $dateigroesse_ueb; # Dateigröße Nutzdaten (nach Verschlüsselung Signierung und Komprimierung)
  substr($st,203,2) = 'I1'; # Daten sind ISO 8859-1 codiert
  substr($st,205,2) = '00'; # keine Komprimierung
  # Verschlüsselungsart und Signatur
  substr($st,207,2) = sprintf "%2.2u",$schl_ind; # Verschlüsselung
  substr($st,209,2) = sprintf "%2.2u",$sig_ind; #  Signatur
  
  # 2. Teil Spezifische Information zur Bandverarbeitung
  substr($st,211,3)='   '; # Satzformat, bei DFÜ blank
  substr($st,214,5)='00000'; # Satzlänge, bei DFÜ 00000
  substr($st,219,8)='00000000'; # Blöcklänge, bei DFÜ 00000000

  # 3. Teil Spezifische Informationen für das KSS-Verfahren
  # alle Felder auf default setzen
  substr($st,227,1)=' '; # Status bei Anlieferung durch Abrechnungssystem blank
  substr($st,228,2)='00'; # maximale Anzahl wiederholungen bei fehler
  substr($st,230,1)='0'; # übertragungsweg
  substr($st,231,10)= $default_n x 10; # Verzögerter Versand
  substr($st,241,6)= $default_n x 6; # Info Fehlerfelder
  substr($st,247,28)= $default_an x 28; # Klartextfehlermeldung
  
  # 4. Teil Spezifische Information zur Verarbeitung innerhalb eines RZ
  substr($st,275,44)=$default_an x 44; # E-Mail Absender
  substr($st,319,30)=$default_an x 30; # Variabler Bereich für Zusatz Info
  

  $st=substr($st,1,$satzlaenge);
  $erstelldatum=substr($erstelldatum,0,8).':'.substr($erstelldatum,8,4);
  return ($st,$erstelldatum);
}


sub UNB {
  # generiert UNB Segment, Kopfsegment der Nutzendatei
  
  shift; # package Namen vom stack nehmen

  my ($ik_empfaenger,$datenaustauschref,$test_ind) = @_;

  my $erg = 'UNB+';
  $erg .= 'UNOC:3+'; # Syntax
  $erg .= $h->parm_unique('HEB_IK').'+'; # IK des Absenders
  $erg .= $ik_empfaenger.'+'; # IK des Empfängers
  my $erstelldatum=sprintf "%4.4u%2.2u%2.2u:%2.2u%2.2u",Today_and_Now(); # Erstellungsdatum und Uhrzeit der Datei
  $erg .= $erstelldatum.'+';
  $erg .= sprintf "%5.5u+",$datenaustauschref; # Datenaustauschreferenz, vortlaufende Nummer zwischen Absender und Empfänger
  $erg .= '+'; # Freifeld
  $erg .= "SL".substr($h->parm_unique('HEB_IK'),2,6).'S'.$d->monat().'+'; # Anwendungsreferenz, entspricht dem logischen Dateinamen
  $erg .=  sprintf "%1.1u",$test_ind; # Indikator, ob Test, Erprobungs- oder Echtdatei
  $erg .= $delim;

  return ($erg,$erstelldatum);
}


sub UNZ {
  # generiert UNZ Segment, Endesegment der Nutzendatei

  shift;

  my ($datenaustauschref) = @_;

  my $erg = 'UNZ+';
  $erg .= sprintf "%6.6u+",2; # Anzahl der UNH in Nutzdatendatei
  $erg .= sprintf "%5.5u",$datenaustauschref;
  $erg .= $delim;

  return $erg;
}


sub SLGA_FKT {
  # generiert SLGA_FKT Segment
  # ist analog SLLA_FKT Segment, weil keine Sammelabrechnung erstellt wird
  # muss aber noch Absender zusätzlich enthalten

  shift; # package Namen vom stack nehmen

  my ($ik_kostentraeger,$ik_krankenkasse) = @_;
  my $erg = 'FKT+';
  $erg .= '01+'; # Abrechnung ohne Besonderheiten
  $erg .= '+'; # Freifeld
  $erg .= $h->parm_unique('HEB_IK').'+'; # IK des Leistungserbringers
  $erg .= $ik_kostentraeger.'+'; # IK des Kostenträgers
  $erg .= $ik_krankenkasse.'+'; # IK der Krankenkasse
  $erg .= $h->parm_unique('HEB_IK');
  $erg .= $delim; # Zeilentrennung anfügen.

  return $erg;
  
}

sub SLGA_REC {
  # generiert SLGA REC Segment
  # analog SLLA REC Segment
  shift; # package Namen vom stack nehmen

  my ($rechnr,$rechdatum) = @_;
  return Heb_Edi->SLLA_REC($rechnr,$rechdatum);
}


sub SLGA_GES {
  # generiert SLGA_GES Segment

  shift;

  my ($gesamtsumme,$status) = @_;
  $gesamtsumme =~ s/\./,/g;

  my $erg = 'GES+';
  $erg .= $status.'+'; # Status 00 = Gesamtsumme aller Stati
  $erg .= $gesamtsumme; # Gesamtrechnungsbetrag
  # Gesamtbruttobetrag und Gesamtbetrag Zuzahlungen nicht übermitteln
  # weil K Felder und identisch zu Gesamtrechnungsbetrag
  $erg .= $delim; # Zeilentrennung anfügen

  return $erg;
}

sub SLGA_NAM {
  # generiert SLGA_NAM Segment

  shift;

  my $erg = 'NAM+';
  $erg .= substr($h->parm_unique('HEB_VORNAME').' '.$h->parm_unique('HEB_NACHNAME'),0,30).'+'; # Name der Hebamme
  $erg .= substr($h->parm_unique('HEB_TEL'),0,30); # Telefonnummer der Hebamme
  $erg .= $delim; # Zeilenende anfügen

  return $erg;

}


sub SLLA_FKT {
  # generiert SLLA_FKT Segment

  shift; # package Namen vom stack nehmen

  my ($ik_kostentraeger,$ik_krankenkasse) = @_;
  
  my $erg = 'FKT+';
  $erg .= '01+'; # Abrechnung ohne Besonderheiten
  $erg .= '+'; # Freifeld
  $erg .= $h->parm_unique('HEB_IK').'+'; # IK des Leistungserbringers
  $erg .= $ik_kostentraeger.'+'; # IK des Kostenträgers
  $erg .= $ik_krankenkasse; # IK der Krankenkasse
  $erg .= $delim; # Zeilentrennung anfügen.

  return $erg;
}

sub SLLA_REC {
  # generiert SLLA REC Segment

  shift; # package Namen vom stack nehmen

  my ($rechnr,$rechdatum) = @_;

  my $erg = 'REC+';
  $erg .= $rechnr.':0+'; # Rechnungsnummer
  $erg .= $rechdatum.'+'; # Rechnungsdatum
  $erg .= '1+'; # Rechnungsart 1 = Abrechnung von LE und Zahlung an LE
  $erg .= 'EUR'; # Währungskennzeichen
  $erg .= $delim; # Zeilentrennung anfügen

  return $erg;
}

sub SLLA_INV {
  # generiert SLLA INV Segment
  
  shift; # package Namen vom stack nehmen

  my ($kvnr,$kvstatus,$rechnr) = @_;

  my ($kvs_1,$kvs_2)= split ' ',$kvstatus;

  my $erg = 'INV+';
  $erg .= $kvnr.'+'; # Krankenversicherungsnummer
  $erg .= $kvs_1.'000'.$kvs_2.'+'; # Versichertenstatus
  $erg .= '+'; # Freifeld
  $erg .= $rechnr; # Belegnummer
  $erg .= $delim; # Zeilentrennung anfügen

  return $erg;
}


sub SLLA_NAD {
  # generiert SLLA NAD Segment

  shift; # package Namen vom Stack nehmen

  my ($nachname,$vorname,$geb_frau,$strasse,$plz,$ort) = @_;
  # Steuerzeichen aufbereiten
  $nachname =~ s/'/\?'/g;$nachname =~ s/\+/\?\+/g;
  $nachname = substr($nachname,0,47);
  $vorname =~ s/'/\?'/g;$vorname =~ s/\+/\?\+/g;
  $vorname = substr($vorname,0,30);
  $strasse =~ s/'/\?'/g;$strasse =~ s/\+/\?\+/g;
  $strasse = substr($strasse,0,30);
  $ort =~ s/'/\?'/g;$ort =~ s/\+/\?\+/g;
  $ort = substr($ort,0,25);

  my $erg = 'NAD+';
  $erg .= $nachname.'+'; # nachname
  $erg .= $vorname.'+'; # vorname
  $erg .= $geb_frau.'+'; # geburtsdatum frau
  $erg .= $strasse.'+'; # strasse
  $erg .= $plz.'+'; # plz
  $erg .= $ort; # ort
  $erg .= $delim; # Zeilentrennung
  
  return $erg;
}


sub SLLA_ENF {
  # generiert SLLA ENF Segement

  shift; # package Namen vom Stack nehmen

  my($posnr,$datum,$preis,$menge) = @_;
  print "Posnr, $posnr,$datum, $preis, $menge ",$preis*$menge,"\n" if ($debug >100);
  $menge = sprintf "%.2f",$menge;
  $menge =~ s/\./,/g;

  my $erg = 'ENF+';
  $erg .= '+'; # Feld Identifikationsnummer überspringen, wird nicht genutzt
  $erg .= '50:'.$h->parm_unique('HEB_TARIFKZ').'000+'; # Abrechnungscode 50 Hebamme Sondertarik 000 = ohne Sondertarif
  $erg .= $posnr.'+'; # Art der Leistung gem 8.2.6 PosNr
  $erg .= '+'; # Positionsnummer Produktbesonderheiten 
  $erg .= "$menge+"; # Anzahl der Abrechnungspositionen
  $preis = sprintf "%.2f",$preis;
  $preis =~ s/\./,/g;
  $erg .= $preis.'+'; # Einzelpreis der Abrechnungsposition
  $erg .= $datum.'+';
  $erg .= '+'; # Schlüssel-KZ bei Hilfsmittel muss eigentlich angegeben werden
  $erg .= '+'; # Inventarnummer für Hilfsmittel noch nicht belegt
  # Betrag Zuzahlung entfällt
  $erg .= $delim;


  return $erg;
}

sub SLLA_SUT {
  # generiert SLLA SUT Segment
  shift; 

  my ($zeit_von,$zeit_bis,$dauer) = @_;
  $zeit_von =~ s/://g;
  $zeit_bis =~ s/://g;
  
  my $erg = 'SUT+';
  $erg .= '+'; # gefahrene Kilometer müssen über ENF gerechnet werden
  $erg .= $zeit_von.'+'; # Uhrzeit
  $erg .= $zeit_bis.'+'; # Uhrzeit bis
  $erg .= $dauer; # Dauer in Minuten
  $erg .= $delim;
  
  return $erg;
}

sub SLLA_TXT {
  # generiert SLLA TXT Segment
  shift;
  
  my ($text)=@_;
  $text = substr($text,0,70);

  my $erg = 'TXT+';
  $erg.= $text;
  $erg .= $delim;

  return $erg;
}


sub SLLA_BES {
  # generiert SLLA BES Segment
  shift;

  my ($betrag) = @_;
  $betrag = sprintf "%.2f",$betrag;
  $betrag =~ s/\./,/g;

  my $erg = 'BES+';
  $erg .= $betrag;
  $erg .= $delim;

  return $erg;
}


sub UNH {
  # generiert UNH Segment
  shift;

  my ($lfdnr,$typ)=@_;
  $lfdnr = sprintf "%5.5u",$lfdnr;

  my $erg = 'UNH+';
  $erg .= $lfdnr.'+'; # laufender Nummer der UNH Segmente
  $erg .= $typ.':05:0:0'; # Nachrichtenkennung
  $erg .= $delim;

  return $erg;
}

sub UNT {
  # generiert UNT Segment
  shift;

  my ($anzahl,$refnr) = @_;
  $anzahl = sprintf "%6.6u",$anzahl;
  $refnr = sprintf "%5.5u",$refnr;

  my $erg = 'UNT+';
  $erg .= $anzahl.'+'; # Anzahl der Segemente in Nachricht inkl. UNH und UNT
  $erg .= $refnr; # Nachrichtenreferenz wie in UNH Segment
  $erg .= $delim;

  return $erg;
}


sub SLGA {
  # generiert kompletten Nachrichtentyp SLGA
  # inkl. Kopf und Endesegment
  
  shift;

  my ($rechnr,$zik) = @_;
  my $lfdnr = 0;
  my $ref=1; # Nachrichtenreferenznummer
  my $erg = '';

  # Kopfsegment UNH produzieren
  $erg .= Heb_Edi->UNH($ref,'SLGA');$lfdnr++;

  # Rahmendaten für Rechnung aus Datenbank holen
  $l->rechnung_such("RECH_DATUM,BETRAG,FK_STAMMDATEN,IK","RECHNUNGSNR=$rechnr");
  my ($rechdatum,$betrag,$frau_id,$ik)=$l->rechnung_such_next();
  $rechdatum =~ s/-//g;

  # 1. FKT Segment erzeugen
  $erg .= Heb_Edi->SLGA_FKT($ik,$ik);$lfdnr++;
  # 2. REC Segment erzeugen
  $erg .= Heb_Edi->SLGA_REC($rechnr,$rechdatum);$lfdnr++;
  # 3. GES Segment erzeugen
  # zunächst Rechnungsbetrag ermittelen
  my ($hilf,$betrag_slla)=Heb_Edi->SLLA($rechnr,$zik);
  if ($betrag_slla != $betrag) {
    die "Betragsermittlung zu Papierrechnung unterschiedlich !!!\n";
  }
  $erg .= Heb_Edi->SLGA_GES($betrag_slla,'00');$lfdnr++;
  $erg .= Heb_Edi->SLGA_GES($betrag_slla,'11');$lfdnr++;
  
  # 4. NAM Segment erzeugen
  $erg .= Heb_Edi->SLGA_NAM();$lfdnr++;

  # 5. UNT Segment erzeugen
  $erg .= Heb_Edi->UNT($lfdnr+1,$ref);
  
  return $erg;
}


sub SLLA {
  # generiert kompletten Nachrichtentyp SLLA 
  # inkl. Kopf und Endesegment

  shift;

  my ($rechnr,$zik) = @_;
  my $lfdnr = 1; # muss mit 1 beginnen sonst keine korrekte Zählung
  #                laut Herr Birk AOK Rheinland
  my $gesamtsumme = 0.00; # summe aller Rechnungsbeträge
  my $ref=2; # Nachrichtenreferenznummer, fortlaufende Nummer der UNH
  ;;;;;;;;;;;# Segemente zw. UNB und UNZ, d.h.hier immer 2 weil nach SLGA
  my $erg=''; # komplettes Ergebniss
  my $summe_km=0; # summe des Kilometergeldes

  # Kopfsegment UNH produzieren
  $erg .= Heb_Edi->UNH($ref,'SLLA');$lfdnr++;
  
  # Rahmendaten für Rechnung aus Datenbank holen
  $l->rechnung_such("RECH_DATUM,BETRAG,FK_STAMMDATEN,IK","RECHNUNGSNR=$rechnr");
  my ($rechdatum,$betrag,$frau_id,$ik)=$l->rechnung_such_next();
  $rechdatum =~ s/-//g;

  my $test_ind = $h->parm_unique('IK'.$zik);

  # Stammdaten Frau holen
  my ($vorname,$nachname,$geb_frau,$geb_kind,$plz,$ort,$tel,$strasse,
      $anz_kinder,$entfernung,$kv_nummer,$kv_gueltig,$versichertenstatus,
      $ik_krankenkasse,$naechste_hebamme,
      $begruendung_nicht_nae_heb) = $s->stammdaten_frau_id($frau_id);

  $geb_frau=$d->convert($geb_frau);$geb_frau =~ s/-//g;
  $geb_kind=$d->convert($geb_kind);$geb_kind =~ s/-//g;
  
  # 1. FKT Segment erzeugen
  $erg .= Heb_Edi->SLLA_FKT($ik,$ik);$lfdnr++;
  # 2. REC Segment erzeugen
  $erg .= Heb_Edi->SLLA_REC($rechnr,$rechdatum);$lfdnr++;
  # 3. INV Segment erzeugen
  $erg .= Heb_Edi->SLLA_INV($kv_nummer,$versichertenstatus,$rechnr);$lfdnr++;
  # 4. NAD Segment erzeugen
  $erg .= Heb_Edi->SLLA_NAD($nachname,$vorname,$geb_frau,$strasse,$plz,$ort);
  $lfdnr++;

  # 5. ENF Segmente generieren
  # dazu Schleife über alle Positionen, die die Rechnungsnummer enthalten
  $l->leistungsdaten_such_rechnr("*",$rechnr.' order by DATUM');
  while (my @leistdat=$l->leistungsdaten_such_rechnr_next()) {
    $leistdat[5]=substr($leistdat[5],0,5); # nur HH:MM aus Ergebniss
    $leistdat[6]=substr($leistdat[6],0,5); # nur HH:MM aus Ergebniss
    # a. zuerst normale posnr füllen
    my ($bez,$fuerzeit,$epreis,$ltyp)=$l->leistungsart_such_posnr("KBEZ,FUERZEIT,EINZELPREIS,LEISTUNGSTYP ",$leistdat[1],$leistdat[4]);
    my $fuerzeit_flag='';
    my $dauer=0;
    my $anzahl=1; # Default, wenn keine Zeitangabe notwendig
    ($fuerzeit_flag,$fuerzeit)=$d->fuerzeit_check($fuerzeit);
    # prüfen ob Zeitangabe notwendig 
    if (defined($fuerzeit) && $fuerzeit > 0) {
      $dauer = $d->dauer_m($leistdat[6],$leistdat[5]);
      $anzahl = sprintf "%3.2f",($dauer / $fuerzeit);
      # prüfen, ob Minuten genau abgerechnet werden muss
      if ($fuerzeit_flag ne 'E') { # nein
        $anzahl++ if ($anzahl*$fuerzeit < $dauer);
	$anzahl = sprintf "%2.2u",$anzahl;
      }
    }
    $leistdat[4] =~ s/-//g; # Datum in korrektes Format bringen

    # ENF Segment ausgeben
    if($ltyp ne 'M') { 
      # keine Materialpauschale
      $erg .= Heb_Edi->SLLA_ENF($leistdat[1],$leistdat[4],$epreis,$anzahl);
      $lfdnr++;
      $gesamtsumme += sprintf "%.2f",($epreis*$anzahl);
      print "Summe: $gesamtsumme,",$epreis*$anzahl,"\n" if ($debug>100);
    } else {
      # Materialpauschale 
      $erg .= Heb_Edi->SLLA_ENF(70,$leistdat[4],$leistdat[10],1);
      $lfdnr++;
      # Text mit ausgeben
      $erg .= Heb_Edi->SLLA_TXT($bez);$lfdnr++;
      $gesamtsumme += $leistdat[10];
    }

    # b. prüfen ob Zeitangaben ausgegeben werden müssen
    if (defined($fuerzeit) && $fuerzeit > 0) {
      $erg .= Heb_Edi->SLLA_SUT($leistdat[5],$leistdat[6],$dauer);$lfdnr++;
    }

    # c. Begründungstexte ausgeben
    if ($leistdat[3] ne '') { # Begründung ausgeben
      $erg .= Heb_Edi->SLLA_TXT($leistdat[3]);$lfdnr++;
    }

    # d. Kilometergeld ausgeben
    my $posnr_wegegeld='';
    $posnr_wegegeld='91' if ($leistdat[7] > 0 && $leistdat[7] <= 2);# Tag < 2
    $posnr_wegegeld='92' if ($leistdat[8] > 0 && $leistdat[8] <= 2);# Nacht < 2
    $posnr_wegegeld='93' if ($leistdat[7] > 0 && $leistdat[7] > 2); # Tag > 2
    $posnr_wegegeld='94' if ($leistdat[8] > 0 && $leistdat[8] > 2); # Nacht > 2
    if ($posnr_wegegeld ne '') { # es muss wegegeld gerechnet werden
      ($epreis)=$l->leistungsart_such_posnr("EINZELPREIS",$posnr_wegegeld,$leistdat[4]);
      my $anteilig='';
      $anteilig='a' if ($leistdat[9]>1);# anteiliges Wegegeld
      if ($posnr_wegegeld eq '91' || $posnr_wegegeld eq '92') {
	$erg .= Heb_Edi->SLLA_ENF($posnr_wegegeld.$anteilig,$leistdat[4],$epreis,1);
	$lfdnr++;
	$summe_km+=$epreis;
	print "Wegegeld summe: $summe_km, $epreis\n" if ($debug > 1000);
      } elsif ($posnr_wegegeld eq '93') {
	$erg .= Heb_Edi->SLLA_ENF($posnr_wegegeld.$anteilig,$leistdat[4],$epreis,$leistdat[7]);
	$lfdnr++;
	my $km_preis = sprintf "%.2f",$leistdat[7]*$epreis;
	$summe_km+=$km_preis;
	print "Wegegeld summe: $summe_km, $km_preis\n" if ($debug > 1000);
      } elsif ($posnr_wegegeld eq '94') {
	$erg .= Heb_Edi->SLLA_ENF($posnr_wegegeld.$anteilig,$leistdat[4],$epreis,$leistdat[8]);
	$lfdnr++;
	my $km_preis = sprintf "%.2f",$leistdat[8]*$epreis;
	$summe_km+=$km_preis;
	print "Wegegeld summe: $summe_km, $km_preis\n" if ($debug > 1000);
      }
    }
  }

  # 6. BES Segment ausgeben
  $gesamtsumme += $summe_km;
  $erg .= Heb_Edi->SLLA_BES($gesamtsumme);

  # 6. UNT Endesegment ausgeben
  $erg .= Heb_Edi->UNT($lfdnr+1,$ref);
  print "$gesamtsumme, $summe_km\n" if ($debug > 10);
  return ($erg,$gesamtsumme);
}



sub gen_nutz {
  # generiert Nutzdatendatei
  # mit allen notwendigen Segmenten

  shift;

  my ($rechnr,$zik,$datenaustauschref) = @_;

  my $erg = '';

  my $test_ind = $h->parm_unique('IK'.$zik);
  my ($zw_erg,$erstelldatum)= Heb_Edi->UNB($zik,$datenaustauschref,$test_ind);
  $erg .= $zw_erg;
  $erg .= Heb_Edi->SLGA($rechnr,$zik);
  my ($erg_slla,$summe) = Heb_Edi->SLLA($rechnr,$zik);
  $erg .= $erg_slla;
  $erg .= Heb_Edi->UNZ($datenaustauschref);
  return ($erg,$erstelldatum);
}


sub sig {
  # signieren Nutzdatendatei

  shift;

  my ($dateiname,$sig_flag)=@_;

  if ($sig_flag == 0) {
    # PEM verschlüsseln
    open NUTZ, "cat $path/tmp/$dateiname |" or
      die "konnte Datei nicht NICHT signieren\n";
  }
  if ($sig_flag == 2) {
    # PEM signieren
    open NUTZ, "openssl smime -sign -in $path/tmp/$dateiname -nodetach -outform PEM -signer $path/privkey/cert.pem -inkey $path/privkey/privkey.pem |" or
      die "konnte Datei nicht PEM signieren\n";
  }
  if ($sig_flag == 3) {
    # DER signieren um später base64 encoden zu können
    open NUTZ, "openssl smime -encrypt -in $path/tmp/$dateiname -des3 -outform DER zik.pem |" or
      die "konnte Datei nicht DER verschlüsseln\n";
  }

  open AUS, ">$path/tmp/$dateiname.sig";
    
 LINE: while (my $zeile=<NUTZ>) {
    next LINE if($zeile =~ /PKCS7/); # macht mozilla auch nicht
  #  next LINE if($zeile =~ /^\n$/);
  #  next LINE if($zeile =~ /Content/);
    print AUS $zeile;
  }
  close NUTZ;close AUS;
  
  # Länge der Datei ermitteln
  my $st=stat($path."/tmp/$dateiname.sig") or die "Datei $dateiname.sig nicht vorhanden:$!\n";
  return ("$dateiname.sig",$st->size);
}


sub enc {
  # verschlüsselt Nutzdatendatei

  shift;

  my ($dateiname,$schl_flag)=@_;

  if ($schl_flag == 0) {
    # PEM verschlüsseln
    open NUTZ, "cat $path/tmp/$dateiname |" or
      die "konnte Datei nicht NICHT verschlüsseln\n";
  }
  if ($schl_flag == 2) {
    # PEM verschlüsseln
    open NUTZ, "openssl smime -encrypt -in $path/tmp/$dateiname -des3 -outform PEM $path/tmp/zik.pem |" or
      die "konnte Datei nicht PEM verschlüsseln\n";
  }
  if ($schl_flag == 3) {
    # DER verschlüsseln um später base64 encoden zu können
    open NUTZ, "openssl smime -encrypt -in $path/tmp/$dateiname -des3 -outform SMIME zik.pem |" or
      die "konnte Datei nicht DER verschlüsseln\n";
  }

  $dateiname =~ s/\.sig//g;
  open AUS, ">$path/tmp/$dateiname.enc";
    
 LINE: while (my $zeile=<NUTZ>) {
    next LINE if($zeile =~ /PKCS7/);
  #  next LINE if($zeile =~ /^\n$/);
  #  next LINE if($zeile =~ /Content/);
    print AUS $zeile;
  }
  close NUTZ;
  close AUS;
  
  # Länge der Datei ermitteln
  my $st=stat($path."/tmp/$dateiname.enc") or die "Datei $dateiname.enc nicht vorhanden:$!\n";
  return ("$dateiname.enc",$st->size);
}



sub edi_rechnung {
  # generiert komplette elektronische Rechnung 
  # Auftrags- und Nutzdatendatei
  
  shift;

  my ($rechnr) = @_;

  my $erg_nutz = ''; # Nutzdatendatei
  my $erg_auf  = ''; # Auftragsdatendatei
  my $erstell_nutz = ''; # Erstelldatum Nutzdatedatei
  my $erstell_auf = '';  # Erstelldatum Auftragsdatei


  # Rahmendaten für Rechnung aus Datenbank holen
  $l->rechnung_such("RECH_DATUM,BETRAG,FK_STAMMDATEN,IK","RECHNUNGSNR=$rechnr");
  my ($rechdatum,$betrag,$frau_id,$ik)=$l->rechnung_such_next();
  die "Rechnung nicht vorhanden Abbruch\n" if (!defined($rechdatum));

  # prüfen ob zu ik Zentral IK vorhanden ist
  my ($zik)=$k->krankenkasse_sel("ZIK",$ik);
  my $test_ind = $h->parm_unique('IK'.$zik);
  return undef if (!defined($test_ind)); # ZIK nicht als Annahmestelle vorhanden
  my $datenaustauschref = $h->parm_unique('DTAUS'.$zik);
  my $schl_flag = $h->parm_unique('SCHL'.$zik);
  my $sig_flag = $h->parm_unique('SIG'.$zik);

  ($erg_nutz,$erstell_nutz) = Heb_Edi->gen_nutz($rechnr,$zik,$datenaustauschref);

  # Dateinamen ermitteln
  my $dateiname='';
  if ($test_ind > 0) { # prüfen ob Test oder Produktion
    $dateiname .= 'ESOL0'; # Produktion (siehe 3.2.3)
  } else {
    $dateiname .= 'TSOL0'; # Test (siehe 3.2.3)
  }
  $dateiname .= sprintf "%3.3u",substr((sprintf "%5.5u",$datenaustauschref),2,3); # Transfernummer
  my $dateiname_orig = $dateiname;

  # Nutzdatendatei schreiben
  open NUTZ, ">$path/tmp/$dateiname"
    or die "Konnte Nutzdatei nicht zum Schreiben öffnen $!\n";
  print NUTZ $erg_nutz;
  close NUTZ;

  my $laenge_nutz=length($erg_nutz);

  # hier muss noch verschlüsselt und signiert werden
  # Public key der Krankenkasse schreiben
  my ($pubkey) = $k->krankenkasse_sel("PUBKEY",$zik);
  open KWRITE,">$path/tmp/zik.pem" or die "Kann key zu $zik nicht schreiben\n";
  print KWRITE "-----BEGIN CERTIFICATE-----\n";
  print KWRITE $pubkey;
  print KWRITE "-----END CERTIFICATE-----\n";
  close(KWRITE);

  # signieren
  ($dateiname,$laenge_nutz)=Heb_Edi->sig($dateiname,$sig_flag);
  # verschlüsseln
  ($dateiname,$laenge_nutz)=Heb_Edi->enc($dateiname,$schl_flag);


  ($erg_auf,$erstell_auf)  = 
    Heb_Edi->gen_auf($test_ind,$datenaustauschref,$zik,length($erg_nutz),
		     $laenge_nutz,
		     $h->parm_unique('SCHL'.$zik),
		     $h->parm_unique('SIG'.$zik));

  # jetzt Dateien schreiben mit physikalischen Namen

  # Auftragsdatei schreiben
  open AUF, ">$path/tmp/$dateiname_orig.AUF"
    or die "Konnte Auftragsdatei nicht zum Schreiben öffnen $!\n";
  print AUF $erg_auf;
  close (AUF);

  # wenn alles gelaufen ist, Datenaustauschreferenz erhöhen
  $datenaustauschref++;
  $datenaustauschref=0 if($datenaustauschref > 99999);
  $h->parm_up('DTAUS'.$zik,$datenaustauschref);
  return ($dateiname_orig,$erstell_auf,$erstell_nutz);
}


sub mail {
  # produziert Mail für eine Rechnung, die in Datei vorliegen muss
  # als Ergebniss wird ein String geliefert, der ggf. nach sendmail
  # gepiped werden kann.

  # Funktioniert nur für Verschlüsselte oder Signierte Mails

  shift;

  my ($dateiname,$rechnr,$erstell_auf,$erstell_nutz) = @_;


  # Rahmendaten für Rechnung aus Datenbank holen
  $l->rechnung_such("RECH_DATUM,BETRAG,FK_STAMMDATEN,IK","RECHNUNGSNR=$rechnr");
  my ($rechdatum,$betrag,$frau_id,$ik)=$l->rechnung_such_next();
  # prüfen ob zu ik Zentral IK vorhanden ist
  my ($zik)=$k->krankenkasse_sel("ZIK",$ik);
  my $test_ind = $h->parm_unique('IK'.$zik);
  return undef if (!defined($test_ind)); # ZIK nicht als Annahmestelle vorhanden

  my $boundary='Boundary-00='.$rechnr;

  my $dateiname_ext=$dateiname; # Dateiendung der Nutzdatendatei
  $dateiname_ext = $dateiname.'.sig' if ($h->parm_unique('SIG'.$zik) > 0);
  $dateiname_ext = $dateiname.'.enc' if ($h->parm_unique('SCHL'.$zik) > 0);

  # Header
  my $erg .= 'From: '.$h->parm_unique('HEB_IK').' <'.$h->parm_unique('HEB_EMAIL').'>'.$crlf;
  $erg .= 'To: '.$h->parm_unique('MAIL'.$zik).$crlf;
  $erg .= 'Subject: '.$h->parm_unique('HEB_IK').$crlf;
  $erg .= 'MIME-Version: 1.0'.$crlf;
  $erg .= 'Content-Type: Multipart/Mixed;'.$crlf;
  $erg .= '  boundary="'.$boundary.'"'.$crlf;
  $erg .= $crlf;

  # Message Body
  $erg .= '--'.$boundary.$crlf;
  $erg .= 'Content-Type: text/plain;'.$crlf;
  $erg .= '  charset="iso-8859-1"'.$crlf;
  $erg .= 'Content-Transfer-Encoding: quoted-printable'.$crlf;
  $erg .= 'Content-Disposition: inline'.$crlf;
  $erg .= $crlf;
  
  $erg .= encode_qp($dateiname.'.AUF,348,'.$erstell_auf,$crlf).$crlf;
  # Länge der Nutzdatendatei ermitteln
  my $st=stat("$path/tmp/$dateiname_ext") or die "Datei $dateiname_ext für Message Body nicht vorhanden:$!\n";
  my $laenge_nutz=$st->size;
  $erg .= encode_qp($dateiname.','.$laenge_nutz.','.$erstell_nutz,$crlf).$crlf;
  $erg .= encode_qp($h->parm_unique('HEB_VORNAME').' '.$h->parm_unique('HEB_NACHNAME'),$crlf).$crlf; # Absender Firmenname
  $erg .= encode_qp($h->parm_unique('HEB_VORNAME').' '.$h->parm_unique('HEB_NACHNAME'),$crlf).$crlf; # Absender Ansprechpartner
  $erg .= encode_qp($h->parm_unique('HEB_EMAIL'),$crlf).$crlf;
  $erg .= encode_qp($h->parm_unique('HEB_TEL'),$crlf).$crlf;
  $erg .= $crlf;

  # Attachment 1 Datei mit Auftragssatz
  $erg .= '--'.$boundary.$crlf;
  $erg .= 'Content-Type: text/plain;'.$crlf;
  $erg .= '  charset="iso-8859-1"'.$crlf;
  $erg .= 'Content-Transfer-Encoding: 7bit'.$crlf;
  $erg .= 'Content-Disposition: attachment; filename="'.$dateiname.'.AUF"'.$crlf;
  $erg .= $crlf;
  # Auftragsdatei lesen
  open AUF, "$path/tmp/$dateiname.AUF"
    or die "Konnte Auftragsdatei nicht öffnen\n";
  my $auf = <AUF>;
  $erg .= $auf.$crlf;
  close AUF;

  # Attachment 2 Datei mit Nutzdaten
  $erg .= '--'.$boundary.$crlf;
  if ($h->parm_unique('SCHL'.$zik) > 0 || $h->parm_unique('SIG'.$zik) > 0) {
    # Dateinamen extension muss jetzt erweitert werden
    $erg .= 'Content-Type: text/plain;'.$crlf;
    $erg .= '  charset="iso-8859-1"'.$crlf;
    $erg .= 'Content-Transfer-Encoding: 7bit'.$crlf;
    $erg .= 'Content-Disposition: attachment; filename="'.$dateiname.'"'.$crlf;
    $erg .= $crlf;
  }

  if ($h->parm_unique('SCHL'.$zik) == 0 && $h->parm_unique('SIG'.$zik) == 0) {
    $erg .= 'Content-Disposition: attachment; filename="'.$dateiname.'"'.$crlf;
    $erg .= 'Content-Type: text/plain;'.$crlf;
    $erg .= '  charset="iso-8859-1"'.$crlf;
    $erg .= '  name="'.$dateiname.'"'.$crlf;
    $erg .= 'Content-Transfer-Encoding: quoted-printable'.$crlf;
    $erg .= $crlf;
  }

  # Nutzdatendatei lesen
  open NUTZ, "$path/tmp/$dateiname_ext" or die "Konnte Nutzdatendatei nicht öffnen $!";
 LINE: while (my $zeile=<NUTZ>) {
    if ($h->parm_unique('SCHL'.$zik) == 0 && $h->parm_unique('SIG'.$zik) == 0) {
      # Datei wird quoted printable ausgegeben
      $zeile =~ s/$crlf$//; # vorher crlf entfernen
      $zeile = encode_qp($zeile,$crlf).$crlf;
    } else {
      chop($zeile);
      $zeile .= $crlf;
    }
    $erg .= $zeile;
  }
  close NUTZ;

  $erg .= $crlf;
  
  return $erg;
    
}
1;
