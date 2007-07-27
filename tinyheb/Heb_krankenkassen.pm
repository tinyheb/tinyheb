# Package um Krankenkassen zu verarbeiten

# $Id: Heb_krankenkassen.pm,v 1.16 2007-07-27 18:55:15 baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2004,2005,2006 Thomas Baum <thomas.baum@arcor.de>
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


package Heb_krankenkassen;

use strict;
use DBI;

use Heb;

my $h = new Heb;

my $debug = 0;
our $dbh; # Verbindung zur Datenbank

our $krank_such; # Suchen von Krankenkassen

sub new {
  my($class) = @_;
  my $self = {};
  $dbh = Heb->connect;
  $krank_such = $dbh->prepare("select IK,KNAME,NAME,STRASSE,PLZ_HAUS,".
			      "PLZ_POST,ORT,POSTFACH,ASP_NAME,ASP_TEL, ".
			      "ZIK, BEMERKUNG, PUBKEY, ZIK_TYP, BELEG_IK,EMAIL ".
			      "from Krankenkassen where ".
			      "NAME LIKE ? and ".
			      "KNAME LIKE ? and ".
			      "PLZ_HAUS LIKE ? and ".
			      "PLZ_POST LIKE ? and ".
			      "ORT LIKE ? and ".
			      "IK LIKE ?;");
  bless $self, ref $class || $class;
  return $self;
}

sub krankenkasse_sel {
  # Holt Informationen zu einer gegebenen IK aus der Datenbank

  shift; # package Namen vom stack nehmen

  my($werte,$ik) = @_;

  return undef if(!defined($ik) or $ik eq '');

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
		     
  my ($name,$kname,$plz_haus,$plz_post,$ort,$ik) = @_;
  
  $krank_such->execute($name,$kname,$plz_haus,$plz_post,$ort,$ik) or die $dbh->errstr(); 
}

sub krankenkasse_such_next {
  return $krank_such->fetchrow_array();
}



sub da_such {
  # sucht nach Datenannahmestellen unter den Krankenkassen
  my $self=shift;
  my %erg;
  my @erg;

  my $da_such =$dbh->prepare("select distinct zik from Krankenkassen ".
			     "where zik_typ in (2,3) order by zik;")
    or die $dbh->errstr();
  $da_such->execute or die $dbh->errstr();
  while (my ($da)=$da_such->fetchrow_array()) {
    $erg{$da}=$da if($da >0);
  }

  $da_such =$dbh->prepare("select distinct ik from Krankenkassen ".
			     "where zik_typ=2 order by ik;")
    or die $dbh->errstr();
  $da_such->execute or die $dbh->errstr();
  while (my ($da)=$da_such->fetchrow_array()) {
    $erg{$da}=$da if($da >0);
  }

  foreach my $key (sort keys %erg) {
    push @erg,$key;
  }
  return @erg;
}  



sub krankenkassen_ins {
  # fügt neue Krankenkasse in Datenbank ein

  shift;
  
  # insert an DB vorbereiten
  my $krankenkassen_ins = $dbh->prepare("insert into Krankenkassen ".
					"(IK,KNAME,NAME,STRASSE,PLZ_HAUS,".
					"PLZ_POST,ORT,POSTFACH, ".
					"ASP_NAME,ASP_TEL,ZIK,BEMERKUNG,ZIK_TYP,BELEG_IK,EMAIL) ".
					"values (?,?,?,?,?,?,".
					"?,?,".
					"?,?,?,?,?,?,?);")
    or die $dbh->errstr();
  my $erg = $krankenkassen_ins->execute(@_)
    or die $dbh->errstr();
  return 1;
}

