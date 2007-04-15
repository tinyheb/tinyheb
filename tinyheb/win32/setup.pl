#!/usr/bin/perl -w


# Mini Setup für tinyHeb
# Copyright (C) 2007 Thomas Baum <thomas.baum@arcor.de>
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
use File::Copy;
use Win32::Service qw/StopService StartService/;

print "Setup für tinyHeb Copyright (C) 2007 Thomas Baum\n";
print "Version of this setup programm 0.1.0 \n";
print "The tinyHeb setup programm comes with ABSOLUTELY NO WARRANTY;\nfor details see the file gpl.txt\n";
print "This is free software, and you are welcome to redistribute it\n";
print "under certain conditions; for details see the file gpl.txt\n\n";


print "Es wird zunaechst geprueft, ob alle Komponenten vorhanden sind\n";
print "\n";

print "Pruefe auf Apache\n";
my $pfad="/Programme/Apache Group/Apache2/bin/Apache.exe";
print "$pfad \t";
if (-e $pfad) {
  print "ist vorhanden\n";
} else {
  print "nicht vorhanden,\nBitte zunaechst den Apache Webserver Installieren,\nbevor dieses Setup Programm erneut gestartet werden kann\n";
  exit(1);
}

print "Pruefe auf MySQL\n";
$pfad="/Programme/MySQL/MySQL Server 5.0/bin/mysql.exe";
print "$pfad \t";
if (-e $pfad) {
  print "ist vorhanden\n";
} else {
  print "nicht vorhanden,\nBitte zunaechst den MySQL Server Installieren,\nbevor dieses Setup Programm erneut gestartet werden kann\n";
  exit(1);
}

print "Pruefe auf OpenSSL\n";
$pfad="/OpenSSL/bin/openssl.exe";
print "$pfad \t";
if (-e $pfad) {
  print "ist vorhanden\n";
} else {
  print "nicht vorhanden,\nBitte zunaechst OpenSSL Installieren,\nbevor dieses Setup Programm erneut gestartet werden kann\n";
  exit(1);
}


print "Pruefe auf Ghostscript (Version 8.15)\n";
$pfad="/gs/gs8.15/bin/gswin32c.exe";
print "$pfad \t";
if (-e $pfad) {
  print "ist vorhanden\n";
} else {
  print "nicht vorhanden,\nBitte zunaechst Ghostscript Version 8.15 Installieren,\nbevor dieses Setup Programm erneut gestartet werden kann\n";
  exit(1);
}


print "\n\nBis jetzt sieht alles gut aus\n\n";

print "Es wird jetzt versucht die fehlenden Perl Pakete aus dem Internet zu laden\n";
my $eingabe=0;
my $os='';

while ($eingabe < 1 or $eingabe > 3 or $eingabe !~ /\d{1}/) {
  print "Welches Betriebssystem wird genutzt?\n";
  print "(1) Win98\n";
  print "(2) WinXP\n";
  print "(3) anderes Windows System\n";
  print "Eingabe :";
  $eingabe=<STDIN>;
  chomp $eingabe;
  $os='WinXP' if ($eingabe==2);
}
if ($eingabe == 1) {
  print "Du benutzt Win98, der perl Paketmanager ist vermutlich kaputt\n";
  print "Soll ich den Paketmanager neu generieren (ja/nein) [ja]? ";
  $eingabe =<STDIN>;
  chomp $eingabe;
  if (uc $eingabe eq 'NEIN') {
    print "ich verstehe, das ist nicht gewünscht\n";
  } else {
    print "ich generiere den Paketmanager neu:\n";
    unlink ("/Perl/bin/ppm.bat");
    my $erg=system ("/Perl/bin/pl2bat /Perl/bin/ppm");
    if ($erg > 0) {
      print "Es ist ein unbekannter Fehler aufgetreten, ggf. T. Baum benachrichtigen\nUnd Hardcopy der Bildschirmausgabe mitschicken\n";
      exit(1);
    }
    print "Der Paketmanager wurde neu generiert\n";
  }
}

