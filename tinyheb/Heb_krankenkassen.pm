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
  $krank_such = $dbh->prepare("select ID,NAME,STRASSE,PLZ,ORT,IK ".
			      "from Krankenkassen where ".
			      "NAME LIKE ? and ".
			      "PLZ LIKE ? and ".
			      "ORT LIKE ? and ".
			      "IK LIKE ?;");
  bless $self, ref $class || $class;
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
1;
