#!/usr/bin/perl -wT

# 19.02.2004
# Package um Krankenkassen aus Datenbank zu verarbeiten

# author: Thomas Baum

package Heb_krankenkassen;

use strict;
use DBI;

use Heb;

my $debug = 0;
our $dbh; # Verbindung zur Datenbank

our $krank_such; # Suchen von Krankenkassen

sub new {
  my($class) = @_;
  my $self = {};
  $dbh = Heb->connect;
  $krank_such = $dbh->prepare("select IK,KNAME,NAME,STRASSE,PLZ_HAUS,".
			      "PLZ_POST,ORT,POSTFACH,ASP_NAME,ASP_TEL, ".
			      "ZIK, BEMERKUNG, PUBKEY, ZIK_TYP, BELEG_IK ".
			      "from Krankenkassen where ".
			      "NAME LIKE ? and ".
			      "PLZ_HAUS LIKE ? and ".
			      "ORT LIKE ? and ".
			      "IK LIKE ?;");
  bless $self, ref $class || $class;
  return $self;
}

sub krankenkasse_sel {
  # Holt Informationen zu einer gegebenen IK aus der Datenbank

  shift; # package Namen vom stack nehmen

  my($werte,$ik) = @_;

  return undef if($ik eq '');
  # lesen aus Datenbank vorbereiten
  my $krankenkasse_get = $dbh->prepare("select $werte from Krankenkassen ".
				       "where $ik = IK;")
    or die $dbh->errstr();
  $krankenkasse_get->execute() or die $dbh->errstr();
  my @erg = $krankenkasse_get->fetchrow_array();

  print "ergebnis @erg<br>\n" if $debug;
  return @erg;
}

sub krankenkasse_ik {
  # Holt Informationen zu einer gegebenen IK aus der Datenbank

  shift; # package Namen vom stack nehmen

  my ($werte,$ik) = @_;

  my $krankenkasse_get = $dbh->prepare("select $werte from Krankenkassen ".
				       "where $ik = IK;")
    or die $dbh->errstr();
  $krankenkasse_get->execute() or die $dbh->errstr();
  my @erg = $krankenkasse_get->fetchrow_array();

  print "ergebnis @erg<br>\n" if $debug;
  return @erg;
}


sub krankenkasse_such {
  # Sucht nach Krankenkassen in der Datenbank

  shift; # package Namen vom stack nehmen
		     
  my ($name,$plz,$ort,$ik) = @_;
  
  $krank_such->execute($name,$plz,$ort,$ik) or die $dbh->errstr(); 
}

sub krankenkasse_such_next {
  return $krank_such->fetchrow_array();
}


sub krankenkassen_ins {
  # f�gt neue Krankenkasse in Datenbank ein

  shift;
  
  # insert an DB vorbereiten
  my $krankenkassen_ins = $dbh->prepare("insert into Krankenkassen ".
					"(IK,KNAME,NAME,STRASSE,PLZ_HAUS,".
					"PLZ_POST,ORT,POSTFACH, ".
					"ASP_NAME,ASP_TEL,ZIK,BEMERKUNG,ZIK_TYP,BELEG_IK) ".
					"values (?,?,?,?,?,?,".
					"?,?,".
					"?,?,?,?,?,?);")
    or die $dbh->errstr();
  my $erg = $krankenkassen_ins->execute(@_)
    or die $dbh->errstr();
  return 1;
}

sub krankenkassen_update {
  # speichert ge�nderte Daten ab
  shift;
  my @ein=@_;
  # updaten an DB vorbereiten
  my $krankenkassen_up = $dbh->prepare("update Krankenkassen set ".
				       "KNAME=?,NAME=?,STRASSE=?,".
				       "PLZ_HAUS=?,PLZ_POST=?,ORT=?,".
				       "POSTFACH=?,".
				       "ASP_NAME=?,ASP_TEL=?,ZIK=?, ".
				       "BEMERKUNG=?,ZIK_TYP=?,".
				       "BELEG_IK=? ".
				       "where IK=?;")
    or die $dbh->errstr();
  my $erg = $krankenkassen_up->execute(@_)
    or die $dbh->errstr();
  return $erg;
}


sub krankenkassen_up_pubkey {
  # �ndert public key in Tabelle Krankenkassen
  shift;
  my ($key,$ik)=@_;
  my $krankenkassen_up_pubkey = $dbh->prepare("update Krankenkassen set ".
					     "PUBKEY=? where IK=?;")
    or die $dbh->errstr();
  my $erg=$krankenkassen_up_pubkey->execute($key,$ik)
    or die $dbh->errstr();
  return $erg;
}
					     

