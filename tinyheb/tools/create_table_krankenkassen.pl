#!/usr/bin/perl -w

# legt neue Tabelle Krankenkassen an

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
$dbh->do("CREATE TABLE Krankenkassen (" .  
	 "ID SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT," .
	 "NAME TEXT," .
	 "STRASSE TEXT," .
	 "PLZ MEDIUMINT UNSIGNED NOT NULL," .
	 "ORT TEXT," .
	 "TEL DECIMAL(20,0)," .
	 "IK INT UNSIGNED," .
	 "PRIMARY KEY (ID) );") or die $dbh->errstr();

$dbh->disconnect();
