#!/usr/bin/perl -wT

# 21.12.2003
# Package um Leistunsarten und Leistungsdaten aus Datenbank zu verarbeiten

# author: Thomas Baum

package Heb_leistung;

use strict;
use DBI;

use Heb;
use Heb_datum;

my $d = new Heb_datum;

my  @gruppen = ('A. Mutterschaftsvorsorge','B. Geburtshilfe','C. Wochenbett','D. Sonstige','Wegegeld');

our $leistung_such; # Suchen von Leistunsarten
our $leistungsdaten_ins; # Speichern von Leistungsdaten
our $leistungsdaten_such; # suchen von Leistungsdaten nach Frau
our $leistungsdaten_offen; # suchen nach (Status 10) Leistungsdaten bei Frau
our $rech_such; # sucht nach Rechnungen in der Datenbank

my $debug = 1;
our $dbh; # Verbindung zur Datenbank

sub new {
  my($class) = @_;
  my $self = {};
  $dbh = Heb->connect;
  bless $self, ref $class || $class;
  $leistung_such = $dbh->prepare("select * from Leistungsart ".
				 "where ? >= GUELT_VON and ".
				 "? <= GUELT_BIS and LEISTUNGSTYP = ?;")
    or die $dbh->errstr();
  $leistungsdaten_ins = $dbh->prepare("insert into Leistungsdaten " .
				      "(ID,POSNR,FK_STAMMDATEN, " .
				      "BEGRUENDUNG,DATUM,ZEIT_VON, ".
				      "ZEIT_BIS,ENTFERNUNG_T, ".
				      "ENTFERNUNG_N,ANZAHL_FRAUEN, ".
				      "PREIS, RECHNUNGSNR,STATUS)" .
				      "values (?,?,?,".
				      "?,?,?,".
				      "?,?,".
				      "?,?,".
				      "?,?,?);")
    or die $dbh->errstr();
  $leistungsdaten_such
    = $dbh->prepare("select ID,POSNR,FK_STAMMDATEN,BEGRUENDUNG," .
		    "DATE_FORMAT(DATUM,'%d.%m.%Y'),".
		    "TIME_FORMAT(ZEIT_VON,'%H:%i'),".
		    "TIME_FORMAT(ZEIT_BIS,'%H:%i'),ENTFERNUNG_T,ENTFERNUNG_N,".
		    "ANZAHL_FRAUEN,PREIS,STATUS,cast(POSNR as unsigned) as sort ".
		    "from Leistungsdaten ".
		    "where FK_STAMMDATEN=? ".
		    "order by DATUM,sort, ZEIT_VON;")
      or die $dbh->errstr();
  return $self;
}



sub leistungsdaten_ins {
  # fügt Leistungsdaten in Datenbank ein
  shift;
#  print "Leistungsdaten einfügen";
  
  # zunächst neue ID für Leistungsdaten holen
  Heb->parm_such('LEISTUNG_ID');
  my $id = Heb->parm_such_next;
  $id++;
  my $erg = $leistungsdaten_ins->execute($id,@_)
    or die $dbh->errstr();
  Heb->parm_up('LEISTUNG_ID',$id);
  return $id;
}

sub rechnung_ins {
  # fügt neue Rechnung in Datenbank ein
  shift;
  my ($rechnr,$rech_datum,$gsumme,$fk_st,$ik,$text) = @_;
  my $rechnung_ins = $dbh->prepare("insert into Rechnung " .
				   "(RECHNUNGSNR,RECH_DATUM,MAHN_DATUM,".
				   "ZAHL_DATUM,BETRAG,STATUS,BETRAGGEZ,".
				   "FK_STAMMDATEN,IK,RECH) ".
				   "values (?,?,?,?,?,?,?,?,?,?);")
    or die $dbh->errstr();
  $rechnung_ins->execute($rechnr,$rech_datum,'','',$gsumme,20,0,$fk_st,$ik,$text) or die $dbh->errstr();
  Heb->parm_up('RECHNR',$_[0]);
}

sub rechnung_such {
  # sucht nach Rechnungen in der Datenbank
  shift;
  my $werte = shift;
  my $sel = shift;
  if (!defined($sel)) {
    $sel ='';
  } else {
    $sel = "where $sel";
  }
  $rech_such = $dbh->prepare("select $werte from Rechnung ".
			     "$sel;") 
    or die $dbh->errstr();
  return $rech_such->execute() or die $dbh->errstr();
}

