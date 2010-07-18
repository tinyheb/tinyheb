# Package für die Hebammen Verarbeitung
# Plausiprüfungen der GO

# $Id$
# Tag $Name$

# Copyright (C) 2007 - 2010 Thomas Baum <thomas.baum@arcor.de>
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

package Heb_GO;

use strict;
use Date::Calc qw(Today Day_of_Week Delta_Days Add_Delta_Days Day_of_Week Add_Delta_YM);

use lib "../";
use Heb_leistung;
use Heb_datum;
use Heb_stammdaten;

my $h = new Heb;
my $s = new Heb_stammdaten;
my $d = new Heb_datum;
my $l = new Heb_leistung;

our $HINT = '';
my $dbh = $h->connect;

sub new {
  my $class = shift;
  my $self = {@_,};
  
  return undef unless($self->{posnr});
  return undef unless($self->{frau_id});
  return undef unless($self->{datum_l});

  my @dat_frau = $s->stammdaten_frau_id($self->{frau_id});
  my $geb_kind=$d->convert($dat_frau[3]);
  $geb_kind = '' if (!$geb_kind || $geb_kind eq 'error');
  $geb_kind =~ s/-//g;
  $self->{geb_kind}=$geb_kind;
  $self->{dow}=Day_of_Week($d->jmt($self->{datum_l}));  # 1 == Montag 2 == Dienstag, ..., 7 == Sonntag
  $self->{datum_l} =~ s/-//g;

  ($self->{ltyp},$self->{begruendungspflicht},$self->{dauer},
   $self->{samstag},$self->{sonntag},$self->{nacht},$self->{zweitesmal},
   $self->{fuerzeit},$self->{nicht},$self->{pzn},
   $self->{einzelpreis},$self->{zusatzgebuehren1})
   =$l->leistungsart_such_posnr
     ('LEISTUNGSTYP,BEGRUENDUNGSPFLICHT,DAUER,SAMSTAG,SONNTAG,NACHT,ZWEITESMAL,FUERZEIT,NICHT,PZN,EINZELPREIS,ZUSATZGEBUEHREN1',
      $self->{posnr},$self->{datum_l});
  $self->{zweitesmal}='' unless ($self->{zweitesmal});
  $self->{samstag}='' unless($self->{samstag});
  $self->{sonntag}='' unless($self->{sonntag});
  $self->{nacht}='' unless($self->{nacht});
  $self->{dauer}=0 unless($self->{dauer});
  $self->{ltyp}='' unless($self->{ltyp});
  $self->{einzelpreis}=0 unless($self->{einzelpreis});
  $self->{zusatzgebuehren1}='' unless($self->{zusatzgebuehren1});
  $self->{begruendungspflicht}='n' unless($self->{begruendungspflicht});

  $self->{TODAY} = sprintf "%4.4u%2.2u%2.2u",Today();

  bless $self,ref $class || $class;
  return $self;
}

sub ersetze_samstag {
  # Wenn Samstag angegeben ist, prüfen ob posnr ersetzt werden muss
  my $self=shift;

  return undef unless($self->{samstag});

  if ($self->{dow} == 6 && $self->{samstag} =~ /(\+{0,1})(\d{1,4})(\w*)/ && $2 > 0 && $d->zeit_h($self->zeit) >= 12) { # 
    # Samstag nach 12 Uhr und ob es sich um andere Positionsnummer handelt
    return $2.$3 if ($1 ne '+');
  }
  return undef;
}

sub zuschlag_samstag {
  # prüft ob Zuschlag für diese Positionsnummer an einem Samstag  existiert
  my $self=shift;

  return undef unless($self->{samstag});

  if ($self->{dow} == 6 && $self->{samstag} =~ /(\+{0,1})(\d{1,4})(\w*)/ && $2 > 0 && $d->zeit_h($self->zeit) >= 12) { # 
    # Samstag nach 12 Uhr und ob es handelt sich um Zuschlags Positionsnummer
    return $2.$3 if ($1 eq '+');
  }
  return undef;
}


sub ersetze_sonntag {
  # Wenn Sonntag oder Feiertag angegeben ist, prüfen ob posnr ersetzt werden
  # muss
  my $self=shift;

  return undef unless($self->{sonntag});

  if (($self->{dow} == 7 || ($d->feiertag_datum($self->{datum_l})>0)) && $self->{sonntag} =~ /(\+{0,1})(\d{1,4}(\w*))/ && $2 > 0) {
    return $2.$3 if ($1 ne '+');
  }
  return undef;
}

sub zuschlag_sonntag {
  # prüft ob Zuschlag für diese Posnr an einem Sonntag oder Feiertag existiert
  my $self=shift;

  return undef unless($self->{sonntag});

  if (($self->{dow} == 7 || ($d->feiertag_datum($self->{datum_l})>0)) && $self->{sonntag} =~ /(\+{0,1})(\d{1,4})(\w*)/ && $2 > 0) {
    return $2.$3 if ($1 eq '+');
  }
  return undef;
}


sub ersetze_nacht {
  # wenn Nacht angegeben ist, prüfen ob posnr ersetzt werden muss
  my $self=shift;

  return undef unless($self->{nacht});

  if ($self->zeit && ($d->zeit_h($self->zeit) < 8 || $d->zeit_h($self->zeit)>=20) && $self->{nacht} =~ /(\+{0,1})(\d{1,4})(\w*)/ && $2 > 0) {
    return $2.$3 if($1 ne '+');
  }
  return undef;
}