sub krankenkassen_delete {
  # l�scht Krankenkasse aus der Datenbank
  shift;
  # delete an DB vorbereiten
  my $krankenkasse_del = $dbh->prepare("delete from Krankenkassen ".
				       "where IK=?;")
    or die $dbh->errstr();
  my $erg = $krankenkasse_del->execute(@_)
    or die $dbh->errstr();
  return $erg;
}


sub krankenkasse_next_ik {
  # holt die zur angegebenen ik n�chste ik
  shift;
  my ($ik) = @_;
  my $krankenkasse_next_ik = 
    $dbh->prepare("select IK from Krankenkassen where ".
		  "ik > ? limit 1;")
      or die $dbh->errstr();
  $krankenkasse_next_ik->execute($ik) or die $dbh->errstr();
  return $krankenkasse_next_ik->fetchrow_array();
}

sub krankenkasse_prev_ik {
  # holt die zur angegebenen ik vorhergehende ik
  shift;
  my ($ik) = @_;
  my $krankenkasse_prev_ik = 
    $dbh->prepare("select IK from Krankenkassen where ".
		  "ik < ? order by ik desc limit 1;")
      or die $dbh->errstr();
  $krankenkasse_prev_ik->execute($ik) or die $dbh->errstr();
  return $krankenkasse_prev_ik->fetchrow_array();
}


sub krankenkassen_krank_ik {
  # holgt alle Daten zu einer Krankenkasse
  shift;
  
  my $krank_ik = $dbh->prepare("select IK,KNAME,NAME,STRASSE,PLZ_HAUS,".
			       "PLZ_POST,ORT,POSTFACH,ASP_NAME,ASP_TEL,".
			       "ZIK,BEMERKUNG,PUBKEY,ZIK_TYP,BELEG_IK ".
			       "from Krankenkassen where IK = ?;")
    or die $dbh->errstr();
  $krank_ik->execute(@_) or die $dbh->errstr();
  my @erg = $krank_ik->fetchrow_array();
  for (my $i=0;$i < $#erg;$i++) {
    if (!defined($erg[$i])) {
      $erg[$i]='';
    }
  }
  return @erg;
}


sub krankenkasse_ktr_da {
  # liefert zu einer Krankenkasse die Kostentr�ger IK
  # und die dazugeh�rige IK der Datenannahmestelle
  # wenn ik nicht auf einen Kostentr�ger verweist, ist die Kasse
  # der Kostentr�ger dann wird die IK als Ergebniss geliefert
  shift;

  my ($ik)=@_;
  my ($zik,$zik_typ)=Heb_krankenkassen->krankenkasse_sel("ZIK,ZIK_TYP",$ik);
  my $ktr=0;
  my $da=0;
  my $da_typ=0;
  if ($zik_typ==0) {
    $ktr=$ik;
    $da=0;
  } elsif($zik_typ==1) {
    $ktr=$zik;
    ($da,$da_typ)=Heb_krankenkassen->krankenkasse_sel("ZIK,ZIK_TYP",$ktr);
    $da=0 if(!defined($da_typ) || $da_typ != 3);
  } elsif($zik_typ==3) {
    $ktr=$ik;
    $da=$zik;
  }
  return ($ktr,$da);
}

sub krankenkasse_beleg_ik {
  # liefert zu einer Krankenkasse die IK Nummer, an die Belege
  # geschickt werden m�ssen
  # Ergebniss sind zwei Werte: IK Nummer und Typ
  # IK Nummer an die Belege gehen
  # Typ = 1, Belege gehen an die �bergebene IK
  # Typ = 2, IK verweist unmittelbar auf Belegannahmestelle
  # Typ = 3, IK verweist �ber zentralen Kostentr�ger an Belegannahmestelle
  shift;

  my ($ik)=@_;
  my $beleg_ik=0;
  my $typ=1;

  # Typ = 2, IK verweist unmittelbar auf Belegannahmestelle
  ($beleg_ik)=Heb_krankenkassen->krankenkasse_sel("BELEG_IK",$ik);
  return ($beleg_ik,2) if(defined($beleg_ik) && $beleg_ik > 0);

  my ($ktr,$da)=Heb_krankenkassen->krankenkasse_ktr_da($ik);
  if (defined($ktr) && $ktr > 0) {
    ($beleg_ik)=Heb_krankenkassen->krankenkasse_sel("BELEG_IK",$ktr);
    # Typ = 3, IK verweist �ber zentralen Kostentr�ger an Belegannahmestelle
    return ($beleg_ik,3) if(defined($beleg_ik) && $beleg_ik > 0);
  } else {
    return ($ik,1);
  }
}


1;
