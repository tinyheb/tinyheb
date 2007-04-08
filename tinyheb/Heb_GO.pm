#!/usr/bin/perl -wT


# Package für die Hebammen Verarbeitung
# Plausiprüfungen der GO

# Copyright (C) 2007 Thomas Baum <thomas.baum@arcor.de>
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

package Heb_GO;

use strict;
use Date::Calc qw(Today Day_of_Week Delta_Days Add_Delta_Days Day_of_Week);

use lib "../";
use Heb_leistung;
use Heb_datum;
use Heb_stammdaten;

my $s = new Heb_stammdaten;
my $d = new Heb_datum;
my $l = new Heb_leistung;

our $HINT = '';

sub new {
  my $class = shift;
  my $self = {@_,};
  
  return undef unless(defined($self->{posnr}));
  return undef unless(defined($self->{frau_id}));
  return undef unless(defined($self->{datum_l}));
  my $dbh = Heb->connect;

  my @dat_frau = $s->stammdaten_frau_id($self->{frau_id});
  my $geb_kind=$d->convert($dat_frau[3]);
  $geb_kind = '' if ($geb_kind eq 'error');
  $geb_kind =~ s/-//g;
  $self->{geb_kind}=$geb_kind;
  $self->{dow}=Day_of_Week($d->jmt($self->{datum_l}));  # 1 == Montag 2 == Dienstag, ..., 7 == Sonntag
  $self->{datum_l} =~ s/-//g;

  ($self->{ltyp},$self->{begruendungspflicht},$self->{dauer},
   $self->{samstag},$self->{sonntag},$self->{nacht},$self->{zweitesmal})
   =$l->leistungsart_such_posnr
     ('LEISTUNGSTYP,BEGRUENDUNGSPFLICHT,DAUER,SAMSTAG,SONNTAG,NACHT,ZWEITESMAL',
      $self->{posnr},$self->{datum_l});
  $self->{zweitesmal}='' unless (defined($self->{zweitesmal}));
#  $self->{dbh}=$dbh;
  bless $self,ref $class || $class;
  return $self;
}

sub ersetze_samstag {
  # Wenn Samstag angegeben ist, prüfen ob posnr ersetzt werden muss
  my $self=shift;

  if ($self->{dow} == 6 && $self->{samstag} =~ /(\+{0,1})(\d{1,3})/ && $2 > 0 && $self->{zeit_von} >= 12) { # 
    # Samstag nach 12 Uhr und ob es sich um andere Positionsnummer handelt
    return $2 if ($1 ne '+');
  }
  return undef;
}

sub zuschlag_samstag {
  # prüft ob Zuschlag für diese Positionsnummer an einem Samstag  existiert
  my $self=shift;

  if ($self->{dow} == 6 && $self->{samstag} =~ /(\+{0,1})(\d{1,3})/ && $2 > 0 && $self->{zeit_von} >= 12) { # 
    # Samstag nach 12 Uhr und ob es sich um Zuschlags Positionsnummer handelt
    return $2 if ($1 eq '+');
  }
  return undef;
}


sub ersetze_sonntag {
  # Wenn Sonntag oder Feiertag angegeben ist, prüfen ob posnr ersetzt werden
  # muss
  my $self=shift;
  if (($self->{dow} == 7 || ($d->feiertag_datum($self->{datum_l})>0)) && $self->{sonntag} =~ /(\+{0,1})(\d{1,3})/ && $2 > 0) {
    return $2 if ($1 ne '+');
  }
  return undef;
}

sub zuschlag_sonntag {
  # prüft ob Zuschlag für diese Posnr an einem Sonntag oder Feiertag existiert
  my $self=shift;

  if (($self->{dow} == 7 || ($d->feiertag_datum($self->{datum_l})>0)) && $self->{sonntag} =~ /(\+{0,1})(\d{1,3})/ && $2 > 0) {
    return $2 if ($1 eq '+');
  }
  return undef;
}


sub ersetze_nacht {
  # wenn Nacht angegeben ist, prüfen ob posnr ersetzt werden muss
  my $self=shift;
  if ($self->{zeit_von} ne '' && ($d->zeit_h($self->{zeit_von}) < 8 || $d->zeit_h($self->{zeit_von})>=20) && $self->{nacht} =~ /(\+{0,1})(\d{1,3})/ && $2 > 0) {
    return $2 if($1 ne '+');
  }
  return undef;
}

