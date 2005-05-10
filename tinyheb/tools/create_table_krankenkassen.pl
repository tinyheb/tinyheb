#!/usr/bin/perl -w

# legt neue Tabelle Krankenkassen an


use lib "../";
use strict;
use DBI;

use Heb;

my $h = new Heb;
my $dbh = Heb->connect;

# fehler beim verbinden abfangen
die $DBI::errstr unless $dbh;

# neue Tabelle anlegen
$dbh->do("CREATE TABLE Krankenkassen (" .  
	 "IK INT UNSIGNED NOT NULL DEFAULT 0," .
	 "KNAME CHAR(100)," .
	 "NAME CHAR(100) NOT NULL,".
	 "STRASSE TEXT," .
	 "PLZ_HAUS MEDIUMINT UNSIGNED NOT NULL," .
	 "PLZ_POST MEDIUMINT UNSIGNED NOT NULL," .
	 "ORT TEXT," .
	 "POSTFACH CHAR(10),".
	 "ASP_NAME CHAR(100),".
	 "ASP_TEL CHAR(30)," .
	 "ZIK INT UNSIGNED NOT NULL DEFAULT 0," .
	 "BEMERKUNG TEXT," .
	 "UNIQUE INDEX IK_INDEX(IK),".
	 "INDEX NAME_INDEX (NAME),".
	 "PRIMARY KEY (IK) );") or die $dbh->errstr();

$dbh->disconnect();
