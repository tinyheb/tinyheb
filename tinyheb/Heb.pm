# globales Package für die Hebammen Verarbeitung

# $Id: Heb.pm,v 1.18 2012-05-31 16:49:14 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2003 - 2010 Thomas Baum <thomas.baum@arcor.de>
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

package Heb;

use strict;
use DBI;

my $dbh; # Verbindung zur Datenbank
my %config=();

# Parameter einlesen
my $conf_file='';

foreach my $file (@INC) {
  my $such_file = $file;
  $such_file = ($such_file eq '.') ? '' : $such_file;
#  print "such $such_file\n";
  if (-r "$such_file"."tinyheb.conf") {
    $conf_file=$such_file."tinyheb.conf";
    last;
  }
}

#print "conf_file $conf_file\n";

if (-r $conf_file) {
  open CONFIG,$conf_file or die "konnte config $conf_file nicht lesen $!\n";
  process_config($_) while (<CONFIG>);
  close CONFIG;
} elsif (-r '/etc/tinyheb/tinyheb.conf') {
  open CONFIG,'/etc/tinyheb/tinyheb.conf' or die "konnte config nicht lesen\n";
  process_config($_) while (<CONFIG>);
  close CONFIG;
} else {
  process_config($_) while (<DATA>);
}


sub process_config {
  my ($wert) = @_;
  chomp $wert;
  $wert =~ s/#.*//;
  $wert =~ s/^\s+//;
  $wert =~ s/\s+$//;
  return unless ($wert);
  my ($var,$value) = split(/\s*=\s*/,$wert,2);
  $config{$var}=$value;
}


my $debug = 1;
my $parm_such = '';
my $parm_such_werte = '';

# verbindung zur Datenbank aufbauen
$dbh = DBI->connect("DBI:mysql:database=$config{MySQLDBName};".
		    "host=$config{MySQLServerName};".
		    "port=$config{MySQLServerPort}",
		    $config{MySQLServerUser},
		    $config{MySQLServerPassword},
		    {RaiseError => 1,
		     AutoCommit => 1 });
die $DBI::errstr unless $dbh;


sub new {
  my($class) = @_;
  my $self = {};
  $self->{dbh}=$dbh;
  bless $self, ref $class || $class;
  return $self;
}

sub connect {
  # verbindung zur Datenbank aufbauen
  return $dbh;
}

sub db_name {
  my $self=shift;
  my ($name,$host)=split ';',$dbh->{Name};
  my ($dummy,$dbname)=split '=',$name;
  return $dbname;
}


sub get_lock {
  # quasi semaphore, P operation
  # locked Parms Tabelle w/ konkurrierender Zugriffe
  my $self=shift;
  my ($lockname)=@_;
  my $get_lock=$dbh->prepare("select GET_LOCK('$lockname',10);")
    or die $dbh->errstr();
  $get_lock->execute() or die $dbh->errstr();
  my ($erg) = $get_lock->fetchrow_array();
#  warn "ergebnis $$ get lock $erg";
  return $erg;
}


sub release_lock {
  # quasi semaphore, V operation
  # unlock Parms Tabelle w/ konkurrierender Zugriffe
  my $self=shift;
  my ($lockname)=@_;
  my $release_lock=$dbh->prepare("select RELEASE_LOCK('$lockname');")
    or die $dbh->errstr();
  $release_lock->execute() or die $dbh->errstr();
  my ($erg) = $release_lock->fetchrow_array();
#  warn "ergebnis $$ release lock $erg";
  return $erg;
}

sub parm_such {
  # parameter holen
  my $self=shift; # package Namen vom Stack holen
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
  my $self=shift;
  $self->parm_such(@_);
  return $self->parm_such_next();
}

