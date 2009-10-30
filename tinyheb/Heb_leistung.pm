# Package um Leistunsarten und Leistungsdaten aus Datenbank zu verarbeiten

# $Id: Heb_leistung.pm,v 1.30 2009-10-30 16:48:47 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2003,2004,2005,2006,2007,2008 Thomas Baum <thomas.baum@arcor.de>
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

package Heb_leistung;

use strict;
use DBI;
use Date::Calc qw(Today);

use Heb;
use Heb_datum;

my $d = new Heb_datum;
my $h = new Heb;

my  @gruppen = ('A. Mutterschaftsvorsorge','B. Geburtshilfe','C. Wochenbett','D. Sonstige','Wegegeld');

my %zeit_ende=(); # Posnr bei denen die Zeit nach Ende der Leistung berechnet wird

$zeit_ende{$_}=1 for qw(050 051 090 091 100 101 110 111 120 121 130 131 160 161 163 164 165 166 167 260 261 280 281 310);

my $dbh=$h->connect;

my %leistungsdaten_pruef_zus=(); # für Zuschlagspflichtige Posnr
foreach my $wert qw(SAMSTAG SONNTAG NACHT) {
  my $zus = $dbh->prepare("select distinct $wert,guelt_von,guelt_bis ".
		       "from Leistungsart ".
		       "where $wert > 0;")
    or die $dbh->errstr();
  $zus->execute() or die $dbh->errstr();
  while (my @erg=$zus->fetchrow_array()) {
    push( @{$leistungsdaten_pruef_zus{$wert}{$erg[0]}},
	  "$erg[1]:$erg[2]");
  }
}


my $leistungsdaten_ins; # Speichern von Leistungsdaten
$leistungsdaten_ins = $dbh->prepare("insert into Leistungsdaten " .
				    "(ID,POSNR,FK_STAMMDATEN, " .
				    "BEGRUENDUNG,DATUM,ZEIT_VON, ".
				    "ZEIT_BIS,ENTFERNUNG_T, ".
				    "ENTFERNUNG_N,ANZAHL_FRAUEN, ".
				    "PREIS, RECHNUNGSNR,STATUS, ".
				    "DIA_SCHL, DIA_TEXT)" .
				    "values (?,?,?,".
				    "?,?,?,".
				    "?,?,".
				    "?,?,".
				    "?,?,?,".
				    "?,?);")
  or die $dbh->errstr();
my $leistungsdaten_such; # suchen von Leistungsdaten nach Frau
$leistungsdaten_such
  = $dbh->prepare("select ID,POSNR,FK_STAMMDATEN,BEGRUENDUNG," .
		  "DATE_FORMAT(DATUM,'%d.%m.%Y'),".
		  "TIME_FORMAT(ZEIT_VON,'%H:%i'),".
		  "TIME_FORMAT(ZEIT_BIS,'%H:%i'),ENTFERNUNG_T,ENTFERNUNG_N,".
		  "ANZAHL_FRAUEN,PREIS,STATUS,DIA_SCHL,DIA_TEXT,cast(POSNR as unsigned) as sort ".
		  "from Leistungsdaten ".
		  "where FK_STAMMDATEN=? ".
		  "order by DATUM,sort, ZEIT_VON;")
  or die $dbh->errstr();
my $leistung_such; # Suchen von Leistunsarten
$leistung_such = $dbh->prepare("select *,cast(POSNR as unsigned) as sort ".
			       "from Leistungsart ".
			       "where ? >= GUELT_VON and ".
			       "? <= GUELT_BIS and LEISTUNGSTYP = ? ".
			       "order by sort;")
  or die $dbh->errstr();

my $leistungsdaten_offen; # suchen nach (Status 10) Leistungsdaten bei Frau
my $leistungsdaten_such_rechnr; # Sucht Leistungsdaten einer bestimmten Rechnung
my $leistungsdaten_werte; # sucht werte für Frau
my $pruef_zus; # zuschlagspflichtige Posnr
my $leistungsart_such_werte; # suchen nach mehreren Leistungsarten
my $zus; # welche werte verweisen auf Zuschlagspflichtige Posnr

