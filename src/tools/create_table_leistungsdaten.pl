#!/usr/bin/perl -wT

# legt neue Tabelle Leistungsdaten an

use lib "../";
use strict;
use DBI;

use Heb;

my $h = new Heb;

# mit Datenbank verbinden
my $dbh = $h->connect;

# fehler beim verbinden abfangen
die $DBI::errstr unless $dbh;

# neue Tabelle anlegen
$dbh->do("CREATE TABLE Leistungsdaten (" .  
	 "ID INT UNSIGNED NOT NULL," .
	 "POSNR VARCHAR(5) NOT NULL," .
	 "FK_STAMMDATEN SMALLINT UNSIGNED NOT NULL," .
	 "BEGRUENDUNG TEXT," .
	 "DATUM DATE NOT NULL," .
	 "ZEIT_VON TIME," .
	 "ZEIT_BIS TIME," .
	 "ENTFERNUNG_T FLOAT DEFAULT 0," .
	 "ENTFERNUNG_N FLOAT DEFAULT 0," .
	 "ANZAHL_FRAUEN SMALLINT UNSIGNED NOT NULL DEFAULT 1," .
	 "PREIS FLOAT DEFAULT 0," .
	 "RECHNUNGSNR CHAR(20), ".
	 "STATUS SMALLINT UNSIGNED,".
	 "PRIMARY KEY (ID),".
	 "FOREIGN KEY (FK_STAMMDATEN) REFERENCES Stammdaten(ID) MATCH FULL);") or die $dbh->errstr();

$dbh->disconnect();
