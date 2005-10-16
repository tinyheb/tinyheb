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
			      "ZIK, BEMERKUNG ".
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
  # fügt neue Krankenkasse in Datenbank ein

  shift;
  
  # insert an DB vorbereiten
  my $krankenkassen_ins = $dbh->prepare("insert into Krankenkassen ".
					"(IK,KNAME,NAME,STRASSE,PLZ_HAUS,".
					"PLZ_POST,ORT,POSTFACH, ".
					"ASP_NAME,ASP_TEL,ZIK,BEMERKUNG) ".
					"values (?,?,?,?,?,?,".
					"?,?,".
					"?,?,?,?);")
    or die $dbh->errstr();
  my $erg = $krankenkassen_ins->execute(@_)
    or die $dbh->errstr();
  return 1;
}

sub krankenkassen_update {
  # speichert geänderte Daten ab
  shift;
  # updaten an DB vorbereiten
  my $krankenkassen_up = $dbh->prepare("update Krankenkassen set ".
				       "KNAME=?,NAME=?,STRASSE=?,".
				       "PLZ_HAUS=?,PLZ_POST=?,ORT=?,".
				       "POSTFACH=?,".
				       "ASP_NAME=?,ASP_TEL=?,ZIK=?, ".
				       "BEMERKUNG=? ".
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
			       "ZIK,BEMERKUNG ".
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

1;
