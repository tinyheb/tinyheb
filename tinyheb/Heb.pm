#!/usr/bin/perl -wT

# 21.12.2003
# globales Package für die Hebammen Verarbeitung

# author: Thomas Baum

package Heb;

use strict;
use DBI;

our $dbh; # Verbindung zur Datenbank
our $user='baum';
our $pass='';

my $debug = 1;
my $parm_such = '';

sub new {
  my($class) = @_;
  my $self = {};
  $dbh = Heb->connect;
  bless $self, ref $class || $class;
  return $self;
}

sub connect {
  # verbindung zur Datenbank aufbauen
  $dbh = DBI->connect("DBI:mysql:database=Hebamme;host=localhost",$user,$pass,
                      {RaiseError => 1,
                       AutoCommit => 1 });
  die $DBI::errstr unless $dbh;
  return $dbh;
}

sub parm_such {
  # parameter holen
  shift; # package Namen vom Stack holen
  $parm_such = $dbh->prepare("select VALUE from Parms ".
				"where NAME=?;")
    or die $dbh->errstr();
  $parm_such->execute(@_) or die $dbh->errstr();
}

sub parm_such_next {
  my ($erg) = $parm_such->fetchrow_array();
  return $erg;
}

sub parm_unique {
  # holt einzelnen Parameter aus Datenbank
  shift;
  Heb->parm_such(@_);
  return Heb->parm_such_next();
}

sub parm_up {
  # update auf bestimmten Parameter
  shift;
  my ($name,$value) = @_;
  my $parm_up = $dbh->prepare("update Parms set ".
			      "VALUE=? where ".
			      "NAME = ?;")
    or die $dbh->errstr();
  $parm_up->execute($value,$name)
    or die $dbh->errstr();
}


1;
