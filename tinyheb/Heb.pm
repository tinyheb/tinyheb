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
 

1;
