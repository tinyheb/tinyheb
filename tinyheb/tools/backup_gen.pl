#!/usr/bin/perl -w
#-wT
#-d:ptkdb
#-d:DProf  

# Backup der tinyHeb Datenbank anlegen

# Copyright (C) 2006 Thomas Baum <thomas.baum@arcor.de>
# Thomas Baum, 42719 Solingen, Germany

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

use strict;
use CGI;
use Date::Calc qw(Today);
use Compress::Zlib;

use lib "../";
use Heb;

my $q = new CGI;
my $h = new Heb;

my $mysqldump = 'mysqldump';

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();

my $umfang = $q->param('umfang') || 'alles';
my $passwort = $q->param('passwort') || '';

print $q->header ( -type => "application/octet-stream", -expires => "-1d",
		   -Content_Disposition => "attachment; filename=tinyheb_backup$TODAY.sql.gz"
		 );

if ($passwort ne '') {
  $mysqldump .= " -u root -p=$passwort";
} else {
  $mysqldump .= " -u root ";
}

my $dbname=$h->db_name();
if ($umfang eq 'alles') {
  $mysqldump .= " -a --databases $dbname";
} else {
  $mysqldump .= " -a $dbname Krankenkassen";
}

open(SICHER,"-|",$mysqldump) or die "Konnte Datenbank nicht sichern\n";
my $zeile='';
binmode STDOUT;
my $byteswritten1=0;
my $gz = gzopen(\*STDOUT,"wb") or die "Cannot open stdout: $gzerrno\n" ;
if ($umfang ne 'alles') {
  $gz->gzwrite("use $dbname;\n");
  $byteswritten1=$gz->gzwrite("drop table Krankenkassen;\n");
} else {
  $byteswritten1=$gz->gzwrite("drop database $dbname;\n");
}

my $byteswritten2=undef;
while($zeile=<SICHER>) {
  $byteswritten2=$gz->gzwrite($zeile) or die "error writing: $gzerrno\n";
}
$gz->gzclose;
warn "Achtung: es wurde keine korrekte Sicherung angelegt" if (!defined($byteswritten2));