sub zuschlag_nacht {
  # prüfen, ob Zuschlag für diese Posnr Nachts existiert
  my $self=shift;
  if ($self->{zeit_von} ne '' && ($d->zeit_h($self->{zeit_von}) < 8 || $d->zeit_h($self->{zeit_von})>=20) && $self->{nacht} =~ /(\+{0,1})(\d{1,3})/ && $2 > 0) {
    return $2 if($1 eq '+');
  }
  return undef;
}


sub zweitesmal {
  # prüfen ob andere Positionsnummer w/ Zweitesmal genutzt werden muss
  # wird genau dann gemacht, wenn die Positionsnummer am gleichen Tag
  # schon erfasst ist
  my $self=shift;

  if ($self->{zweitesmal} =~ /(\+{0,1})(\d{1,3})/ && $2 > 0) {
    return $2 if ($l->leistungsdaten_werte($self->{frau_id},"POSNR","POSNR=$self->{posnr} AND DATUM='$self->{datum_l}'")>0);
  }
  return undef;
}

sub zuschlag_plausi {
  # prüft ob eine Zuschlagspositionsnummer für einen Tag ausgewählt
  # wurde, an dem kein Zuschlag gewählt werden darf
  my $self=shift;
  if ($l->leistungsart_pruef_zus($self->{posnr},'SONNTAG') && ($self->{dow}==7 || ($d->feiertag_datum($self->{datum_l})))) {
    # alles ok
  } elsif ($l->leistungsart_pruef_zus($self->{posnr},'SAMSTAG') && $self->{dow}==6 && $d->zeit_h($self->{zeit_von}) >= 12) {
    # alles ok
  } elsif ($l->leistungsart_pruef_zus($self->{posnr},'NACHT') && ($d->zeit_h($self->{zeit_von}) < 8 || $d->zeit_h($self->{zeit_von}) >= 20)) {
    # alles ok
  } elsif (($l->leistungsart_pruef_zus($self->{posnr},'SONNTAG') || 
	    $l->leistungsart_pruef_zus($self->{posnr},'SAMSTAG') || 
	    $l->leistungsart_pruef_zus($self->{posnr},'NACHT')) && 
	   ($self->{dow} < 6 || $self->{dow}==6 && $d->zeit_h($self->{zeit_von}) < 12) || 
	   $d->zeit_h($self->{zeit_von})<8 && $d->zeit_h($self->{zeit_von}) > 20) {
    return 1;
  }
  return undef;
}


sub pos1_plausi {
  # prüft ob Positionsnummer 1 erfasst wurde
  # liefert als Ergebnis '' wenn kein Fehler aufgetreten ist oder
  # Fehlermeldung wenn Fehler aufgetreten ist
  my $self = shift;
  my ($posnr,$frau_id,$datum_l) = 
    ($self->{posnr},$self->{frau_id},$self->{datum_l});

  return '' if $posnr ne '1';
  if ($l->leistungsdaten_werte($frau_id,"POSNR","POSNR=$posnr") > 12) {
    return 'FEHLER: Position ist höchstens zwölfmal berechnungsfähig\nes wurde nichts gespeichert';
  }
  if ($l->leistungsdaten_werte($frau_id,"POSNR",
                               "POSNR in (2,4,5,8) and DATUM='$datum_l'")) {
    return 'FEHLER: Positionsnummer ist neben Leistungen nach 2,4,5 und 8\n an demselben Tag nicht berechnungsfähig\nes wurde nichts gespeichert';
  }
  return '';
}



sub pos7_plausi {
  # Positionsnummer 7 darf die maximale Dauer 14 Stunden nicht überschreiten
  my $self=shift;
  my ($zeit_von,$zeit_bis) = ($self->{zeit_von},$self->{zeit_bis});
  my ($posnr,$frau_id)=($self->{posnr},$self->{frau_id});

  return '' if $posnr ne '7';
  # zunächst die bisherige Dauer berechnen
  my $dauer=0;
  $l->leistungsdaten_werte($frau_id,"ZEIT_VON,ZEIT_BIS","POSNR=$posnr");
  while (my($alt_zeit_von,$alt_zeit_bis)=$l->leistungsdaten_werte_next()) {
    $dauer+=$d->dauer_m($alt_zeit_bis,$alt_zeit_von);
  }
  my $erfasst=sprintf "%3.2f",$dauer/60;
  $erfasst =~ s/\./,/g;
  $dauer += $d->dauer_m($zeit_bis,$zeit_von);
  if ($dauer > (14*60)) {
    return 'FEHLER: Geburtsvorbereitung in der Gruppe höchsten 14 Stunden\nschon erfasst '.$erfasst.' Stunden\nes wurde nichts gespeichert\n';
  }
  return '';
}