my $debug = 1;

sub new {
  my($class) = @_;
  my $self = {};
  bless $self, ref $class || $class;
  return $self;
}



sub leistungsdaten_ins {
  # fügt Leistungsdaten in Datenbank ein
  my $self=shift;
#  print "Leistungsdaten einfügen";
  
  # zunächst neue ID für Leistungsdaten holen
  my $gl=$h->get_lock("LEISTUNG_ID");
  my $id = 1+$h->parm_unique('LEISTUNG_ID');
  $h->parm_up('LEISTUNG_ID',$id); # sofort update w/ race-condition
  my $rl=$h->release_lock('LEISTUNG_ID');
  my $erg = $leistungsdaten_ins->execute($id,@_)
    or die $dbh->errstr();

  return $id;
}

sub rechnung_ins {
  # fügt neue Rechnung in Datenbank ein
  my $self=shift;
  my ($rechnr,$rech_datum,$gsumme,$fk_st,$ik,$text) = @_;
  my $rechnung_ins = $dbh->prepare("insert into Rechnung " .
				   "(RECHNUNGSNR,RECH_DATUM,MAHN_DATUM,".
				   "ZAHL_DATUM,BETRAG,STATUS,BETRAGGEZ,".
				   "FK_STAMMDATEN,IK,RECH) ".
				   "values (?,?,?,?,?,?,?,?,?,?);")
    or die $dbh->errstr();
  $rechnung_ins->execute($rechnr,$rech_datum,'0000-00-00','0000-00-00',$gsumme,20,0,$fk_st,$ik,$text) or die $dbh->errstr();
  $h->parm_up('RECHNR',$_[0]); 
}


sub rechnung_up {
  # update auf einzelne Rechnung
  my $self=shift;
  my ($rechnr,$zahl_datum,$betraggez,$status) = @_;
  $zahl_datum = $d->convert($zahl_datum);
  my $rechnung_up = $dbh->prepare("update Rechnung ".
				  "set ZAHL_DATUM=?,BETRAGGEZ=?,STATUS=? ".
				  "where RECHNUNGSNR = ?;")
    or die $dbh->errstr();
  $rechnung_up->execute($zahl_datum,$betraggez,$status,$rechnr)
    or die $dbh->errstr();
}



sub rechnung_such {
  # sucht nach Rechnungen in der Datenbank
  my $self=shift;
  my $werte = shift;
  my $sel = shift;
  unless ($sel) {
    $sel ='';
  } else {
    $sel = "where $sel";
  }

  $self->{rech_such} = $dbh->prepare("select $werte from Rechnung ".
			     "$sel order by RECHNUNGSNR;") 
    or die $dbh->errstr();
  return $self->{rech_such}->execute() or die $dbh->errstr();
}

sub rechnung_such_next {
  my $self=shift;
  return $self->{rech_such}->fetchrow_array() or die $dbh->errstr();
} 


sub rechnung_up_werte {
  # ändert vorgegebene Werte in der Rechnungsdatenbank
  my $self=shift;
  my $rech_id=shift;
  my $werte=shift;
  my $rech_up = $dbh->prepare("update Rechnung ".
			      "set $werte where RECHNUNGSNR = ?;")
    or die $dbh->errstr();
  $rech_up->execute($rech_id) or die $dbh->errstr();
}



sub leistungsdaten_such_rechnr {
  # sucht Leistungsdaten zu gegebener Rechnungsnr
  my $self=shift;
  my $werte=shift;
  my $rechnr=shift;

  $self->{leistungsdaten_such_rechnr}
    = $dbh->prepare("select $werte from Leistungsdaten ".
		    "where RECHNUNGSNR = $rechnr;")
      or die $dbh->errstr();
  return $self->{leistungsdaten_such_rechnr}->execute() or die $dbh->errstr();
}


sub leistungsdaten_such_rechnr_next {
  my $self=shift;
  return $self->{leistungsdaten_such_rechnr}->fetchrow_array() or die $dbh->errstr();
}

