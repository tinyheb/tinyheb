#!/usr/bin/perl -w

# legt neue Tabelle Leistungsart an

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
$dbh->do("CREATE TABLE Leistungsart (" .  
	 "ID SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT," .
	 "BEZEICHNUNG TEXT NOT NULL," .
	 "LEISTUNGSTYP CHAR(02) NOT NULL," .
	 "GUELT_VON DATE NOT NULL DEFAULT '1990-01-01'," .
	 "GUELT_BIS DATE NOT NULL DEFAULT '9999-01-01'," .
	 "PRIMARY KEY (ID) );") or die $dbh->errstr();

$dbh->disconnect();