sub pos8_plausi {
  # Positionsnummer 8 darf die maximale Dauer 14 Stunden nicht überschreiten
  my $self=shift;
  my ($zeit_von,$zeit_bis) = ($self->{zeit_von},$self->{zeit_bis});
  my ($posnr,$frau_id)=($self->{posnr},$self->{frau_id});

  return '' if $posnr ne '8';
  # zunächst die bisherige Dauer berechnen
  my $dauer=0;
  $l->leistungsdaten_werte($frau_id,"ZEIT_VON,ZEIT_BIS","POSNR=$posnr");
  while (my($alt_zeit_von,$alt_zeit_bis)=$l->leistungsdaten_werte_next()) {
    $dauer+=$d->dauer_m($alt_zeit_bis,$alt_zeit_von);
  }
  my $erfasst=sprintf "%3.2f",$dauer/60;
  $erfasst =~ s/\./,/g;
  $dauer += $d->dauer_m($zeit_bis,$zeit_von);
  if ($dauer > (14*60)) {
    return 'FEHLER: Geburtsvorbereitung bei Einzelunterweisung höchsten 14 Stunden\nschon erfasst '.$erfasst.' Stunden\nes wurde nichts gespeichert\n';
  }
  return '';
}


sub pos40_plausi {
  # Positionsnummer 40 darf die maximale Dauer von 10 Stunden nicht überschreiten
  my $self=shift;
  my ($zeit_von,$zeit_bis) = ($self->{zeit_von},$self->{zeit_bis});
  my ($posnr,$frau_id)=($self->{posnr},$self->{frau_id});

  return '' if $posnr ne '40';
  # zunächst die bisherige Dauer berechnen
  my $dauer=0;
  $l->leistungsdaten_werte($frau_id,"ZEIT_VON,ZEIT_BIS","POSNR=$posnr");
  while (my($alt_zeit_von,$alt_zeit_bis)=$l->leistungsdaten_werte_next()) {
    $dauer+=$d->dauer_m($alt_zeit_bis,$alt_zeit_von);
  }
  my $erfasst=sprintf "%3.2f",$dauer/60;
  $erfasst =~ s/\./,/g;
  $dauer += $d->dauer_m($zeit_bis,$zeit_von);
  if ($dauer > (10*60)) {
    return 'FEHLER: Rückbildungsgymnastik in der Gruppe höchsten 10 Stunden\nschon erfasst '.$erfasst.' Stunden\nes wurde nichts gespeichert\n';
  }
  return '';
}



sub pos2458_plausi {
  # prüft für Positionsnummer 2,4,5,8 ob schon Positionsnummer 1 erfasst
  # wurde
  # liefert Ergebnis '' wenn kein Fehler aufgetreten ist oder
  # Fehlermeldung wenn Fehler aufgetreten ist
  my $self=shift;
  my ($posnr,$frau_id,$datum_l)=
    ($self->{posnr},$self->{frau_id},$self->{datum_l});

  return '' if ($posnr ne '2' && $posnr ne '4' && 
                $posnr ne '5' && $posnr ne '8');
  if ($l->leistungsdaten_werte($frau_id,"POSNR",
                               "POSNR=1 and DATUM='$datum_l'")) {
    return 'FEHLER: Positionsnummer '.$posnr.' ist neben Leistungen nach 1\nan demselben Tag nicht berechnungsfähig\nes wurde nichts gespeichert';
  }
  return '';
}



sub dauer_plausi {
  # prüft, ob begründung für Positionsnummer erfasst werden muss,
  # dass ist genau dann der Fall, wenn dauer > DAUER.
  my $self=shift;
  my ($posnr,$dauer,$datum_l,$begruendung)=
    ($self->{posnr},$self->{dauer},$self->{datum_l},$self->{begruendung});


  if ($self->{dauer} > 0 && 
      $self->{dauer} < $d->dauer_m($self->{zeit_bis},$self->{zeit_von}) && 
      $begruendung eq '') {
    return 'FEHLER: Bei Leistung nach Positionsnummer '.$posnr.' länger als\n'.$self->{dauer}.' Minuten ist dies zu begründen\nes wurde nichts gespeichert';
  }
  return '';
}