sub leistungsdaten_up {
  # ändert Leistungsdaten in der Datenbank;
  my $self=shift;
  my $leist_id=shift;
  $self->leistungsdaten_delete($_[1],$leist_id);
  my $erg = $leistungsdaten_ins->execute($leist_id,@_)
    or die $dbh->errstr();
}


sub leistungsdaten_up_werte {
  # ändert vorgegebene Werte in Leistungsdatenbank
  my $self=shift;
  my $leist_id=shift;
  my $werte=shift;
  my $leist_up = $dbh->prepare("update Leistungsdaten ".
			       "set $werte where id=?;")
    or die $dbh->errstr();
  $leist_up->execute($leist_id) or die $dbh->errstr();
}


sub leistungsdaten_delete {
  # löscht Datensatz zu einer Frau und ID aus der Leistungsdatenbank,
  my $self=shift;
  my ($frau_id,$id)=@_;
  my $leistungsdaten_delete = 
    $dbh->prepare("delete from Leistungsdaten ".
		  "where FK_STAMMDATEN=? and ID=?;")
      or die $dbh->errstr();
  $leistungsdaten_delete->execute($frau_id,$id)
    or die $dbh->errstr(); 
}


sub leistungsdaten_such {
  # sucht nach allen Rechnungspositionen, die zu einer Frau existieren
  my $self=shift;
  my ($frau_id) = @_;
  my $erg=$leistungsdaten_such->execute($frau_id)
    or die $dbh->errstr();
  return $erg if ($erg > 0);
  return 0;
}

sub leistungsdaten_such_next {
  my @erg = $leistungsdaten_such->fetchrow_array();
  return @erg;
}


sub leistungsdaten_such_id {
  my $self=shift;
  my ($id) = @_;
  my  $leistungsdaten_such_id
    = $dbh->prepare("select ID,POSNR,FK_STAMMDATEN,BEGRUENDUNG," .
		    "DATE_FORMAT(DATUM,'%d.%m.%Y'),".
		    "TIME_FORMAT(ZEIT_VON,'%H:%i'),".
		    "TIME_FORMAT(ZEIT_BIS,'%H:%i'),ENTFERNUNG_T,ENTFERNUNG_N,".
		    "ANZAHL_FRAUEN,PREIS,STATUS,DIA_SCHL,DIA_TEXT ".
		    "from Leistungsdaten ".
		    "where ID=?; ")
      or die $dbh->errstr();
  $leistungsdaten_such_id->execute($id)
    or die $dbh->errstr();
  my @erg= $leistungsdaten_such_id->fetchrow_array();
  return @erg;
}


sub leistungsart_zus {
  # holt alle Positionsnummer, die auf bestimmten Wert verweisen
  my $self=shift;
  my $posnr=shift;
  my $wert=shift;
  my $datum=shift;
  $zus = $dbh->prepare("select distinct POSNR from Leistungsart ".
		       "where ($wert='$posnr' or $wert='+$posnr') and ?>= GUELT_VON and ? <= GUELT_BIS;")
    or die $dbh->errstr();
  my $erg = $zus->execute($datum,$datum) or die $dbh->errstr();
  return $erg if ($erg>0);
  return 0;
}

sub leistungsart_zus_next {
  return $zus->fetchrow_array();
}


sub leistungsart_pruef_zus {
  # prüft ob Positionsnummer zuschlagspflichtig ist
  my $self=shift;
  my $posnr=shift;
  my $wert=shift;
  my $datum=shift;
  return 0 unless (exists $leistungsdaten_pruef_zus{$wert}{$posnr});
  return 1 if (!$datum); # falls keine Prüfung auf Datum

  foreach my $von_bis 
    (@{$leistungsdaten_pruef_zus{$wert}{$posnr}}) {
      my ($von,$bis)=split':',$von_bis;
      $von =~ s/-//g;
      $bis =~ s/-//g;
      return 1 if ($von <= $datum && $bis >= $datum);
    }
  return 0;
}

#sub leistungsart_pruef_zus_next {
  # holt die Positionsnummern bei denen zuschläge erforderlich sind
#  return $pruef_zus->fetchrow_array();
#}


