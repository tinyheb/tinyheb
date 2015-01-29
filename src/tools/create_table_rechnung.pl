#!/usr/bin/perl -w

# legt neue Tabelle Rechnung an

# T. Baum
# 07.05.05

use lib "../";
use strict;
use DBI;
use Heb;

my $h = new Heb;


my $user = 'baum';
my $pass = '';

# mit Datenbank verbinden
my $dbh = Heb->connect;

# fehler beim verbinden abfangen
die $DBI::errstr unless $dbh;

# neue Tabelle anlegen
$dbh->do("CREATE TABLE Rechnung (" .  
	 "RECHNUNGSNR CHAR(20),".
	 "RECH_DATUM DATE," .
	 "MAHN_DATUM DATE," .
	 "ZAHL_DATUM DATE," .
	 "BETRAG float(2) UNSIGNED ZEROFILL DEFAULT 0,".
	 "STATUS SMALLINT UNSIGNED DEFAULT 20,".
	 "BETRAGGEZ float(2) UNSIGNED ZEROFILL DEFAULT 0,".
	 "FK_STAMMDATEN SMALLINT UNSIGNED NOT NULL,".
	 "IK INT UNSIGNED NOT NULL,".
	 "RECH MEDIUMBLOB );") or die $dbh->errstr();

$dbh->disconnect();
