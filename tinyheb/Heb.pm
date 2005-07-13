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
my $parm_such_werte = '';

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


sub parm_ins {
  # fügt neuen Parameter in Parms Tabelle ein
  shift;
  
  # zunächst neue ID für Parameter holen
  my $id=Heb->parm_unique('PARM_ID');
  $id++;

  my $parm_ins = $dbh->prepare("insert into Parms ".
			       "(ID,NAME,VALUE,BESCHREIBUNG) ".
			       "values (?,?,?,?);")
    or die $dbh->errstr();
  my $erg = $parm_ins->execute($id,@_)
    or die $dbh->errstr();
  Heb->parm_up('PARM_ID',$id);
  return $id;
}


sub parm_delete {
  # löscht Datensatz aus Parms Tabelle
  shift;
  my $parm_delete = $dbh->prepare("delete from Parms ".
				  "where ID=?;")
    or die $dbh->errstr();

  my $erg = $parm_delete->execute(@_)
    or die $dbh->errstr();
  return $erg;
}


sub parm_update {
  # speichert geänderte Parameter ab
 shift;
 my $id = shift;
 my $parm_update = $dbh->prepare("update Parms set ".
				 "NAME=?,VALUE=?,BESCHREIBUNG=? ".
				 "where ID=?;")
   or die $dbh->errstr();
 my $erg=$parm_update->execute(@_,$id) or die $dbh->errstr();
 return $erg;
}


sub parm_next_id {
  # holt den nächsten Parameter nach dem gegebenen
  shift;
  my ($id) = @_;

  my $parm_next_id = $dbh->prepare("select ID from Parms where ".
				   "ID > ? order by ID limit 1;")
    or die $dbh->errstr();
  $parm_next_id->execute($id) or die $dbh->errstr();
  return $parm_next_id->fetchrow_array();
}


sub parm_prev_id {
  # holt den vorhergehenden Parameter zu dem gegebenen
  shift;
  my ($id) = @_;

  my $parm_prev_id = $dbh->prepare("select ID from Parms where ".
				   "ID < ? order by ID desc limit 1;")
    or die $dbh->errstr();
  $parm_prev_id->execute($id) or die $dbh->errstr();
  return $parm_prev_id->fetchrow_array();
}


sub parm_get_id {
  # holt alle werte zur gegebenen ID
  shift;
  my ($id) = @_;
  my $parm_get_id = $dbh->prepare("select * from Parms where ".
				  "ID = ?;")
    or die $dbh->errstr();
  $parm_get_id->execute($id) or die $dbh->errstr();
  my @erg = $parm_get_id->fetchrow_array();
  return @erg;
}


sub parm_such_werte {
  # sucht nach kriterien Parameter
  shift;
  
  $parm_such_werte = $dbh->prepare("select * from Parms ".
				   "where name like ? and ".
				   "value like ? and ".
				   "beschreibung like ?;")
    or die $dbh->errstr();
  $parm_such_werte->execute(@_) or die $dbh->errstr();
}

sub parm_such_werte_next {
  return $parm_such_werte->fetchrow_array();
}

1;