sub leistungsart_such {
  # Sucht gültige Leistungsarten in der Datenbank
  
  my $self=shift;
  my ($datum,$ltyp) = @_;
  $leistung_such->execute($datum,$datum,$ltyp) or die $dbh->errstr();
}

sub leistungsart_such_next {
  return $leistung_such->fetchrow_array();
#  return @erg;
}


sub leistungsart_such_posnr {
  # sucht Werte zu einer bestimmten Positionsnummer
  my $self=shift;
  my ($werte,$posnr,$datum) = @_;
  my $leistungsart_such_posnr 
    = $dbh->prepare("select $werte from Leistungsart ".
		    "where ?>= GUELT_VON and ? <= GUELT_BIS and POSNR=?;")
      or die $dbh->errstr();
  $leistungsart_such_posnr->execute($datum,$datum,$posnr)
    or die $dbh->errstr();
  my @erg=$leistungsart_such_posnr->fetchrow_array();
  return @erg;
}



sub leistungsart_next_id {
  # holt zur gegebenen ID die nächste Leistungsart
  my $self = shift;
  my ($id)=@_;
  my @erg = $self->leistungsart_id($id);
  if (!(defined($erg[1]))) {
    my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();
    $erg[1]=1;
    ($id)=$self->leistungsart_such_posnr('ID',$erg[1],$TODAY);
  }
  my $leistungsart_next_id;
  if ($erg[1] =~ /^\d{1,3}$/) {
    $leistungsart_next_id =
      $dbh->prepare("select ID,cast(POSNR as unsigned) as sort ".
		    "from Leistungsart where ".
		    "cast(POSNR as unsigned) >= ? ".
		    "order by sort, POSNR, GUELT_VON;")
	or die $dbh->errstr();
  } else {
    $leistungsart_next_id =
      $dbh->prepare("select ID,cast(POSNR as unsigned) as sort ".
		    "from Leistungsart where ".
		    "POSNR >= ? ".
		    "order by POSNR, sort, GUELT_VON;")
	or die $dbh->errstr();
  }
  $leistungsart_next_id->execute($erg[1]) or die $dbh->errstr();
  my @erg2 = $leistungsart_next_id->fetchrow_array();

  @erg2 = $leistungsart_next_id->fetchrow_array() while ($erg2[0] != $id);  
  @erg2 = $leistungsart_next_id->fetchrow_array();
  return $erg2[0];
}



sub leistungsart_prev_id {
  # holt zur gegebenen ID die vorhergehende Leistungsart
  my $self = shift;
  my ($id)=@_;
  my @erg = $self->leistungsart_id($id);
  if (!(defined($erg[1]))) {
    my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();
    $erg[1]=1;
    ($id)=$self->leistungsart_such_posnr('ID',$erg[1],$TODAY);
  }

  my $leistungsart_prev_id;
  if ($erg[1] =~ /^\d{1,3}$/) {
    $leistungsart_prev_id =
      $dbh->prepare("select ID,cast(POSNR as unsigned) as sort ".
		    "from Leistungsart where ".
		    "cast(POSNR as unsigned) <= ? ".
		    "order by sort DESC, POSNR DESC, GUELT_VON DESC;")
	or die $dbh->errstr();
  } else {
    $leistungsart_prev_id =
      $dbh->prepare("select ID,cast(POSNR as unsigned) as sort ".
		    "from Leistungsart where ".
		    "POSNR <= ? ".
		    "order by POSNR DESC, sort DESC, GUELT_VON DESC;")
	or die $dbh->errstr();
  }
  $leistungsart_prev_id->execute($erg[1]) or die $dbh->errstr();
  my @erg2 = $leistungsart_prev_id->fetchrow_array();
  @erg2 = $leistungsart_prev_id->fetchrow_array() while ($erg2[0] != $id);
  @erg2 = $leistungsart_prev_id->fetchrow_array();
  return $erg2[0];

}


sub leistungsart_id {
  # holt zur gegebenen ID die Daten
  my $self=shift;
  my ($id) = @_;
  my $leistungsart_id =
    $dbh->prepare("select * from Leistungsart where ID = ?;")
      or die $dbh->errstr();
  $leistungsart_id->execute($id) or die $dbh->errstr();
  return $leistungsart_id->fetchrow_array();
}
  


