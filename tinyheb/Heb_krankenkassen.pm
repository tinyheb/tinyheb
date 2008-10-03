# Package um Krankenkassen zu verarbeiten

# $Id: Heb_krankenkassen.pm,v 1.18 2008-10-03 13:09:26 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2004,2005,2006,2007,2008 Thomas Baum <thomas.baum@arcor.de>
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

=head1 NAME

Heb_krankenkassen - Package für tinyHeb um Krankenkassen zu verarbeiten

my $k = new Heb_krankenkassen;

=head1 DESCRIPTION

=cut

use strict;
use DBI;

use Heb;

my $h = new Heb;

my $debug = 0;
my $dbh=$h->connect; # Verbindung zur Datenbank

my $krank_such; # Suchen von Krankenkassen
$krank_such = $dbh->prepare("select IK,KNAME,NAME,STRASSE,PLZ_HAUS,".
			    "PLZ_POST,ORT,POSTFACH,ASP_NAME,ASP_TEL, ".
			    "ZIK, BEMERKUNG, PUBKEY, ZIK_TYP, BELEG_IK,EMAIL ".
			    "from Krankenkassen where ".
			    "NAME LIKE ? and ".
			    "KNAME LIKE ? and ".
			    "PLZ_HAUS LIKE ? and ".
			    "PLZ_POST LIKE ? and ".
			    "ORT LIKE ? and ".
			    "IK LIKE ? order by IK;");

sub new {
  my($class) = @_;
  my $self = {};
  bless $self, ref $class || $class;
  return $self;
}

sub krankenkasse_sel {
  # Holt Informationen zu einer gegebenen IK aus der Datenbank

  my $self=shift; # package Namen vom stack nehmen

  my($werte,$ik) = @_;

  return if(!$ik);

  # lesen aus Datenbank vorbereiten
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

  my $self=shift; # package Namen vom stack nehmen
		     
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
    $erg{$da}=$da if($da);
  }

  $da_such =$dbh->prepare("select distinct ik from Krankenkassen ".
			     "where zik_typ=2 order by ik;")
    or die $dbh->errstr();
  $da_such->execute or die $dbh->errstr();
  while (my ($da)=$da_such->fetchrow_array()) {
    $erg{$da}=$da if($da);
  }

  push @erg,$_ foreach (sort keys %erg);

  return @erg;
}  



sub krankenkassen_ins {
  # fügt neue Krankenkasse in Datenbank ein

  my $self=shift;
  
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
  my $self=shift;
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
  my $self=shift;
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
  my $self=shift;
  # delete an DB vorbereiten
  my $krankenkasse_del = $dbh->prepare("delete from Krankenkassen ".
				       "where IK=?;")
    or die $dbh->errstr();
  my $erg = $krankenkasse_del->execute(@_)
    or die $dbh->errstr();
  return $erg;
}


sub krankenkasse_next_ik {

=head2 $k->krankenkasse_next_ik($ik)

liefert die IK der nächsten Krankenkasse in der Datenbank bei angebener IK.

Existiert keine nächste Krankenkasse, wird die übergebende IK als Ergebnis
zurückgeliefert.

=cut

  my $self=shift;
  my ($ik) = @_;
  my $krankenkasse_next_ik = 
    $dbh->prepare("select IK from Krankenkassen where ".
		  "ik > ? limit 1;")
      or die $dbh->errstr();
  $krankenkasse_next_ik->execute($ik) or die $dbh->errstr();
  my($erg) = $krankenkasse_next_ik->fetchrow_array();
  return $erg if($erg);
  return $ik;
}

sub krankenkasse_prev_ik {

=head2 $k->krankenkasse_prev_ik($ik)

liefert die IK der vorhergehenden Krankenkasse in der Datenbank bei 
angebener IK.

Existiert keine vorhergehende Krankenkasse, wird die übergebende IK als 
Ergebnis zurückgeliefert.

=cut


  # holt die zur angegebenen ik vorhergehende ik
  my $self=shift;
  my ($ik) = @_;
  my $krankenkasse_prev_ik = 
    $dbh->prepare("select IK from Krankenkassen where ".
		  "ik < ? order by ik desc limit 1;")
      or die $dbh->errstr();
  $krankenkasse_prev_ik->execute($ik) or die $dbh->errstr();
  my($erg) = $krankenkasse_prev_ik->fetchrow_array();
  return $erg if($erg);
  return $ik;
}


sub krankenkassen_krank_ik {
  # holt alle Daten zu einer Krankenkasse
  my $self=shift;
  
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
  my $self=shift;

  my ($ik)=@_;
  my ($zik,$zik_typ)=$self->krankenkasse_sel("ZIK,ZIK_TYP",$ik);
  my $ktr=0;
  my $da=0;
  my $da_typ=0;
  if (!defined($zik_typ) || $zik_typ==0) {
    $ktr=$ik;
    $da=0;
  } elsif($zik_typ==1) {
    $ktr=$zik;
    ($da,$da_typ)=$self->krankenkasse_sel("ZIK,ZIK_TYP",$ktr);
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
  my $self=shift;
  my ($ik)=@_;
  my ($zik,$zik_typ)=$self->krankenkasse_sel("ZIK,ZIK_TYP",$ik);
  return undef if(!defined($zik_typ));
  return $ik if ($zik_typ == 0 || $zik_typ==1);
  return $zik if ($zik_typ == 2 || $zik_typ==3);
}

sub krankenkasse_test_ind {
  # liefert zu einer Krankenkasse den Testindikator
  # für Datenlieferung per E-Mail
  my $self=shift;

  my ($ik)=@_;
  my ($ktr,$da)=$self->krankenkasse_ktr_da($ik);
  my $test_ind = $h->parm_unique('IK'.$da);
  if (defined($h->parm_unique('KTR'.$ktr))) {
    $test_ind=$h->parm_unique('KTR'.$ktr);
  }
  # prüfen, ob PUBKEY vorhanden ist
  my ($pubkey) = $self->krankenkasse_sel("PUBKEY",$da);
  return undef unless($pubkey);
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
  my $self=shift;

  my ($ik)=@_;
  my $beleg_ik=0;
  my $typ=1;

  # Typ = 2, IK verweist unmittelbar auf Belegannahmestelle
  ($beleg_ik)=$self->krankenkasse_sel("BELEG_IK",$ik);
  return ($beleg_ik,2) if(defined($beleg_ik) && $beleg_ik > 0);

  my ($ktr,$da)=$self->krankenkasse_ktr_da($ik);
  if ($ktr) {
    ($beleg_ik)=$self->krankenkasse_sel("BELEG_IK",$ktr);
    # Typ = 3, IK verweist über zentralen Kostenträger an Belegannahmestelle
    if($beleg_ik) {
      return ($beleg_ik,3);
    } else {
      return ($ik,1);
    }
  } else {
    return ($ik,1);
  }
}


1;
