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
our $max_krank=0; # maximal vergebene id

sub new {
  my($class) = @_;
  my $self = {};
  $dbh = Heb->connect;
  $krank_such = $dbh->prepare("select ID,NAME,STRASSE,PLZ,ORT,IK,TEL ".
			      "from Krankenkassen where ".
			      "NAME LIKE ? and ".
			      "PLZ LIKE ? and ".
			      "ORT LIKE ? and ".
			      "IK LIKE ?;");
  bless $self, ref $class || $class;
  my $max_id = $dbh->prepare("select max(id) from Krankenkassen;") or die $dbh->errstr();
  $max_id->execute() or die $dbh->errstr();
  $max_krank = $max_id->fetchrow_array();

  return $self;
}

sub krankenkasse_sel {
  # Holt Informationen zu einer gegebenen IK aus der Datenbank

  shift; # package Namen vom stack nehmen

  my($werte,$ik) = @_;

  # lesen aus Datenbank vorbereiten
  my $krankenkasse_get = $dbh->prepare("select $werte from Krankenkassen ".
				       "where $ik = IK;")
    or die $dbh->errstr();
  $krankenkasse_get->execute() or die $dbh->errstr();
  my @erg = $krankenkasse_get->fetchrow_array();

  print "ergebnis @erg<br>\n" if $debug;
  return @erg;
}

sub krankenkasse_id {
  # Holt Informationen zu einer gegebenen ID aus der Datenbank

  shift; # package Namen vom stack nehmen

  my ($werte,$id) = @_;

  my $krankenkasse_get = $dbh->prepare("select $werte from Krankenkassen ".
				       "where $id = ID;")
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
					"(ID,NAME,STRASSE,PLZ,ORT,TEL,IK) ".
					"values (?,?,?,?,?,?,?);")
    or die $dbh->errstr();
  my $erg = $krankenkassen_ins->execute('NULL',@_)
    or die $dbh->errstr();
  $max_krank = $krankenkassen_ins->{'mysql_insertid'};
  return $max_krank;
}

sub krankenkassen_update {
  # speichert geänderte Daten ab
  shift;
  # updaten an DB vorbereiten
  my $krankenkassen_up = $dbh->prepare("update Krankenkassen set ".
				       "NAME=?,STRASSE=?,PLZ=?,ORT=?,TEL=?,IK=? ".
				       "where ID=?;")
    or die $dbh->errstr();
  my $erg = $krankenkassen_up->execute(@_)
    or die $dbh->errstr();
  return $erg;
}


sub krankenkassen_delete {
  # löscht Krankenkasse aus der Datenbank
  shift;
  # delete an DB vorbereiten
  my $krankenkasse_del = $dbh->prepare("delete from Krankenkassen ".
				       "where ID=?;")
    or die $dbh->errstr();
  my $erg = $krankenkasse_del->execute(@_)
    or die $dbh->errstr();
  return $erg;
}

sub krankenkassen_krank_id {
  # holgt alle Daten zu einer Krankenkasse
  shift;
  
  my $krank_id = $dbh->prepare("select NAME,PLZ,ORT,TEL,STRASSE,IK ".
			       "from Krankenkassen where ID = ?;")
    or die $dbh->errstr();
  $krank_id->execute(@_) or die $dbh->errstr();
  my @erg = $krank_id->fetchrow_array();
  for (my $i=0;$i < $#erg;$i++) {
    if (!defined($erg[$i])) {
      $erg[$i]='';
    }
  }
  return @erg;
}

sub max {
  # gibt die höchste ID zurück
  return $max_krank;
}			      
1;