sub zuschlag_nacht {
  # prüfen, ob Zuschlag für diese Posnr Nachts existiert
  my $self=shift;

  return undef unless($self->{nacht});

  if ($self->zeit  && ($d->zeit_h($self->zeit) < 8 || $d->zeit_h($self->zeit)>=20) && $self->{nacht} =~ /(\+{0,1})(\d{1,3})(\w*)/ && $2 > 0) {
    return $2.$3 if($1 eq '+');
  }
  return undef;
}


sub zweitesmal {
  # prüfen ob andere Positionsnummer w/ Zweitesmal genutzt werden muss
  # wird genau dann gemacht, wenn die Positionsnummer am gleichen Tag
  # schon erfasst ist
  my $self=shift;

  if ($self->{zweitesmal} =~ /(\+{0,1})(\d{1,4})/ && $2 > 0) {
    return $2 if ($l->leistungsdaten_werte($self->{frau_id},"POSNR","POSNR=$self->{posnr} AND DATUM='$self->{datum_l}'")>0);
  }
  return undef;
}

sub zuschlag_plausi {
  # prüft ob eine Zuschlagspositionsnummer für einen Tag ausgewählt
  # wurde, an dem kein Zuschlag gewählt werden darf
  my $self=shift;
#  warn "ZEIT :",$self->zeit,":",$l->zeit_ende($self->{posnr});
  if ($l->leistungsart_pruef_zus($self->{posnr},'SONNTAG') && ($self->{dow}==7 || ($d->feiertag_datum($self->{datum_l})))) {
    # alles ok
  } elsif ($l->leistungsart_pruef_zus($self->{posnr},'SAMSTAG') && $self->{dow}==6 && $d->zeit_h($self->zeit) >= 12) {
    # alles ok
  } elsif ($l->leistungsart_pruef_zus($self->{posnr},'NACHT') && ($d->zeit_h($self->zeit) < 8 && $self->zeit || $d->zeit_h($self->zeit) >= 20)) {
    # alles ok
  } elsif (($l->leistungsart_pruef_zus($self->{posnr},'SONNTAG') || 
	    $l->leistungsart_pruef_zus($self->{posnr},'SAMSTAG') || 
	    $l->leistungsart_pruef_zus($self->{posnr},'NACHT')) && 
	   # zuschlagpflichtig und Montag bis Freitag -> Fehler
	   ($self->{dow} < 6 || 
	    # Samstag ohne Uhrzeit -> Fehler
	    $self->{dow}==6 && !$self->zeit ||
	    # Samstag vor 12 -> Fehler 
	    $self->{dow}==6 && $self->zeit && $d->zeit_h($self->zeit) < 12)# || 
	   # alle anderen Tag vor 8 und vor 20
#	   $d->zeit_h($self->zeit)<8 && $d->zeit_h($self->zeit) > 20) 
	   )
    {
    # Fehler
    return 1;
  }
  return undef;
}


sub pos1_plausi {
  # prüft ob Positionsnummer 1 erfasst wurde
  # liefert als Ergebnis '' wenn kein Fehler aufgetreten ist oder
  # Fehlermeldung wenn Fehler aufgetreten ist
  my $self = shift;
  return '' if $self->{posnr} ne '1';

  my ($posnr,$frau_id,$datum_l) = 
    ($self->{posnr},$self->{frau_id},$self->{datum_l});

  if ($l->leistungsdaten_werte($frau_id,"POSNR","POSNR=$posnr") >= 12) {
    return 'FEHLER: Position ist höchstens zwölfmal berechnungsfähig\nes wurde nichts gespeichert';
  }
  return '';
}

sub pos010_plausi {
  # prüft ob Positionsnummer 010 erfasst wurde

  # liefert als Ergebnis '' wenn kein Fehler aufgetreten ist oder
  # Fehlermeldung wenn Fehler aufgetreten ist
  my $self = shift;
  return '' if $self->{posnr} ne '010';

  if ($l->leistungsdaten_werte($self->{frau_id},"POSNR",
			       "POSNR='010'") >= 12) {
    return 'FEHLER: Position ist höchstens zwölfmal berechnungsfähig\nes wurde nichts gespeichert';
  }

  # prüfen, falls mehr als einmal pro Tag, ob Begründung und Uhrzeit vorhanden
  if ($l->leistungsdaten_werte($self->{frau_id},"POSNR",
			       "POSNR='010' AND DATUM ='$self->{datum_l}'") >= 1) {
    if ($self->{begruendung} eq '' || !$self->zeit()) {
      return 'FEHLER: Position 010 mehr als einmal pro Tag nur mit Begründung und Uhrzeit\nes wurde nichts gespeichert';
    }
  }

  return '';
}



sub pos0100_plausi {
  # prüft ob Positionsnummer 0100,0101, 0102 erfasst wurden

  # liefert als Ergebnis '' wenn kein Fehler aufgetreten ist oder
  # Fehlermeldung wenn Fehler aufgetreten ist
  my $self = shift;
  return '' if ($self->{posnr} ne '0100' &&
		$self->{posnr} ne '0101' &&
		$self->{posnr} ne '0102');

  if ($l->leistungsdaten_werte($self->{frau_id},"POSNR",
			       "POSNR in('0100','0101','0102')") >= 12) {
    return 'FEHLER: Position ist höchstens zwölfmal berechnungsfähig\nes wurde nichts gespeichert';
  }

  # prüfen, falls mehr als einmal pro Tag, ob Begründung und Uhrzeit vorhanden
  if ($l->leistungsdaten_werte($self->{frau_id},"POSNR",
			       "POSNR in('0100','0101','0102') AND DATUM ='$self->{datum_l}'") >= 1) {
    if ($self->{begruendung} eq '' || !$self->zeit()) {
      return 'FEHLER: Position '.$self->{posnr}.' mehr als einmal pro Tag nur mit Begründung und Uhrzeit\nes wurde nichts gespeichert';
    }
  }

  return '';
}