sub rechnung_such_next {
  return $rech_such->fetchrow_array() or die $dbh->errstr();
} 
  


sub leistungsdaten_up {
  # ändert Leistungsdaten in der Datenbank;
  shift;
  my $leist_id=shift;
  Heb_leistung->leistungsdaten_delete($_[1],$leist_id);
  my $erg = $leistungsdaten_ins->execute($leist_id,@_)
    or die $dbh->errstr();
}


sub leistungsdaten_up_werte {
  # ändert vorgegebene Werte in Leistungsdatenbank
  shift;
  my $leist_id=shift;
  my $werte=shift;
  my $leist_up = $dbh->prepare("update Leistungsdaten ".
			       "set $werte where id=?;")
    or die $dbh->errstr();
  $leist_up->execute($leist_id) or die $dbh->errstr();
}


sub leistungsdaten_delete {
  # löscht Datensatz zu einer Frau und ID aus der Leistungsdatenbank,
  shift;
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
  shift;
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
  shift;
  my ($id) = @_;
  my  $leistungsdaten_such_id
    = $dbh->prepare("select ID,POSNR,FK_STAMMDATEN,BEGRUENDUNG," .
		    "DATE_FORMAT(DATUM,'%d.%m.%Y'),".
		    "TIME_FORMAT(ZEIT_VON,'%H:%i'),".
		    "TIME_FORMAT(ZEIT_BIS,'%H:%i'),ENTFERNUNG_T,ENTFERNUNG_N,".
		    "ANZAHL_FRAUEN,PREIS,STATUS ".
		    "from Leistungsdaten ".
		    "where ID=?; ")
      or die $dbh->errstr();
  $leistungsdaten_such_id->execute($id)
    or die $dbh->errstr();
  my @erg= $leistungsdaten_such_id->fetchrow_array();
  return @erg;
}



sub leistungsart_pruef_zus {
  # prüft ob Positionsnummer zuschlagspflichtig ist
  shift;
  my $posnr=shift;
  my $wert=shift;
  my $pruef_zus = $dbh->prepare("select distinct $wert from Leistungsart ".
				"where $posnr=$wert;")
    or die $dbh->errstr();
  my $erg = $pruef_zus->execute() or die $dbh->errstr();
  return $erg if ($erg>0);
  return 0;
}

sub leistungsart_such {
  # Sucht gültige Leistungsarten in der Datenbank
  
  shift;
  my ($datum,$ltyp) = @_;
  $leistung_such->execute($datum,$datum,$ltyp) or die $dbh->errstr();
}

sub leistungsart_such_next {
  my @erg = $leistung_such->fetchrow_array();
  return @erg;
}


sub leistungsart_such_posnr {
  # sucht Werte zu einer bestimmten Positionsnummer
  shift;
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


sub leistungsdaten_offen {
  # sucht nach Positionen die noch in Bearbeitung sind
  # für einen vorgebenen Leistungstyp und Frau
  shift;
  my ($frau_id,$where,$order) = @_;

  $order = 'sort,DATUM' if (!defined($order) || $order eq '');

  if (defined($where) && $where ne '') {
    $where =~ s/,/ and /g;
    $where = ' and '.$where;
  } else {
    $where = '';
  }

  $leistungsdaten_offen =
    $dbh->prepare("select Leistungsdaten.*, Leistungsart.LEISTUNGSTYP, ".
		  "cast(Leistungsdaten.POSNR as unsigned) as sort from ".
		  "Leistungsdaten, Leistungsart where ".
		  "FK_Stammdaten=? and ".
		  "Leistungsdaten.POSNR=Leistungsart.POSNR and ".
		  "DATUM >= guelt_von and DATUM <= guelt_bis and ".
		  "STATUS = 10 $where order by $order;")
      or die $dbh->errstr();
  my $hugo=$leistungsdaten_offen->execute($frau_id)
    or die $dbh->errstr();
  return $hugo;
}

sub leistungsdaten_offen_next {
  my @erg=$leistungsdaten_offen->fetchrow_array();
  return @erg;
}

1;