sub leistungsdaten_werte {
  # sucht nach Positionen für eine Frau
  # liefert werte
  # für bestimmtes Kriterium: where
  my $self=shift;
  my ($frau_id,$werte,$where,$order) = @_;
  if ($where) {
    $where = ' and '.$where;
  } else {
    $where = '';
  }
  if ($order) {
    $order = ' order by '.$order;
  } else {
    $order = '';
  }
  $leistungsdaten_werte = $dbh->prepare("select $werte from Leistungsdaten ".
					"where FK_Stammdaten=? $where $order;")
      or die $dbh->errstr();
  my $erg=$leistungsdaten_werte->execute($frau_id) or die $dbh->errstr();
  return $erg if($erg > 0);
  return 0;
}


sub leistungsdaten_werte_next {
  my @erg=$leistungsdaten_werte->fetchrow_array();
  return @erg;
}



sub leistungsdaten_offen {
  # sucht nach Positionen die noch in Bearbeitung sind
  # für einen vorgebenen Leistungstyp und Frau
  my $self=shift;
  my ($frau_id,$where,$order) = @_;

  $order = 'sort,DATUM' unless ($order);

  if ($where) {
    $where =~ s/,/ and /g;
    $where = ' and '.$where;
  } else {
    $where = '';
  }

  $leistungsdaten_offen =
    $dbh->prepare("select Leistungsdaten.*, Leistungsart.LEISTUNGSTYP, ".
		  "cast(Leistungsdaten.POSNR as unsigned) as sort from ".
		  "Leistungsdaten, Leistungsart where ".
		  "FK_Stammdaten=? and STATUS=10 and ".
		  "Leistungsdaten.POSNR=Leistungsart.POSNR and ".
		  "DATUM >= guelt_von and DATUM <= guelt_bis ".
		  "$where order by $order;")
      or die $dbh->errstr();
  my $erg=$leistungsdaten_offen->execute($frau_id)
    or die $dbh->errstr();
  return $erg if ($erg > 0);
  return 0;
}

sub leistungsdaten_offen_next {
  my @erg=$leistungsdaten_offen->fetchrow_array();
  return @erg;
}


sub leistungsart_such_werte {
  # sucht nach leistungsarten
  my $self=shift;
  my ($posnr,$ltyp,$kbez,$guelt) = @_;
 
  my $where='';
  $where = "POSNR = '$posnr' and " if ($posnr);
  $where = $where."GUELT_VON <= '$guelt' and GUELT_BIS >= '$guelt' and" if ($guelt);
  $leistungsart_such_werte =
    $dbh->prepare("select ID,POSNR,LEISTUNGSTYP,KBEZ,".
		  "DATE_FORMAT(GUELT_VON,'%d.%m.%Y'),".
		  "DATE_FORMAT(GUELT_BIS,'%d.%m.%Y'),".
		  "cast(POSNR as unsigned) as sort ".
		  "from Leistungsart where ".
		  "$where LEISTUNGSTYP LIKE ? and ".
		  "KBEZ LIKE ? order by sort, POSNR, GUELT_BIS;")
      or die $dbh->errstr();
  my $erg = $leistungsart_such_werte->execute($ltyp,$kbez)
    or die $dbh->errstr();
  return $erg;
}


sub leistungsart_such_werte_next {
  my @erg=$leistungsart_such_werte->fetchrow_array();
  return @erg;
}


