#!/usr/bin/perl -w
#-wT
#-d:ptkdb
#-d:DProf  

# Backup der tinyHeb Datenbank anlegen

# $Id$
# Tag $Name$

# Copyright (C) 2006 - 2010 Thomas Baum <thomas.baum@arcor.de>
# Thomas Baum, 42719 Solingen, Germany

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

use strict;
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use Date::Calc qw(Today);
use Compress::Zlib;

use lib "../";
use Heb;

my $q = new CGI;
my $h = new Heb;

my $mysqldump = 'mysqldump';
if ($^O =~ /MSWin32/) {
#  my $pfad='/Programme/MySQL/MySQL Server 5.0/bin/mysqldump';
  my $pfad=$h->win32_mysql().'mysqldump';
  $mysqldump='"'.$pfad.'"' if (-e "$pfad.exe");
}

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();

my $umfang = $q->param('umfang') || 'alles';
my $passwort = $q->param('passwort') || '';


if ($passwort ne '') {
  $mysqldump .= " -u root --password=$passwort";
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
my $anz_bytes=0;
while(my $zeile=<SICHER>) {
  $anz_bytes+=length($zeile);
}
close SICHER;

if ($anz_bytes < 10) {
  print $q->header ( -type => "text/html", -expires => "-1d");
  print '<head>';
  print '<title>Backup Error</title>';
  print '</head>';
  print '<body bgcolor=white>';
  print '<h1>Es kann keine korrekte Sicherung angelegt werden,</br> Bitte Passwort und ggf. Error-Log des Webservers prüfen</br></h1>';
  print '<input type="button" name="zurueck" value="Zurück" onclick=window.location="backup.pl">';

  print "</body>";
  print "</html>";
  exit(1);
}


print $q->header ( -type => "application/octet-stream", -expires => "-1d",
		   -Content_Disposition => "attachment; filename=tinyheb_backup$TODAY.sql.gz"
		 );

open(SICHER,"-|",$mysqldump) or die "Konnte Datenbank nicht sichern\n";
my $zeile='';
binmode STDOUT;
my $byteswritten1=0;
my $gz = gzopen(\*STDOUT,"wb") or die "Cannot open stdout: $gzerrno\n" ;
if ($umfang ne 'alles') {
  $gz->gzwrite("use $dbname;\n");
  $byteswritten1=$gz->gzwrite("drop table Krankenkassen;\n");
} else {
  $byteswritten1=$gz->gzwrite("drop database if exists $dbname;\n");
}

my $byteswritten2=undef;
while($zeile=<SICHER>) {
  $byteswritten2=$gz->gzwrite($zeile) or die "error writing: $gzerrno\n";
}
$gz->gzclose;
close SICHER;
die "Achtung: es wurde keine korrekte Sicherung angelegt" if (!defined($byteswritten2));

