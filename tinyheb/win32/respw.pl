#!/usr/bin/perl -w


# Hilfsprogramm um root Passwort des MySQL zurückzusetzen

# $Id: respw.pl,v 1.1 2008-01-19 14:24:54 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2008 Thomas Baum <thomas.baum@arcor.de>
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
use File::Copy;
use Cwd;
use Win32::Service qw/StopService StartService GetStatus GetServices/;

write_LOG("Starte reset ---------------------------------------------");

my %statcodeHash = (
                    '1' => 'stopped.',
                    '2' => 'start pending.',
                    '3' => 'stop pending.',
                    '4' => 'running.',
                    '5' => 'continue pending.',
                    '6' => 'pause pending.',
                    '7' => 'paused.'
                   );
my %statusHash;

my $eingabe='';
my $serv_erg='';
my $id='$Id: respw.pl,v 1.1 2008-01-19 14:24:54 thomas_baum Exp $';

print "Reset fuer tinyHeb Copyright (C) 2007 Thomas Baum\n";
print "Version of this reset programm $id\n";
print "The tinyHeb reset programm comes with ABSOLUTELY NO WARRANTY;\nfor details see the file gpl.txt\n";
print "This is free software, and you are welcome to redistribute it\n";
print "under certain conditions; for details see the file gpl.txt\n\n";


print "Es wird zunaechst geprueft, ob MySQL vorhanden ist\n";
print "\n";

write_LOG("Starte Reset Programm ----------------------------");
print "Pruefe auf MySQL\n";
my $pfad="/Programme/MySQL/MySQL Server 5.0/bin/mysql.exe";
print "$pfad \t";
if (-e $pfad) {
  print "ist vorhanden\n";
  write_LOG("MySQL vorhanden");
} else {
  print "nicht vorhanden,\nBitte zunaechst den MySQL Server Installieren,\nbevor dieses Setup Programm erneut gestartet werden kann\n";
  write_LOG("MySQL nicht vorhanden");
  print "Bitte die ENTER Taste zum Beenden des Reset Programmes druecken\n";
  $eingabe=<STDIN>;
  exit(1);
}

my $service='MySQL';
my $s=StopService('',$service);
print "Stoppe $service\n" if($s);
error("MySQL konnte nicht gestoppt werden\n") if(warte(5,$service) ne '1');


print "Schreibe neue init\n";
open INIT,">/mysql_init.txt" or error("Konnte mysql-init.txt nicht schreiben $!\n");

print INIT "SET PASSWORD FOR 'root'\@'localhost' = PASSWORD('');";
close INIT;

print "Bitte noch 30 Sekunden warten und dann den Computer neu starten!\n";
print "ODER ueber den Task Manager den Prozess mysqld-nt.exe beenden\n";
print "Danach die Datei mysql_init.txt aus dem Verzeichis \\ loeschen\n";

my $mysql_erg=`"C:/Programme/MySQL/MySQL Server 5.0/bin/mysqld-nt.exe" --defaults-file="C:/Programme/MySQL/MySQL Server 5.0/my.ini" --init-file="C:/mysql_init.txt"`;
    

print "Es ist ein Problem aufgetreten, bitte Computer neu starten\n";
print "Bitte die ENTER Taste zum Beenden des Passwort Reset druecken\n";

$eingabe=<STDIN>;
write_LOG("Ende Passwort reset --------------------------------------------------");






sub warte {
  my ($dauer,$service)=@_;
  my $i=0;
  while ($i<$dauer) {
    GetStatus('',$service,\%statusHash);
    if (defined($statusHash{"CurrentState"}) && $statusHash{"CurrentState"} =~ /[1-7]/) {
      print $service . " Status ist aktuell " . $statcodeHash{$statusHash{"CurrentState"}} . "\n";
    }
    write_LOG("$service status",%statusHash);
    $i++;
    sleep(1);
  }
  print "\n";
  return $statusHash{"CurrentState"};
}


sub write_LOG {

  if(!open (LOG,">>reset.log")) {
    print "FEHLER log Datei kann nicht geschrieben werden: $!\n";
    print "Bitte die ENTER Taste zum Beenden des Update druecken\n";
    my $eingabe=<STDIN>;
    exit(1);
  }

  my @log = @_;
  my $print_log = join(':',@log);
  my $time = join(':',localtime);
  print LOG "LOG:$time\t$print_log\n";
  close (LOG);
};

sub error {
  my ($error)=@_;
  write_LOG($error);
  print "FEHLER $error\n";
  print "Bitte die ENTER Taste zum Beenden des Reset druecken\n";
  my $eingabe=<STDIN>;
  exit(1);
}