sub krankenkassen_update {
  # speichert geänderte Daten ab
  shift;
  my @ein=@_;
  # updaten an DB vorbereiten
  my $krankenkassen_up = $dbh->prepare("update Krankenkassen set ".
				       "KNAME=?,NAME=?,STRASSE=?,".
				       "PLZ_HAUS=?,PLZ_POST=?,ORT=?,".
				       "POSTFACH=?,".
				       "ASP_NAME=?,ASP_TEL=?,ZIK=?, ".
				       "BEMERKUNG=?,ZIK_TYP=?,".
				       "BELEG_IK=?,".
				       "EMAIL=? ".
				       "where IK=?;")
    or die $dbh->errstr();
  my $erg = $krankenkassen_up->execute(@_)
    or die $dbh->errstr();
  return $erg;
}


sub krankenkassen_up_pubkey {
  # ändert public key in Tabelle Krankenkassen
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
  # löscht Krankenkasse aus der Datenbank
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
  # holt die zur angegebenen ik nächste ik
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
			       "ZIK,BEMERKUNG,PUBKEY,ZIK_TYP,BELEG_IK, ".
			       "EMAIL ".
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
  # liefert zu einer Krankenkasse die Kostenträger IK
  # und die dazugehörige IK der Datenannahmestelle
  # wenn ik nicht auf einen Kostenträger verweist, ist die Kasse
  # der Kostenträger dann wird die IK als Ergebniss geliefert
  shift;

  my ($ik)=@_;
  my ($zik,$zik_typ)=Heb_krankenkassen->krankenkasse_sel("ZIK,ZIK_TYP",$ik);
  my $ktr=0;
  my $da=0;
  my $da_typ=0;
  if (!defined($zik_typ) || $zik_typ==0) {
    $ktr=$ik;
    $da=0;
  } elsif($zik_typ==1) {
    $ktr=$zik;
    ($da,$da_typ)=Heb_krankenkassen->krankenkasse_sel("ZIK,ZIK_TYP",$ktr);
    $da=0 if(!defined($da_typ) || $da_typ < 2);
    $da=$ktr if ($da_typ==2);
  } elsif($zik_typ==3) {
    $ktr=$ik;
    $da=$zik;
  } elsif ($zik_typ==2) {
    $ktr=$ik;
    $da=$ik;
  }
  return ($ktr,$da);
}


sub krankenkasse_empf_phys {
  # liefert zu einer ik einer Datenannahmestelle
  # den physikalischen Empfänger
  shift;
  my ($ik)=@_;
  my ($zik,$zik_typ)=Heb_krankenkassen->krankenkasse_sel("ZIK,ZIK_TYP",$ik);
  return undef if(!defined($zik_typ));
  return $ik if ($zik_typ == 0 || $zik_typ==1);
  return $zik if ($zik_typ == 2 || $zik_typ==3);
}

sub krankenkasse_test_ind {
  # liefert zu einer Krankenkasse den Testindikator
  # für Datenlieferung per E-Mail
  shift;

  my ($ik)=@_;
  my ($ktr,$da)=Heb_krankenkassen->krankenkasse_ktr_da($ik);
  my $test_ind = $h->parm_unique('IK'.$da);
  if (defined($h->parm_unique('KTR'.$ktr))) {
    $test_ind=$h->parm_unique('KTR'.$ktr);
  }
  # prüfen, ob PUBKEY vorhanden ist
  my ($pubkey) = Heb_krankenkassen->krankenkasse_sel("PUBKEY",$da);
  return undef if(!(defined($pubkey)) or $pubkey eq '');
  return $test_ind;
}


sub krankenkasse_beleg_ik {
  # liefert zu einer Krankenkasse die IK Nummer, an die Belege
  # geschickt werden müssen
  # Ergebniss sind zwei Werte: IK Nummer und Typ
  # IK Nummer an die Belege gehen
  # Typ = 1, Belege gehen an die übergebene IK
  # Typ = 2, IK verweist unmittelbar auf Belegannahmestelle
  # Typ = 3, IK verweist über zentralen Kostenträger an Belegannahmestelle
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
    # Typ = 3, IK verweist über zentralen Kostenträger an Belegannahmestelle
    if(defined($beleg_ik) && $beleg_ik > 0) {
      return ($beleg_ik,3);
    } else {
      return ($ik,1);
    }
  } else {
    return ($ik,1);
  }
}


1;