sub pos020_plausi {
  # prüft ob Positionsnummer 020 erfasst wurde

  # liefert als Ergebnis undef wenn kein Fehler aufgetreten ist oder
  # Fehlermeldung wenn Fehler aufgetreten ist
  my $self = shift;
  return if $self->{posnr} ne '020';

  # mindestens 30 Minuten
  my $dauer=$d->dauer_m($self->{zeit_bis},$self->{zeit_von});
  if ($dauer < 30) {
    return 'FEHLER: Vorgespräch mindestens 30 Minuten\nes wurde nichts gespeichert';
  }
  if ($dauer > 60 && $self->{begruendung} !~ 'geplante Hausgeburt') {
    return 'FEHLER: Vorgespräch maximal 60 Minuten\nes wurde nichts gespeichert';
  }

  if ($dauer > 90 && $self->{begruendung} =~ 'geplante Hausgeburt') {
    return 'FEHLER: Vorgespräch bei geplanter Hausgeburt maximal 90 Minuten\nes wurde nichts gespeichert';
  }


  # prüfen, falls mehr als einmal pro Tag, ob Begründung und Uhrzeit vorhanden
  my $anzahl=$l->leistungsdaten_werte($self->{frau_id},"POSNR",
				     "POSNR='020'");

  if ($anzahl >= 2) {
    return 'FEHLER: Vorgespräch maximal 2 mal abrechenbar\nes wurde nichts gespeichert!';
  }

  if ($anzahl >= 1) {
    if ($self->{begruendung} !~ 'geplante Hausgeburt') {
      return q!FEHLER: Vorgespräch mehr als einmal nur mit Begründung 'geplante Hausgeburt'\nes wurde nichts gespeichert!;
    }
  }

  return undef;
}





sub pos0200_plausi {
  # prüft ob Positionsnummer 0200 erfasst wurde

  # liefert als Ergebnis undef wenn kein Fehler aufgetreten ist oder
  # Fehlermeldung wenn Fehler aufgetreten ist
  my $self = shift;
  return if $self->{posnr} ne '0200';

  # mindestens 30 Minuten
  my $dauer=$d->dauer_m($self->{zeit_bis},$self->{zeit_von});
  if ($dauer < 30) {
    return 'FEHLER: Vorgespräch mindestens 30 Minuten\nes wurde nichts gespeichert';
  }
  if ($dauer > 90) {
    return 'FEHLER: Vorgespräch maximal 90 Minuten\nes wurde nichts gespeichert';
  }

  # prüfen, falls mehr als einmal pro Tag, ob Begründung und Uhrzeit vorhanden
  my $anzahl=$l->leistungsdaten_werte($self->{frau_id},"POSNR",
				     "POSNR='0200'");

  if ($anzahl >= 2) {
    return 'FEHLER: Vorgespräch maximal 2 mal abrechenbar\nes wurde nichts gespeichert!';
  }

  if ($anzahl >= 1) {
    if ($self->{begruendung} !~ 'geplante Hausgeburt') {
      return q!FEHLER: Vorgespräch mehr als einmal nur mit Begründung 'geplante Hausgeburt'\nes wurde nichts gespeichert!;
    }
  }

  return undef;
}





sub pos6_plausi {
  # Positionsnummer 6 mehr als 2 mal am selben Tag nur auf
  # ärztliche Anordnung
  my $self=shift;
  
  return if ($self->{posnr} ne '6');
  
  if ($l->leistungsdaten_werte($self->{frau_id},"POSNR","POSNR=$self->{posnr} AND DATUM='$self->{datum_l}'")>=2 && $self->{begruendung} !~ /Anordnung/ ) {
    return '\nFEHLER: Position '.$self->{posnr}.' mehr als 2 mal am selben Tag nur auf ärztliche Anordnung\nEs wurde nichts gespeichert';
  }
  return undef;
}


sub pos060_plausi {
  # Positionsnummer 060 mehr als 2 mal am selben Tag nur auf
  # ärztliche Anordnung
  my $self=shift;
  
  return if ($self->{posnr} ne '060');
  
  if ($l->leistungsdaten_werte($self->{frau_id},"POSNR","POSNR=$self->{posnr} AND DATUM='$self->{datum_l}'")>=2 && $self->{begruendung} !~ /Anordnung/ ) {
    return '\nFEHLER: Position '.$self->{posnr}.' mehr als 2 mal am selben Tag nur auf ärztliche Anordnung\nEs wurde nichts gespeichert';
  }
  return undef;
}



sub pos0600_plausi {
  # Positionsnummer 0600 mehr als 2 mal am selben Tag nur auf
  # ärztliche Anordnung
  my $self=shift;
  
  return if ($self->{posnr} ne '0600');
  
  if ($l->leistungsdaten_werte($self->{frau_id},"POSNR","POSNR=$self->{posnr} AND DATUM='$self->{datum_l}'")>=2 && $self->{begruendung} !~ /Anordnung/ ) {
    return '\nFEHLER: Position '.$self->{posnr}.' mehr als 2 mal am selben Tag nur auf ärztliche Anordnung\nEs wurde nichts gespeichert';
  }
  return undef;
}



