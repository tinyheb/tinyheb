#!/usr/bin/perl -w
#-wT
#-d:ptkdb
#-d:DProf

# Einspielen eines Backups der tinyHeb Datenbank

# Copyright (C) 2007 - 2010 Thomas Baum <thomas.baum@arcor.de>
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
#use Data::Dumper;

use lib "../";
#use Heb;

my $q = new CGI;
#my $h = new Heb;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();

my $datei = $q->param('datei') || '';
my $passwort = $q->param('passwort') || '';

my $abschicken = $q->param('abschicken');
my $hint='';
my $mysql = 'mysql';
if ($^O =~ /MSWin32/) {
  my $pfad='/Programme/MySQL/MySQL Server 5.0/bin/mysql';
  $mysql = '"'.$pfad.'"' if (-e "$pfad.exe");

  # falls 5.1 mysql gefunden wird, wird dieses genutzt.
  $pfad='/Programme/MySQL/MySQL Server 5.1/bin/mysql';
  $mysql = '"'.$pfad.'"' if (-e "$pfad.exe");
#  warn "Restore $mysql";
}
if ($passwort ne '') {
  $mysql .= " -u root --password=$passwort ";
} else {
  $mysql .= " -u root ";
}

if (defined($abschicken)) {
  restore();
}

print $q->header ( -type => "text/html", -expires => "-1d");

print '<head>';
print '<title>Sicherung der Datenbank einspielen</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';


# Alle Felder zur Eingabe ausgeben
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Sicherung der <i>tinyHeb</i> Datenbank einspielen</h1>';
print '<hr width="90%">';
print '</div><br>';
# Formular ausgeben
print '<form name="restore" action="restore.pl" method="post" enctype="multipart/form-data" target=_top bgcolor=white>';
print '<table border="0" width="700" align="left">';

# Dateinamen für upload angegen
print '<tr><td><table border="0" align="left">';
print '<tr><td><b>Dateiname der Sicherung</b></td></tr>';
print '</tr>';
print '<tr>';
print "<td><input type='file' name='datei' value='$datei' size='50'></td>";
print "</tr>";
print '</table>';
print "\n";

# Root Passwort
print '<tr><td><table border="0" align="left">';
print '<tr><td><b>Passwort des Datenbankadmin</b> (falls benötigt)</td></tr>';
print '</tr>';
print '<tr>';
print "<td><input type='password' name='passwort' value='$passwort' size='15' maxlength='14'></td>";
print "</tr>";
print '</table>';
print "\n";


# leere Zeile
print '<tr><td>&nbsp;</td></tr>';
print "\n";

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';

print '<td><input type="submit" name="abschicken" value="Sicherung einspielen"></td>';
print '<td><input type="button" name="hauptmenue" value="Hauptmenue" onClick="haupt();"></td>';
print '<td><input type="button" name="wartungsmenue" value="Wartungsmenue" onClick="window.location=\'../wartung.html\';"></td>';

print '</tr>';
print '</table>';
print '</form>';

print '</tr>';
print '</table>';

if ($hint ne '') {
  print "<script>";
  print "alert('$hint');";
  print "</script>";
}
print "</body>";
print "</html>";


sub restore {
  my ($fh) = $q->upload('datei');
  if ($datei eq '') {
    $hint='keine Datei angegeben, es wurde keine Sicherung eingespielt\n';
    return;
  }
  binmode $fh;

  # dateien anlegen
  if (!(-d "/tmp/wwwrun")) {
    mkdir "/tmp" if (!(-d "/tmp"));
    mkdir "/tmp/wwwrun";
  }

  open (my $fh2,'>/tmp/wwwrun/sicher.gz');
  binmode $fh2;
  my $buffer;
  while (read($fh,$buffer,16384) ) {
    print $fh2 $buffer;
  }
  close $fh2;

  open (my $fh3,'/tmp/wwwrun/sicher.gz');
  binmode $fh3;

#  my $gz=gzopen(\*$fh,"rb");
  my $gz=gzopen($fh3,"rb");
  my $erg='';
  my $line='';
  my $line_counter=0;
  while ($gz->gzreadline($line)) {
    $erg .= $line;
    $line_counter++;
  }
  $gz->gzclose;
  if($line_counter < 20) {
    $hint='keine Ordnungsgemäße Datensicherung, es wurde nichts verarbeitet\n';
    return;
  }

  # jetzt Restore in Datenbank einspielen
  unlink('/tmp/wwwrun/restore.sql');
  my $fd=open RESTORE,">/tmp/wwwrun/restore.sql";
  unless(defined($fd)) {
    $hint='konnte Datenbank nicht in Zwischendatei ablegen, keine Sicherung eingespielt\n';
    return;
  }
  print RESTORE $erg;
  close RESTORE;
  my $exit_value=system("$mysql < /tmp/wwwrun/restore.sql");
  if ($exit_value > 0) {
    $hint="Sicherung konnte nicht erfolgreich in Datenbank eingespielt werden, bitte Passwort und Error-Log des Webserver überprüfen";
    return;
  }

  $hint="Sicherung wurde in Datenbank eingespielt es wurden $line_counter Zeilen verarbeitet";
}