sub ltyp_plausi {
  # prüft, das Leistungstyp A (Mutterschaftsvorsorge und Schwangeren-
  # betreuung vor Geburt des Kindes erfolgen,
  # C (Wochenbett) nur nach Geburt des Kindes
  # Prüfung wird nur durchgeführt, wenn Geburtsdatum des Kindes bekannt ist
  my $self = shift;
  my ($posnr,$frau_id,$datum_l)=
    ($self->{posnr},$self->{frau_id},$self->{datum_l});

  my $geb_kind=$self->{geb_kind};
  return '' if($geb_kind eq '');
  my $ltyp=$self->{ltyp};

  if ($ltyp eq 'A' && $geb_kind < $datum_l) {
    return 'FEHLER: Leistungen der Schwangerenbetreuung können nur vor Geburt des\nKindes erbracht werden.\nEs wurde nichts gespeichert';
  }
  if ($ltyp eq 'C' && $geb_kind > $datum_l) {
    return 'FEHLER: Leistungen im Wochenbett können erst nach Geburt des Kindes\nerbracht werden. Es wurde nichts gespeichert.';
  }
  return '';
}


sub Cd_plausi {
  # prüft, ob Posnr 25,26 innerhalb der ersten zehn Tage nach der Geburt
  # abgerechnet werden --> OK
  # oder ob Posnr 25,26,29,32,33 nach zehn Tagen 
  # innerhalb von 8 Wochen = 56 Tage mit Begründung --> OK
  # oder nach 8 Wochen mit Begründung 'auf ärztliche Anordnung' --> OK
  my $self=shift;
  my ($posnr,$datum_l,$begruendung)=    
    ($self->{posnr},$self->{datum_l},$self->{begruendung});

  return '' if ($posnr ne '25' && $posnr ne '26' && $posnr ne '29' &&
                $posnr ne '32' && $posnr ne '33');

  my $geb_kind=$self->{geb_kind};
  return '' if($geb_kind eq '');

  my $days = Delta_Days(unpack('A4A2A2',$geb_kind),unpack('A4A2A2',$datum_l));
  if ($days < 11 && ($posnr eq '25' || $posnr eq '26')) {
    return '';
  } elsif ($days < 11 && $posnr ne '25' && $posnr ne '26' && 
           $begruendung eq '') {
    return '\nFEHLER: innerhalb der ersten 10 Tage dürfen nur Posnr 25 und 26\nohne Begründung zweimal abgerechnet werden.\nEs wurde nichts gespeichert';
  } elsif ($days < 57 && $begruendung eq '') {
    return '\nFEHLER: Position '.$posnr.' nach 10 Tagen innerhalb 8 Wochen nur mit Begründung.\nEs wurde nichts gespeichert';
  } elsif ($days > 56 && ($begruendung !~ /Anordnung/)) {
    return '\nFEHLER: Position '.$posnr.' nach 8 Wochen nur auf ärztliche Anordnung\nEs wurde nichts gespeichert';
  }
  return '';
}


sub Cc_plausi {
  # Leistungen nach 22,23,25 bis 33 und 35 sind nur mehr als 16 mal
  # abrechenbar, wenn ärztlich angeordnet
  my $self=shift;
  my ($posnr,$datum_l,$begruendung)=   
    ($self->{posnr},$self->{datum_l},$self->{begruendung});

  return '' if ($posnr ne '22' && $posnr ne '23' && $posnr ne '25' &&
                $posnr ne '26' && $posnr ne '27' && $posnr ne '28' &&
                $posnr ne '29' && $posnr ne '30' && $posnr ne '31' &&
                $posnr ne '32' && $posnr ne '33' && $posnr ne '35');


  my $geb_kind=$self->{geb_kind};
  return '' if ($geb_kind eq '');
  my $days = Delta_Days(unpack('A4A2A2',$geb_kind),unpack('A4A2A2',$datum_l));
  my $zehn_spaeter=join('-',Add_Delta_Days(unpack('A4A2A2',$geb_kind),10));
  if ($days > 10 && 
      ($begruendung !~ /Anordnung/) &&
      ($l->leistungsdaten_werte($self->{frau_id},"POSNR","POSNR in (22,23,25,26,28,29,30,31,32,33,35) AND DATUM>'$zehn_spaeter'") > 16) ) {
    return 'FEHLER: Position '.$posnr.' ist ab dem 11 Tag höchstens 16 mal berechnungsfähig\nohne ärztliche Anordnung\nes wurde nichts gespeichert';
  }
  return '';
}


sub Begruendung_plausi {
  # Falls in den Leistungsdaten das Feld Begruendungspflicht auf j steht,
  # muss eine Begründung vorhanden sein
  my $self=shift;
  my ($posnr,$datum_l,$begruendung)=    
    ($self->{posnr},$self->{datum_l},$self->{begruendung});

  if (uc $self->{begruendungspflicht} eq 'J' && 
      (!defined($begruendung ) || $begruendung eq '')) {
    return 'FEHLER: Bei Position '.$posnr.' ist eine Begründung notwendig\n es wurde nichts gespeichert';
  }
  return '';
}


1;
