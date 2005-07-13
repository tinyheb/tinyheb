#!/usr/bin/perl -w

# legt neue Tabelle Stammdaten an
# alle Stammdaten der Frau

# T. Baum
# 16.12.03

use strict;
use DBI;

my $user = 'baum';
my $pass = '';

my @dsn = ("DBI:mysql:database=Hebamme;host=localhost",$user,$pass);

# mit Datenbank verbinden
my $dbh = DBI->connect(@dsn,{ RaiseError => 1, AutoCommit => 1 });

# fehler beim verbinden abfangen
die $DBI::errstr unless $dbh;

# neue Tabelle anlegen
$dbh->do("CREATE TABLE Parms (" .
	 "ID SMALLINT UNSIGNED NOT NULL,".
	 "NAME CHAR(20),".
	 "VALUE CHAR(100)," .
	 "BESCHREIBUNG CHAR(100) );") or die $dbh->errstr();

$dbh->disconnect();
