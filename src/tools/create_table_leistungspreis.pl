#!/usr/bin/perl -w

# legt neue Tabelle Leistungspreis an

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
$dbh->do("CREATE TABLE Leistungspreis (" .  
	 "VON_WOTAG DECIMAL(1,0)  NOT NULL," .
	 "VON_ZEIT TIME NOT NULL," .
	 "BIS_WOTAG DECIMAL(1,0) NOT NULL," .
	 "BIS_ZEIT TIME NOT NULL," .
	 "PREIS DECIMAL(6,2)," .
	 "FK_LEISTUNGSART SMALLINT UNSIGNED NOT NULL," .
	 "FOREIGN KEY (FK_LEISTUNGSART) REFERENCES Leistungsart(ID) MATCH FULL);") or die $dbh->errstr();

$dbh->disconnect();