print "Bitte Verbindung zum Internet aufbauen und die ENTER Taste druecken\n";
$eingabe=<STDIN>;

system('ppm install Date-Calc');
system('ppm install dbi');
system('ppm install DBD-mysql');
system('ppm install PostScript-Simple');
system('ppm install Mail-Sender');
system('ppm install DBD-XBase');

print "\nDie fehlenden Pakete sind jetzt initialisiert\n";
print "Die Verbindung zum Internet wird nicht mehr benoetigt\n\n";


print "Soll ich die httpd.conf fuer den Webserver kopieren (ja/nein) [ja]";
$eingabe = <STDIN>;
chomp $eingabe;
if ($eingabe =~ /ja/i || $eingabe eq '') {
  copy("httpd.conf","/Programme/Apache Group/Apache2/conf/httpd.conf") or die "konnte httpd.conf nicht kopieren $!\n";
  print "Habe die httpd.conf kopiert\n";
}

print "\nSoll ich die my.ini fuer den MySQL Server kopieren (ja/nein) [ja]";
$eingabe = <STDIN>;
chomp $eingabe;
if ($eingabe =~ /ja/i || $eingabe eq '') {
  copy("my.ini","/Programme/MySQL/MySQL Server 5.0/my.ini") or die "konnte my.ini nicht kopieren $!\n";
  print "Habe die my.ini kopiert\n";
}


if ($os eq 'WinXP') {
  print "\nSoll ich den Apache Webserver neu starten, damit die Aenderungen wirksam werden (ja/nein) [ja]";
  $eingabe = <STDIN>;
  chomp $eingabe;
  if ($eingabe =~ /ja/i || $eingabe eq '') {
    my $service='Apache2';
    my $s=StopService('',$service);
    warte(7);
    print "Habe $service gestoppt\n" if($s);
    $s=StartService('',$service);
    print "Habe $service gestartet\n" if($s);
  }
  
  
  print "\nSoll ich die MySQL Datenbank neu starten, damit die Änderungen wirksam werden (ja/nein) [ja]";
  $eingabe = <STDIN>;
  chomp $eingabe;
  if ($eingabe =~ /ja/i || $eingabe eq '') {
    my $service='MySQL';
    my $s=StopService('',$service);
    print "Habe $service gestoppt\n" if($s);
    warte(5);
    $s=StartService('',$service);
    warte(3);
    print "Habe $service gestartet\n" if($s);
  }
  
  
  print "\nSoll ich die tinyHeb Datenbank initialisieren (ja/nein) [ja]";
  $eingabe = <STDIN>;
  chomp $eingabe;
  if ($eingabe =~ /ja/i || $eingabe eq '') {
    open INIT,'"C:/Programme/MySQL/MySQL Server 5.0/bin/mysql" -u root -p < ../DATA/init.sql |' or die "konnte Datenbank nicht initialisieren $!\n";
    while (my $zeile=<INIT>) {};
    print "Habe die Datenbank initialisiert\n";
  }
} else {
  print "\n\nJetzt muss ein Neustart des Rechners ausgefuehrt werden, damit\n";
  print "die Aenderungen an der Konfiguration des Webservers und des\n";
  print "MySQL Servers (Datenbank) wirksam werden\n\n";

  print "danach muss Du noch in das Verzeichnis DATA wechseln und\n";
  print "folgenden Befehl in der Kommandozeile ausfuehren:\n";
  print "mysql -u root < init.sql\n";
  print "ODER falls Du bei der MySQL Installation ein Passwort fuer\n den Datenbankadmin angegeben hast:\n";
  print "mysql -u root -p < init.sql\n\n";
}
  
  print "Jetzt kann tinyHeb in Deinem Browser unter dem Link\nhttp://localhost/tinyheb/hebamme.html aufgerufen werden\n";


print "Bitte die ENTER Taste zum Beenden des Setup druecken\n";
$eingabe=<STDIN>;


sub warte {
  my ($dauer)=@_;
  my $i=0;
  while ($i<$dauer) {
    print ".\n";
    $i++;
    sleep(1);
  }
  print "\n";
}
