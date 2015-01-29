#!/usr/bin/perl -w

# legt neue Tabelle Kalender an

use lib "../";
use strict;
use DBI;

use Heb;

my $h = new Heb;

my $dbh = Heb->connect;

# fehler beim verbinden abfangen
die $DBI::errstr unless $dbh;

# neue Tabelle anlegen
$dbh->do("CREATE TABLE Kalender (" .  
	 "ID SMALLINT UNSIGNED,".
	 "NAME CHAR(100) NOT NULL," . # Name des Feiertages
	 "BUNDESLAND CHAR(100) NOT NULL," . # Bundesland in dem der Feiertag gilt
	 "DATUM DATE NOT NULL,". # Datum des Feiertages
	 "PRIMARY KEY(ID) );") or die $dbh->errstr(); # Datum des Tages

$dbh->disconnect();
