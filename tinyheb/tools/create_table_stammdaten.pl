#!/usr/bin/perl -w

# legt neue Tabelle Stammdaten an
# alle Stammdaten der Frau

# T. Baum
# 16.12.03

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
$dbh->do("CREATE TABLE Stammdaten (" .  
	 "ID SMALLINT UNSIGNED NOT NULL,".
	 "VORNAME TEXT NOT NULL," .
	 "NACHNAME TEXT NOT NULL," .
	 "GEBURTSDATUM_FRAU DATE NOT NULL," .
	 "STRASSE TEXT NOT NULL," .
	 "PLZ MEDIUMINT UNSIGNED NOT NULL, ".
	 "ORT TEXT NOT NULL, ".
	 "TEL CHAR(30), ".
	 "ENTFERNUNG DECIMAL(6,2) NOT NULL DEFAULT 4, ".
	 "KRANKENVERSICHERUNGSNUMMER CHAR(30), ".
	 "KRANKENVERSICHERUNGSNUMMER_GUELTIG CHAR(04), ".
	 "VERSICHERTENSTATUS CHAR(10), ".
	 "IK INT UNSIGNED, ".
	 "BUNDESLAND TEXT NOT NULL,". 
	 "GEBURTSDATUM_KIND DATE,".
	 "NAECHSTE_HEBAMME CHAR(1), ".
	 "BEGRUENDUNG_NICHT_NAECHSTE_HEBAMME TEXT, ".
	 "DATUM DATE NOT NULL, ".
	 "PRIMARY KEY (ID) );") or die $dbh->errstr();

$dbh->disconnect();