sub leistungsart_ins {
  # fügt neue Leistungsart in Datenbank ein
  my $self = shift;
  
  my $id=1+$h->parm_unique('LEISTUNGSART_ID');
  my ($posnr,$bez,$ltyp,$epreis,$proz,
      $sonn,$nacht,$sam,$fuerz,$dau,$zwill,
      $zweites,$einm,$begrue,$zus1,
      $zus2,$zus3,$zus4,$g_v,$g_b,$kbez,
      $kilometer,$pzn,$nicht,$id_alt)=@_;
  $id = $id_alt if($id_alt);

  $dau=0 unless ($dau);
  $begrue='n' unless ($begrue);
  $proz=0 unless ($proz);
  my $leistungsart_ins=
    $dbh->prepare("insert into Leistungsart ".
		  "(ID,POSNR,BEZEICHNUNG,LEISTUNGSTYP,EINZELPREIS, ".
		  "PROZENT,SONNTAG,NACHT,SAMSTAG, ".
		  "FUERZEIT,DAUER,ZWILLINGE, ".
		  "ZWEITESMAL,EINMALIG,BEGRUENDUNGSPFLICHT,ZUSATZGEBUEHREN1,".
		  "ZUSATZGEBUEHREN2,ZUSATZGEBUEHREN3,ZUSATZGEBUEHREN4,".
		  "GUELT_VON,GUELT_BIS,KBEZ,KILOMETER,PZN,NICHT) ".		  
		  "values (?,?,?,?,?,".
		  "?,?,?,?,".
		  "?,?,?,".
		  "?,?,?,?,".
		  "?,?,?,".
		  "?,?,?,?,?,?);")
      or die $dbh->errstr();
  $leistungsart_ins->execute($id,"$posnr",$bez,$ltyp,$epreis,$proz,$sonn,$nacht,$sam,$fuerz,$dau,$zwill,$zweites,$einm,$begrue,$zus1,$zus2,$zus3,$zus4,$g_v,$g_b,$kbez,$kilometer,$pzn,$nicht) or die $dbh->errstr();
  $h->parm_up('LEISTUNGSART_ID',$id) if(!defined($id_alt));
  return $id;
}


sub leistungsart_delete {
  # löscht Leistungsart aus Tabelle
  my $self=shift;
  my $id=shift;
  my $leistungsart_delete = $dbh->prepare("delete from Leistungsart where ".
					 "ID = ?;")
    or die $dbh->errstr();
  $leistungsart_delete->execute($id) or die $dbh->errstr();
}


sub zeit_ende {
  # liefert true, wenn die Zeit nach Beendigung der Leistung berechnet wird
  # undef sonst
  my $self=shift;
  my $posnr=shift;
  
  return $zeit_ende{$posnr};
}
  

sub timetoblank {
  # setzt zeit von und zeit bis auf Blank, falls nötig

  my $self=shift;

  my ($posnr,$fuerzeit,$datum,$zeit_von,$zeit_bis) = @_;

  return ($zeit_von,$zeit_bis) if ($fuerzeit);

  if( $self->leistungsart_pruef_zus($posnr,'SAMSTAG') &&
      $self->leistungsart_pruef_zus($posnr,'NACHT')) {
    $zeit_von = '' if($zeit_von eq '00:00' && $self->zeit_ende($posnr));
    $zeit_bis = '' if($zeit_bis eq '00:00' && !$self->zeit_ende($posnr));
  } else {
    # keine zuschlagspflichtige Positionsnummer, Zeiten können weg
    $zeit_von = '' if($zeit_von eq '00:00');
    $zeit_bis = '' if($zeit_bis eq '00:00');
  }

  if ($self->leistungsart_pruef_zus($posnr,'SONNTAG') &&
      $d->wotagnummer($d->convert($datum)) > 6) {
    $zeit_von = '' if($zeit_von eq '00:00');
    $zeit_bis = '' if($zeit_bis eq '00:00');
  }
  return ($zeit_von,$zeit_bis);
}



sub status_text {
  # ermittelt zu gegebenem Status den Text
  shift;
  my $status=shift;
  return 'in bearb.' if($status==10);
  return 'Rechnung' if($status==20);
  return 'Edi Rech.' if($status==22);
  return 'Teilzahl.' if($status==24);
  return '1.&nbsp;Mahnung' if($status==26);
  return '2.&nbsp;Mahnung' if($status==27);
  return '3.&nbsp;Mahnung' if($status==28);
  return '4.&nbsp;Mahnung' if($status==29);
  return 'erl.' if($status==30);
  return 'Storniert' if($status==80);
  return "$status unbekannt";
}

1;
