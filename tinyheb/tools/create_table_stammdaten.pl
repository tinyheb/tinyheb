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
$dbh->do("CREATE TABLE Stammdaten (" .  
	 "NUMMER DECIMAL(5,0) NOT NULL,".
	 "VORNAME CHAR(200) NOT NULL," .
	 "NACHNAME CHAR(200) NOT NULL," .
	 "GEBURTSDATUM_FRAU DATE NOT NULL," .
	 "STRASSE CHAR(200) NOT NULL," .
	 "PLZ MEDIUMINT UNSIGNED NOT NULL, ".
	 "ORT CHAR(200) NOT NULL, ".
	 "KRANKENVERSICHERUNGSNUMMER CHAR(30), ".
	 "KRANKENVERSICHERUNGSNUMMER_GUELTIG DATE, ".
	 "VERSICHERTENSTATUS CHAR(100), ".
	 "NAME_KRANKENKASSE CHAR(255), ".
	 "IK_KRANKENKASSE CHAR(20), ".
	 "BUNDESLAND CHAR(100) NOT NULL,". 
	 "GEBURTSDATUM_KIND DATE,".
	 "NAECHSTE_HEBAMME CHAR(1), ".
	 "BEGRUENDUNG_NICHT_NAECHSTE_HEBAMME VARCHAR(255), ".
	 "DATUM DATE NOT NULL, ".
	 "PRIMARY KEY NUMMER_KEY(NUMMER) );") or die $dbh->errstr();

$dbh->disconnect();