sub pos7_plausi {
  # Positionsnummer 7 darf die maximale Dauer 14 Stunden nicht überschreiten
  my $self=shift;
  return '' if $self->{posnr} ne '7';

  my ($zeit_von,$zeit_bis) = ($self->{zeit_von},$self->{zeit_bis});
  my ($posnr,$frau_id)=($self->{posnr},$self->{frau_id});

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


sub pos070_plausi {
  # Positionsnummer 070 darf die maximale Dauer 14 Stunden nicht überschreiten
  my $self=shift;
  return '' if $self->{posnr} ne '070';

  my ($zeit_von,$zeit_bis) = ($self->{zeit_von},$self->{zeit_bis});
  my ($posnr,$frau_id)=($self->{posnr},$self->{frau_id});
  
  # zunächst die bisherige Dauer berechnen
  my $dauer=0;
  $l->leistungsdaten_werte($frau_id,"ZEIT_VON,ZEIT_BIS","POSNR='$posnr'");
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



sub pos0700_plausi {
  # Positionsnummer 0700 darf die maximale Dauer 14 Stunden nicht überschreiten
  my $self=shift;
  return '' if $self->{posnr} ne '0700';

  my ($zeit_von,$zeit_bis) = ($self->{zeit_von},$self->{zeit_bis});
  my ($posnr,$frau_id)=($self->{posnr},$self->{frau_id});
  
  # zunächst die bisherige Dauer berechnen
  my $dauer=0;
  $l->leistungsdaten_werte($frau_id,"ZEIT_VON,ZEIT_BIS","POSNR='$posnr'");
  while (my($alt_zeit_von,$alt_zeit_bis)=$l->leistungsdaten_werte_next()) {
    $dauer+=$d->dauer_m($alt_zeit_bis,$alt_zeit_von);
  }
  my $erfasst=sprintf "%3.2f",$dauer/60;
  $erfasst =~ s/\./,/g;
  $dauer += $d->dauer_m($zeit_bis,$zeit_von);
#  warn "0700: dauer $dauer\n";
  if ($dauer > (14*60)) {
    return 'FEHLER: Geburtsvorbereitung in der Gruppe höchsten 14 Stunden\nschon erfasst '.$erfasst.' Stunden\nes wurde nichts gespeichert\n';
  }
  return '';
}




sub pos8_plausi {
  # Positionsnummer 8 darf die maximale Dauer 14 Stunden nicht überschreiten
  my $self=shift;
  return '' if $self->{posnr} ne '8';

  my ($zeit_von,$zeit_bis) = ($self->{zeit_von},$self->{zeit_bis});
  my ($posnr,$frau_id)=($self->{posnr},$self->{frau_id});

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



sub pos080_plausi {
  # Positionsnummer 8 darf die maximale Dauer 
  # höchstens 14 Unterichtseinheiten a 30 Minuten nicht überschreiten
  my $self=shift;
  return '' if $self->{posnr} ne '080';

  my ($zeit_von,$zeit_bis) = ($self->{zeit_von},$self->{zeit_bis});
  my ($posnr,$frau_id)=($self->{posnr},$self->{frau_id});

  # zunächst die bisherige Dauer berechnen
  my $vk=0;
  my $dauer_alt=0;
  $l->leistungsdaten_werte($frau_id,"ZEIT_VON,ZEIT_BIS","POSNR=$posnr");
  while (my($alt_zeit_von,$alt_zeit_bis)=$l->leistungsdaten_werte_next()) {
    my $dauer_akt=$d->dauer_m($alt_zeit_bis,$alt_zeit_von);
    $vk = sprintf "%3.1u",($dauer_akt / $self->{fuerzeit});
    $vk++ if ($vk*$self->{fuerzeit} < $dauer_akt);
    $vk = sprintf "%1.1u",$vk;
    $dauer_alt += $vk;
  }

  # aktuelle Zeit berechnen
  my $dauer_akt=$d->dauer_m($self->{zeit_bis},$self->{zeit_von});
  $vk = sprintf "%3.1u",($dauer_akt / $self->{fuerzeit});
  $vk++ if ($vk*$self->{fuerzeit} < $dauer_akt);
  $vk = sprintf "%1.1u",$vk;

  if ($dauer_alt+$vk > 14) {
    return 'FEHLER: Geburtsvorbereitung bei Einzelunterweisung höchsten 14 Unterichtseinheiten a 30 Minuten bis jetzt wurden '.$dauer_alt.' Einheiten erfasst\nes wurde nichts gespeichert\n';
  }
  return '';
}



sub pos0800_plausi {
  # Positionsnummer 0800 darf die maximale Dauer 
  # höchstens 14 Unterichtseinheiten a 30 Minuten nicht überschreiten
  my $self=shift;
  return '' if $self->{posnr} ne '0800';

  my ($zeit_von,$zeit_bis) = ($self->{zeit_von},$self->{zeit_bis});
  my ($posnr,$frau_id)=($self->{posnr},$self->{frau_id});

  # zunächst die bisherige Dauer berechnen
  my $vk=0;
  my $dauer_alt=0;
  $l->leistungsdaten_werte($frau_id,"ZEIT_VON,ZEIT_BIS","POSNR='$posnr'");
  while (my($alt_zeit_von,$alt_zeit_bis)=$l->leistungsdaten_werte_next()) {
    my $dauer_akt=$d->dauer_m($alt_zeit_bis,$alt_zeit_von);
    $vk = sprintf "%3.1u",($dauer_akt / $self->{fuerzeit});
    $vk++ if ($vk*$self->{fuerzeit} < $dauer_akt);
    $vk = sprintf "%1.1u",$vk;
    $dauer_alt += $vk;
  }

  # aktuelle Zeit berechnen
  my $dauer_akt=$d->dauer_m($self->{zeit_bis},$self->{zeit_von});
  $vk = sprintf "%3.1u",($dauer_akt / $self->{fuerzeit});
  $vk++ if ($vk*$self->{fuerzeit} < $dauer_akt);
  $vk = sprintf "%1.1u",$vk;

  my $ueinheiten = 14;
  $ueinheiten  = 28 if ($self->{datum_l} > 20100630);
  if ($dauer_alt+$vk > $ueinheiten) {
    return 'FEHLER: Geburtsvorbereitung bei Einzelunterweisung höchsten '.$ueinheiten.' Unterichtseinheiten bis jetzt wurden '.$dauer_alt.' Einheiten erfasst\nes wurde nichts gespeichert\n';
  }
  return '';
}



sub pos40_plausi {
  # Positionsnummer 40 darf die maximale Dauer von 10 Stunden nicht überschreiten
  my $self=shift;
  return '' if $self->{posnr} ne '40';

  my ($posnr,$frau_id)=($self->{posnr},$self->{frau_id});

  # zunächst die bisherige Dauer berechnen
  my $dauer=0;
  $l->leistungsdaten_werte($frau_id,"ZEIT_VON,ZEIT_BIS","POSNR=$posnr");
  while (my($alt_zeit_von,$alt_zeit_bis)=$l->leistungsdaten_werte_next()) {
    $dauer+=$d->dauer_m($alt_zeit_bis,$alt_zeit_von);
  }
  my $erfasst=sprintf "%3.2f",$dauer/60;
  $erfasst =~ s/\./,/g;
  $dauer += $d->dauer_m($self->{zeit_bis},$self->{zeit_von});
  if ($dauer > (10*60)) {
    return 'FEHLER: Rückbildungsgymnastik in der Gruppe höchsten 10 Stunden\nschon erfasst '.$erfasst.' Stunden\nes wurde nichts gespeichert\n';
  }
  return '';
}



sub pos270_plausi {
  # Positionsnummer 270 darf die maximale Dauer von 10 Stunden nicht überschreiten
  my $self=shift;
  return '' if $self->{posnr} ne '270';

  my ($zeit_von,$zeit_bis) = ($self->{zeit_von},$self->{zeit_bis});
  my ($posnr,$frau_id)=($self->{posnr},$self->{frau_id});

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

  # Positionsnummer 270 nur nach der Geburt
  if ($self->{geb_kind} > $self->{datum_l}) {
    return 'FEHLER: Rückbildungsgymnastik in der Gruppe erst nach der Geburt des Kindes\nes wurde nichts gespeichert\n';
  }
  return '';
}


sub pos2700_plausi {
  # Positionsnummer 2700 darf die maximale Dauer von 10 Stunden nicht überschreiten
  my $self=shift;
  return '' if $self->{posnr} ne '2700';

  my ($zeit_von,$zeit_bis) = ($self->{zeit_von},$self->{zeit_bis});
  my ($posnr,$frau_id)=($self->{posnr},$self->{frau_id});

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

  # Positionsnummer 2700 nur nach der Geburt
  if ($self->{geb_kind} > $self->{datum_l}) {
    return 'FEHLER: Rückbildungsgymnastik in der Gruppe erst nach der Geburt des Kindes\nes wurde nichts gespeichert\n';
  }
  return '';
}




sub pos280_290_plausi {
  # prüft, ob Posnr 280,290 frühestens nach 8 Wochen
  # maximal 4 mal
  # abgerechnet werden --> OK

  my $self=shift;

  return '' if ($self->{posnr} ne '280' && 
		$self->{posnr} ne '281' && 
		$self->{posnr} ne '290');
  return '' if($self->{geb_kind} eq '');

  # frühestens
  my $days = Delta_Days(unpack('A4A2A2',$self->{geb_kind}),unpack('A4A2A2',$self->{datum_l}));
  if ($days < 57) {
    return '\nFEHLER: Position '.$self->{posnr}.' frühestens 8 Wochen nach der Geburt\nes wurde nicht gespeichert';
  }

  # spätestens
#  my $neun_spaeter=sprintf "%4.4u%2.2u%2.2u",Add_Delta_YM(unpack('A4A2A2',$self->{geb_kind}),0,9);
#  if ($self->{datum_l} > $neun_spaeter && 
#      $self->{begruendung} !~ /Anordnung/) {
#    return '\nFEHLER: Position '.$self->{posnr}.' nur bis zum Ende 9. Monat nach Geburt,\nEs wurde nichts gespeichert';
#  }

  # maximal 4 Mal
  my $pruef_pos=$self->{posnr};
  $pruef_pos .= ',281' if ($pruef_pos eq '280');
  $pruef_pos .= ',280' if ($pruef_pos eq '281');

   if ($l->leistungsdaten_werte($self->{frau_id},"POSNR","POSNR in ($pruef_pos)")>=4 &&
      $self->{begruendung} !~ /Anordnung/) {
    return '\nFEHLER: Position '.$pruef_pos.' maximal 4 mal berechnungsfähig\nEs wurde nichts gespeichert';
  }
  
  return '';
}



sub pos2800_2900_plausi {
  # prüft, ob Posnr 2800,2900 frühestens nach 8 Wochen
  # maximal 4 mal
  # abgerechnet werden --> OK

  my $self=shift;

  return '' if ($self->{posnr} ne '2800' && 
		$self->{posnr} ne '2810' && 
		$self->{posnr} ne '2900');
  return '' if($self->{geb_kind} eq '');

  # frühestens
  my $days = Delta_Days(unpack('A4A2A2',$self->{geb_kind}),unpack('A4A2A2',$self->{datum_l}));
  if ($days < 57) {
    return '\nFEHLER: Position '.$self->{posnr}.' frühestens 8 Wochen nach der Geburt\nes wurde nicht gespeichert';
  }

  # spätestens
#  my $neun_spaeter=sprintf "%4.4u%2.2u%2.2u",Add_Delta_YM(unpack('A4A2A2',$self->{geb_kind}),0,9);
#  if ($self->{datum_l} > $neun_spaeter && 
#      $self->{begruendung} !~ /Anordnung/) {
#    return '\nFEHLER: Position '.$self->{posnr}.' nur bis zum Ende 9. Monat nach Geburt,\nEs wurde nichts gespeichert';
#  }

  # maximal 8 Mal
  if ($l->leistungsdaten_werte($self->{frau_id},"POSNR","POSNR in (2800,2810,2900)")>=8 &&
      $self->{begruendung} !~ /Anordnung/) {
    return '\nFEHLER: Position 2800,2810,2900 maximal 8 mal berechnungsfähig\nEs wurde nichts gespeichert';
  }
  
  return '';
}





sub nicht_plausi {
  # prüft ob Positionsnummer nicht mit anderen Positionsnummern 
  # erfasst werden darf
  # liefert Ergebnis '' wenn kein Fehler aufgetreten ist oder
  # Fehlermeldung wenn Fehler aufgetreten ist
  my $self=shift;
  return '' unless ($self->{nicht});

  my ($posnr,$frau_id,$datum_l)=
    ($self->{posnr},$self->{frau_id},$self->{datum_l});

  my @nicht = split ',',$self->{nicht};
  my $nicht = '';
  foreach my $n (@nicht) {
    $nicht .= ',' if ($nicht);
    $nicht .= "'$n'";
  }
  if ($l->leistungsdaten_werte($frau_id,"POSNR",
                               "POSNR in ($nicht) and DATUM='$self->{datum_l}'")) {
    return 'FEHLER: Positionsnummer '.$self->{posnr}.' ist neben Leistungen nach '.$self->{nicht}.'\nan demselben Tag nicht berechnungsfähig\nes wurde nichts gespeichert';
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
  # C (Wochenbett) und D (sonstige Leistungen) nur nach Geburt des Kindes
  # Prüfung wird nur durchgeführt, wenn Geburtsdatum des Kindes bekannt ist
  my $self = shift;

  return '' unless ($self->{geb_kind});

  if ($self->{ltyp} eq 'A' && $self->{geb_kind} < $self->{datum_l}) {
    return 'FEHLER: Leistungen der Schwangerenbetreuung können nur vor Geburt des\nKindes erbracht werden.\nEs wurde nichts gespeichert';
  }
  if ($self->{ltyp} eq 'C' && $self->{geb_kind} > $self->{datum_l}) {
    return 'FEHLER: Leistungen im Wochenbett können erst nach Geburt des Kindes\nerbracht werden. Es wurde nichts gespeichert.';
  }
  if ($self->{ltyp} eq 'D' && 
      ($self->{posnr} eq '2820' || 
       $self->{posnr} eq '2800' || 
       $self->{posnr} eq '2810' ||
       $self->{posnr} eq '2900'
      ) &&
      $self->{geb_kind} >= $self->{datum_l}) {
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
  return '' if ($self->{posnr} ne '25' && 
		$self->{posnr} ne '26' && 
		$self->{posnr} ne '29' &&
                $self->{posnr} ne '32' && 
		$self->{posnr} ne '33');

  my ($posnr,$datum_l,$begruendung)=    
    ($self->{posnr},$self->{datum_l},$self->{begruendung});


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

sub Cd_plausi_neu {
  # prüft, ob Posnr 180 bis 211 innerhalb der ersten zehn Tage nach der Geburt
  # abgerechnet werden --> OK
  # mehr als 2 mal mit ärztlicher Anordnung --> OK
  # oder ob Posnr 180 bis 211 nach zehn Tagen 
  # innerhalb von 8 Wochen = 56 Tage mit Begründung --> OK
  # oder nach 8 Wochen mit Begründung 'auf ärztliche Anordnung' --> OK
  my $self=shift;
  return '' if ($self->{posnr} ne '180' && 
		$self->{posnr} ne '181' && 
		$self->{posnr} ne '200' && 
		$self->{posnr} ne '201' &&
		$self->{posnr} ne '210' && 
		$self->{posnr} ne '211' && 
		$self->{posnr} ne '230');

  my ($posnr,$datum_l,$begruendung)=    
    ($self->{posnr},$self->{datum_l},$self->{begruendung});

  my $geb_kind=$self->{geb_kind};
  return '' if($geb_kind eq '');

  my $anzahl=$l->leistungsdaten_werte($self->{frau_id},"POSNR",
				      "POSNR in (180,181,200,201,210,211,230) and DATUM='$datum_l'");

  my $days = Delta_Days(unpack('A4A2A2',$geb_kind),unpack('A4A2A2',$datum_l));
#  warn "days $days, anzahl: $anzahl\n";
  if ($days < 11 && $anzahl < 1) {
    return '';
  } elsif ($anzahl > 1 && $begruendung !~ /Anordnung/) {
    return '\nFEHLER: Position '.$posnr.' mehr als 2 mal pro Tag nur auf ärztliche Anordnung.\nEs wurde nichts gespeichert';
  } elsif (!$begruendung && $anzahl > 0) {
    return '\nFEHLER: Position '.$posnr.' mehr als einmal pro Tag innerhalb 8 Wochen nur mit Begründung.\nEs wurde nichts gespeichert';
  } elsif ($days > 56 && ($begruendung !~ /Anordnung/)) {
    return '\nFEHLER: Position '.$posnr.' nach 8 Wochen nur auf ärztliche Anordnung\nEs wurde nichts gespeichert';
  }
  return '';
}



sub Cd_plausi_GO2010 {
  # prüft, ob Posnr 1800 bis 2110 innerhalb der ersten zehn Tage 
  # nach der Geburt abgerechnet werden --> OK
  # mehr als 2 mal mit ärztlicher Anordnung --> OK
  # oder ob Posnr 1800 bis 2110 nach zehn Tagen 
  # innerhalb von 8 Wochen = 56 Tage mit Begründung --> OK
  # oder nach 8 Wochen mit Begründung 'auf ärztliche Anordnung' --> OK
  my $self=shift;
  return '' if ($self->{posnr} ne '1800' && 
		$self->{posnr} ne '1810' && 
		$self->{posnr} ne '2001' && 
		$self->{posnr} ne '2002' &&
		$self->{posnr} ne '2011' &&
		$self->{posnr} ne '2012' &&
		$self->{posnr} ne '2100' && 
		$self->{posnr} ne '2110' && 
		$self->{posnr} ne '2300' && 
		$self->{posnr} ne '2301' && 
		$self->{posnr} ne '2302');

  my ($posnr,$datum_l,$begruendung)=    
    ($self->{posnr},$self->{datum_l},$self->{begruendung});

  my $geb_kind=$self->{geb_kind};
  return '' if($geb_kind eq '');

  my $anzahl=$l->leistungsdaten_werte($self->{frau_id},"POSNR",
				      "POSNR in (1800,1810,2001,2002,2011,2012,2100,2110,2300,2301,2302) and DATUM='$datum_l'");

  my $days = Delta_Days(unpack('A4A2A2',$geb_kind),unpack('A4A2A2',$datum_l));
#  warn "datum: $datum_l, days $days, anzahl: $anzahl\n";
  if ($days < 11) { # keine Bergründung in den ersten 10 Tagen
    # Kontingent ist zu beachten
    # im Krankenhaus bei mehr als 2 nur mit Begründung. (2001 und 2002)
    if (($posnr eq '2001' || 
	 $posnr eq '2002' ||
	 $posnr eq '2011' ||
	 $posnr eq '2012'
	) && 
	$anzahl > 1 && $begruendung !~ /Anordnung/) {
      return '\nFEHLER: Position '.$posnr.' mehr als 2 mal pro Tag nur auf ärztliche Anordnung.\nEs wurde nichts gespeichert';
    }
    return '';
  } elsif ($anzahl > 1 && $begruendung !~ /Anordnung/) {
    return '\nFEHLER: Position '.$posnr.' mehr als 2 mal pro Tag nur auf ärztliche Anordnung.\nEs wurde nichts gespeichert';
  } elsif (!$begruendung && $anzahl > 0) {
    return '\nFEHLER: Position '.$posnr.' mehr als einmal pro Tag innerhalb 8 Wochen nur mit Begründung.\nEs wurde nichts gespeichert';
  } elsif ($days > 56 && ($begruendung !~ /Anordnung/)) {
    return '\nFEHLER: Position '.$posnr.' nach 8 Wochen nur auf ärztliche Anordnung\nEs wurde nichts gespeichert';
  }
  return '';
}




sub Cc_plausi {
  # Leistungen nach 22,23,25 bis 33 und 35 sind nur mehr als 16 mal
  # abrechenbar, wenn ärztlich angeordnet
  # Nach neuer GO Posnr 180 bis 230
  # Nach GO 2010 Posnr 1800 bis 2302
  my $self=shift;
  my ($posnr,$datum_l,$begruendung)=   
    ($self->{posnr},$self->{datum_l},$self->{begruendung});

  return '' if ($posnr ne '22' && $posnr ne '23' && $posnr ne '25' &&
                $posnr ne '26' && $posnr ne '27' && $posnr ne '28' &&
                $posnr ne '29' && $posnr ne '30' && $posnr ne '31' &&
                $posnr ne '32' && $posnr ne '33' && $posnr ne '35' &&
		# GO2007
		$posnr ne '180' && $posnr ne '181' && 
		$posnr ne '200' && $posnr ne '201' &&
		$posnr ne '210' && $posnr ne '211' &&
		$posnr ne '230' && 
		# GO2010
		$self->{posnr} ne '1800' && 
		$self->{posnr} ne '1810' && 
		$self->{posnr} ne '2001' && 
		$self->{posnr} ne '2002' &&
		$self->{posnr} ne '2011' &&
		$self->{posnr} ne '2012' &&
		$self->{posnr} ne '2100' && 
		$self->{posnr} ne '2110' && 
		$self->{posnr} ne '2300' && 
		$self->{posnr} ne '2301' && 
		$self->{posnr} ne '2302'
	       );


  my $geb_kind=$self->{geb_kind};
  return '' if ($geb_kind eq '');
  my $days = Delta_Days(unpack('A4A2A2',$geb_kind),unpack('A4A2A2',$datum_l));
  my $zehn_spaeter=join('-',Add_Delta_Days(unpack('A4A2A2',$geb_kind),10));
#  my $anzahl = $l->leistungsdaten_werte($self->{frau_id},"POSNR","POSNR in (22,23,25,26,28,29,30,31,32,33,35,180,181,200,201,210,211,230,1800,1810,2001,2002,2011,2012,2100,2110,2300,2301,2302) AND DATUM>'$zehn_spaeter'");
#  warn "Cc_plausi $datum_l days $days, anzahl: $anzahl\n";
  if ($days > 10 && 
      ($begruendung !~ /Anordnung/) &&
      ($l->leistungsdaten_werte($self->{frau_id},"POSNR","POSNR in (22,23,25,26,28,29,30,31,32,33,35,180,181,200,201,210,211,230,1800,1810,2001,2002,2011,2012,2100,2110,2300,2301,2302) AND DATUM>'$zehn_spaeter'") > 15) ) {
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

  if (uc $self->{begruendungspflicht} eq 'J' && !$begruendung) {
    return 'FEHLER: Bei Position '.$posnr.' ist eine Begründung notwendig\n es wurde nichts gespeichert';
  }
  return '';
}


sub zeit_plausi {
  # prüft ob es überschneidende Rechnungsposten gibt
  my $self=shift;
  
  return undef if(!$self->{zeit_von} && !$self->{zeit_bis});

  if($self->{zeit_von} &&
     $l->leistungsdaten_werte($self->{frau_id},"ID",
			      "DATUM='$self->{datum_l}' ".
			      "and ZEIT_VON <= '$self->{zeit_von}' ".
			      "and '$self->{zeit_von}' <= ZEIT_BIS ".
			      "and POSNR='$self->{posnr}'")>0) {
    return 'FEHLER: zu dieser Zeit ist schon eine Rechnungsposition erfasst\n es wurde nichts gespeichert';
  }

  if($self->{zeit_bis} &&
     $l->leistungsdaten_werte($self->{frau_id},"ID",
			      "DATUM='$self->{datum_l}' ".
			      "and ZEIT_VON <= '$self->{zeit_bis}' ".
			      "and '$self->{zeit_bis}' <= ZEIT_BIS ".
			      "and POSNR='$self->{posnr}';")>0) {
    return 'FEHLER: zu dieser Zeit ist schon eine Rechnungsposition erfasst\n es wurde nichts gespeichert';
  }
  return undef;
}


sub pzn_plausi {
  # prüft, ob bei einer erfassten Materialie die PZN gepflegt ist
  my $self=shift;
  
  return undef if(uc $self->{ltyp} ne 'M');
  
  if ( ($self->{posnr} =~ /[A-Z]\d{1,4}/i) &&
       !$self->{pzn}) {
    return 'FEHLER: Keine Pharmazentralnummer in den Leistungsarten hinterlegt\nBitte nachpflegen\nes wurde nichts gespeichert';
  }
  return undef;
}


sub material_plausi {
  # prüft, ob bei einer erfassten Materialie die übergeordnete
  # Positionsnummer gültig ist
  my $self=shift;
  
  return undef if(uc $self->{ltyp} ne 'M');
  return undef if ($self->{zusatzgebuehren1} eq '');

  my ($kbez) = $l->leistungsart_such_posnr('KBEZ',
					   $self->{zusatzgebuehren1},
					   $self->{datum_l});
  unless ($kbez) {
    return 'FEHLER: Positionsnummer '.$self->{posnr}.' besitzt keine gültige übergeordente Materialgruppe. Bitte in den Leistungsarten korrigieren (Feld Zusatzgeb.1),\nes wurde nichts gespeichert.';
  }
  return undef;
}


sub zeit {
  # liefert die Zeit zu der alternative Positionsnummern ausgewählt werden
  # müssen
  my $self=shift;

  return $self->{zeit_bis} if($l->zeit_ende($self->{posnr}));
  return $self->{zeit_von};
}


sub zeit_vorhanden_plausi {
  my $self=shift;

  # prüfen ob Uhrzeit erfasst wurde, wenn ja, muss es gültige Zeit sein
  
#  if ($self->{zeit_von} || $self->{zeit_bis}) {
    if ($self->{zeit_von} && !($d->check_zeit($self->{zeit_von}))) {
      return '\nFEHLER: keine gültige Uhrzeit von erfasst, nichts gespeichert';
    }
    if ($self->{zeit_bis} && !($d->check_zeit($self->{zeit_bis}))) {
      return '\nFEHLER: keine gültige Uhrzeit bis erfasst, nichts gespeichert';
    }
#  }
  # Ab hier sind gültige Uhrzeiten vorhanden


  my $fuerzeit=0;
  (undef,$fuerzeit)=$d->fuerzeit_check($self->{fuerzeit});

  if($fuerzeit) {
    # beide Zeiten fehlen
    if ( (!$self->{zeit_von} || !$d->check_zeit($self->{zeit_von})) &&
	 (!$self->{zeit_bis} || !$d->check_zeit($self->{zeit_bis})) ) {
      return 'FEHLER: Bitte Zeit von, Zeit bis erfassen, es wurde nichts gespeichert\n';
    }
    # Zeit von fehlt
    if (!$self->{zeit_von} || !$d->check_zeit($self->{zeit_von})) {
      return 'FEHLER: keine gültige Uhrzeit von erfasst, es wurde nichts gespeichert\n';
    }
    # Zeit bis fehlt
    if (!$self->{zeit_bis} || !$d->check_zeit($self->{zeit_bis})) {
      return 'FEHLER: keine gültige Uhrzeit bis erfasst, es wurde nichts gespeichert\n';
    }
    # Zeiten sind identisch
    unless ($d->dauer_m($self->{zeit_bis},$self->{zeit_von})) {
      return 'FEHLER: Bitte Zeit von, Zeit bis erfassen, es wurde nichts gespeichert\n';
    }
  }

#  if ($l->zeit_ende($self->{posnr}) && !$self->{zeit_bis}) {
#    return 'FEHLER: Fehlende Uhrzeit bis, es wurde nichts gespeichert\n';
#  } elsif (!$self->{zeit_von}) {
#    return 'FEHLER: Fehlende Uhrzeit von, es wurde nichts gespeichert\n';
#  }
  
  return;
}



sub zukunft_plausi {
  # prüft, ob das Leistungsdatum mehr als eine Woche in der Zukunft liegt
  # wenn ja wird Fehler ausgegeben
  my $self=shift;

  my $days = Delta_Days(unpack('A4A2A2',$self->{datum_l}),unpack('A4A2A2',$self->{TODAY}));
  if ($days < -7) {
    return "FEHLER: es können keine Leistungen erfasst werden, die mehr als 7 Tage in der Zukunft liegen";
  }
  return undef;
}

1;
