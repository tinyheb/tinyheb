#!/usr/bin/perl -w

# legt neue Tabelle Kalender an

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
$dbh->do("CREATE TABLE Kalender (" .  
	 "NAME CHAR(100) NOT NULL," . # Name des Feiertages
	 "BUNDESLAND CHAR(100) NOT NULL," . # Bundesland in dem der Feiertag gilt
	 "DATUM DATE NOT NULL);") or die $dbh->errstr(); # Datum des Tages

$dbh->disconnect();