sub parm_up {
  # update auf bestimmten Parameter
  my $self=shift;
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
  my $self=shift;
  
  # zunächst neue ID für Parameter holen
  my $id=$self->parm_unique('PARM_ID');
  $id++;

  my $parm_ins = $dbh->prepare("insert into Parms ".
			       "(ID,NAME,VALUE,BESCHREIBUNG) ".
			       "values (?,?,?,?);")
    or die $dbh->errstr();
  my $erg = $parm_ins->execute($id,@_)
    or die $dbh->errstr();
  $self->parm_up('PARM_ID',$id);
  return $id;
}


sub parm_delete {
  # löscht Datensatz aus Parms Tabelle
  my $self=shift;
  my $parm_delete = $dbh->prepare("delete from Parms ".
				  "where ID=?;")
    or die $dbh->errstr();

  my $erg = $parm_delete->execute(@_)
    or die $dbh->errstr();
  return $erg;
}


sub parm_update {
  # speichert geänderte Parameter ab
 my $self=shift;
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
  my $self=shift;
  my ($id) = @_;

  my $parm_next_id = $dbh->prepare("select ID from Parms where ".
				   "ID > ? order by ID limit 1;")
    or die $dbh->errstr();
  $parm_next_id->execute($id) or die $dbh->errstr();
  return $parm_next_id->fetchrow_array();
}


sub parm_prev_id {
  # holt den vorhergehenden Parameter zu dem gegebenen
  my $self=shift;
  my ($id) = @_;

  my $parm_prev_id = $dbh->prepare("select ID from Parms where ".
				   "ID < ? order by ID desc limit 1;")
    or die $dbh->errstr();
  $parm_prev_id->execute($id) or die $dbh->errstr();
  return $parm_prev_id->fetchrow_array();
}


sub parm_get_id {
  # holt alle werte zur gegebenen ID
  my $self=shift;
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
  my $self=shift;
  
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


sub win32_openssl {
  my $openssl='';
  my $pfad="/OpenSSL/bin/openssl";
  return $pfad if (-e "$pfad.exe");
  
  
  # Suche unterhalb /Programme/
  $pfad="/Programme/OpenSSL/bin/openssl";
  return $pfad if (-e "$pfad.exe");

  # zusätzlicher Pfad 
  $pfad="/OpenSSL-Win32/bin/openssl";
  return $pfad if (-e "$pfad.exe");

  return undef;
}


sub win32_mysql {
  my $pfad='';
  
  # Suche Server 5.1
  $pfad='/Programme/MySQL/MySQL Server 5.1/bin/';
  return $pfad if (-e $pfad."mysql.exe");
  
  
  # Suche Server 5.0
  $pfad='/Programme/MySQL/MySQL Server 5.0/bin/';
  return $pfad if (-e $pfad."mysql.exe");

  return undef;
}


sub suche_gswin32 {
  my $gswin32=undef;
  my $i=0;
  # Suche unterhalb /gs
  while ($i<100) {
    my $pfad="/gs/gs8.$i/bin/gswin32c";
    $gswin32=$pfad if (-e "$pfad.exe");
    $i++;
  }

  $i=0;
  # Suche unterhalb /Programme/gs
  while ($i<100) {
    my $pfad="/Programme/gs/gs8.$i/bin/gswin32c";
    $gswin32=$pfad if (-e "$pfad.exe");
    $i++;
  }

  return $gswin32;
}


sub runden {
  # runden auf 2 NK stellen genau, nur positive Zahlen
  my $self=shift;
  my ($zahl) = @_;
  $zahl *= 100;
  $zahl += 0.5 if($zahl > 0);
  $zahl -= 0.5 if($zahl < 0);
  return ($zahl/100) if($zahl !~ /\./g); # Fehler in perl ausgleichen
  my $erg=int($zahl);
  $erg = $erg / 100;
  return $erg;
}

1;
__DATA__
# Konfigurationsdatei default
# speichern im Verzeichnis /etc/tinyheb/tinyheb.conf
MySQLDBName = PRD_Hebamme
MySQLServerName = localhost
MySQLServerPort = 3306
MySQLServerUser = wwwrun
MySQLServerPassword = 
MySQLServerRootPassword = 

BackupFilePath = /var/tinyheb/sqlbak
