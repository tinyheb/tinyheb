#!/usr/bin/perl -w

# legt neue Tabelle Leistungsdaten an

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
$dbh->do("CREATE TABLE Leistungsdaten (" .  
	 "FK_LEISTUNGSART SMALLINT UNSIGNED NOT NULL," .
	 "FK_STAMMDATEN SMALLINT UNSIGNED NOT NULL," .
	 "BEGRUENDUNG TEXT," .
	 "DATUM DATE NOT NULL," .
	 "ZEIT TIME NOT NULL," .
	 "DAUER TIME," .
	 "ENTFERNUNG DECIMAL(5,2)," .
	 "FOREIGN KEY (FK_LEISTUNGSART) REFERENCES Leistungsart(ID) MATCH FULL,".
	 "FOREIGN KEY (FK_STAMMDATEN) REFERENCES Stammdaten(ID) MATCH FULL);") or die $dbh->errstr();

$dbh->disconnect();
