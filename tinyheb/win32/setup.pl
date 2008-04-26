#!/usr/bin/perl -w


# Mini Setup für tinyHeb

# $Id: setup.pl,v 1.10 2008-04-26 12:47:23 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2007,2008 Thomas Baum <thomas.baum@arcor.de>
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

write_LOG("Starte setup ---------------------------------------------");

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
my $id='$Id: setup.pl,v 1.10 2008-04-26 12:47:23 thomas_baum Exp $';

write_LOG("Programm id $id");

print "Setup fuer tinyHeb Copyright (C) 2007,2008 Thomas Baum\n";
print "Version of this setup programm $id\n";
print "The tinyHeb setup programm comes with ABSOLUTELY NO WARRANTY;\nfor details see the file gpl.txt\n";
print "This is free software, and you are welcome to redistribute it\n";
print "under certain conditions; for details see the file gpl.txt\n\n";


print "Es wird zunaechst geprueft, ob alle Komponenten vorhanden sind\n";
print "\n";

printf "Perl Version ist %vd\n\n",$^V;
my $p_version=sprintf "%vd",$^V;
write_LOG("Perl Version",$p_version);

print "Pruefe ob Windows Version installiert\n";
write_LOG("Pruefe ob Windows Version installiert");

open WIN,"../erfassung/krankenkassenerfassung.pl" or error("Konnte Datei krankenkassenerfassung.pl im Verzeichnis erfassung nicht öffnen $!\n");
my $first_line = <WIN>;
if ($first_line =~ /^#!perl -wT/) {
  print "Windows Version installiert\n";
  write_LOG("Windows Version installiert");
} else {
  print "Du hast die Linux Version installiert, bitte lade Dir von http://www.tinyheb.de/source/ zunaechst die Windows Version herunter\n";
  print "Oder starte das Programm linux2win.pl aus dem Verzeichnis win32\n";
  print "Bitte die ENTER Taste zum Beenden des Setup druecken\n";
  write_LOG("Linux installiert");
  $eingabe=<STDIN>;
  exit(1);
}
close WIN;


print "Pruefe auf Apache\n";
my $a_pfad="/Programme/Apache Group/Apache2/";
my $a_pfad2="/Programme/Apache Software Foundation/Apache2.2/";
my $apachepfad='';
my $a_flag=0;
print "\n";
if (-e $a_pfad."bin/Apache.exe" || -e $a_pfad2."bin/httpd.exe") {
  $apachepfad = $a_pfad if(-e $a_pfad."bin/Apache.exe");
  $apachepfad = $a_pfad2 if(-e $a_pfad2."bin/httpd.exe");
  $a_flag=1 if(-e $a_pfad."bin/Apache.exe");
  $a_flag=0 if(-e $a_pfad2."bin/httpd.exe");
  print "ist vorhanden an $apachepfad\n";
  write_LOG("Apache vorhanden $apachepfad");
  write_LOG("an Stelle $a_pfad") if (-e $a_pfad."bin/Apache.exe");
  write_LOG("an Stelle $a_pfad2") if (-e $a_pfad2."bin/httpd.exe");
} else {
  print "nicht vorhanden,\nBitte zunaechst den Apache Webserver Installieren,\nbevor dieses Setup Programm erneut gestartet werden kann\n";
  write_LOG("Apache nicht vorhanden");
  print "Bitte die ENTER Taste zum Beenden des Setup druecken\n";
  $eingabe=<STDIN>;
  exit(1);
}

print "Suche httpd.conf\n";
my @pfad = split '/',$apachepfad;
shift @pfad;
shift @pfad;
$apachepfad='';
my $httpd=join '/',@pfad;
my $httpd_pfad1="/Program Files/".$httpd.'/conf/';
my $httpd_pfad2="/Programme/".$httpd.'/conf/';


my $win_vista=0;
$apachepfad="/Programme/".$httpd if (-e $httpd_pfad2);

if (-e $httpd_pfad1) {
  $apachepfad="/Program Files/".$httpd;
  $win_vista=1;
}

unless($apachepfad) {
  write_LOG("Setze Apache Pfad auf default");
  $apachepfad="/Programme/Apache Group/Apache2";
  $a_flag=1; # wenn default, dann auch Apache auf Version 2 setzen
}

print "Arbeite mit $apachepfad\n";
write_LOG("Apache PFad $apachepfad");
write_LOG("Vista Flag $win_vista");

print "\nPruefe ob tinyHeb im richtigen Verzeichnis installiert\n";
my $win_path=getcwd();
my $suchpfad="$apachepfad"."/cgi-bin/tinyheb/win32";
if ($win_path =~ /$suchpfad/) {
  print "Ist im korrekten Verzeichnis installiert\n";
  write_LOG("Im korrekten Verzeichnis $win_path : $suchpfad");
} else {
  print "Falsches Installationsverzeichnis:\n$win_path \nBitte tinyHeb im Verzeichnis $apachepfad"."/cgi-bin/ entpacken!\n";
  write_LOG("nicht im korrekten Verzeichnis $win_path\nSuchpfad $suchpfad");
  print "Bitte die ENTER Taste zum Beenden des Setup druecken\n";
  $eingabe=<STDIN>;
  exit(1);
}


print "Pruefe auf MySQL\n";
my $pfad="/Programme/MySQL/MySQL Server 5.0/bin/mysql.exe";
print "$pfad \t";
if (-e $pfad) {
  print "ist vorhanden\n";
  write_LOG("MySQL vorhanden");
} else {
  print "nicht vorhanden,\nBitte zunaechst den MySQL Server Installieren,\nbevor dieses Setup Programm erneut gestartet werden kann\n";
  write_LOG("MySQL nicht vorhanden");
  print "Bitte die ENTER Taste zum Beenden des Setup druecken\n";
  $eingabe=<STDIN>;
  exit(1);
}

print "Pruefe auf OpenSSL\n";
$pfad=win32_openssl();
if (defined($pfad)) {
  print "OpenSSL $pfad ist vorhanden\n";
  write_LOG("OpenSSL $pfad vorhanden");
} else {
  print "OpenSSL nicht vorhanden,\nBitte zunaechst OpenSSL Installieren,\nbevor dieses Setup Programm erneut gestartet werden kann\n";
  write_LOG("OpenSSL nicht vorhanden");
  print "Bitte die ENTER Taste zum Beenden des Setup druecken\n";
  $eingabe=<STDIN>;
  exit(1);
}


print "Pruefe auf Ghostscript\n";
$pfad=suche_gswin32();

if (defined($pfad)) {
  print "Ghostscript $pfad ist vorhanden\n";
  write_LOG("Ghostscript $pfad vorhanden");
} else {
  print "Ghostscript nicht vorhanden,\nBitte zunaechst Ghostscript Installieren,\nbevor dieses Setup Programm erneut gestartet werden kann\n";
  write_LOG("Ghostscript nicht vorhanden");
  print "Bitte die ENTER Taste zum Beenden des Setup druecken\n";
  $eingabe=<STDIN>;
  exit(1);
}


print "\n\nBis jetzt sieht alles gut aus\n\n";

print "Es wird jetzt versucht die fehlenden Perl Pakete aus dem Internet zu laden\n";
$eingabe=0;
my $os='';

while ($eingabe < 1 or $eingabe > 3 or $eingabe !~ /\d{1}/) {
  print "Welches Betriebssystem wird genutzt?\n";
  print "(1) Win98\n";
  print "(2) WinXP\n";
  print "(3) Vista\n";
  print "(4) anderes Windows System\n";
  print "Eingabe :";
  $eingabe=<STDIN>;
  chomp $eingabe;
  $os='WinXP' if ($eingabe==2 || $eingabe==3);
  write_LOG("OS:",$eingabe,$os);
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
      write_LOG("unbekannte Fehler bei Neugenerierung ppm",$erg);
      print "Bitte die ENTER Taste zum Beenden des Setup druecken\n";
      $eingabe=<STDIN>;
      exit(1);
    }
    print "Der Paketmanager wurde neu generiert\n";
  }
}

write_LOG("Perl Pakete installieren");
print "Bitte Verbindung zum Internet aufbauen und die ENTER Taste druecken\n";
$eingabe=<STDIN>;

# falls Perl Version 5.10.x zusätzlich Repositorys angeben
if ($^V ge v5.10.0) {
  print "Muss Perl Pakete teilweise von anderen Quellen installieren\n";
  write_LOG("Perl andere Quellen notwendig");
  # prüfen ob Paketquellen schon vorhanden
  my $ppm_rep = `ppm repo list`;
  unless ($ppm_rep =~ /trouchelle/i && 
	  $ppm_rep =~ /bribes/i &&
	  $ppm_rep =~ /uwinnipeg/i) {
    print "muessen hinzugefuegt werden\n";
    write_LOG("muessen hinzugefuegt werden");
    system('ppm repo add http://www.bribes.org/perl/ppm/');
    system('ppm repo add http://cpan.uwinnipeg.ca/PPMPackages/10xx/');
    system('ppm repo add http://trouchelle.com/ppm10/');
  } else {
    print "sind schon vorhanden\n";
    write_LOG("sind schon vorhanden $ppm_rep");
  }
  # unter perl 5.10 ist Tk nicht mehr dabei
  system('ppm install Tk');
}

system('ppm install Date-Calc');
system('ppm install dbi');
system('ppm install DBD-mysql');
system('ppm install PostScript-Simple');
system('ppm install Mail-Sender');
system('ppm install DBD-XBase');

write_LOG("Perl Pakete installieren Ende");
print "\nDie fehlenden Pakete sind jetzt initialisiert\n";
print "Die Verbindung zum Internet wird nicht mehr benoetigt\n\n";


print "Soll ich die httpd.conf fuer den Webserver kopieren (ja/nein) [ja]";
$eingabe = <STDIN>;
chomp $eingabe;
write_LOG("Frage httpd.conf copy",$eingabe);
if ($eingabe =~ /ja/i || $eingabe eq '') {
  if ($win_vista) {
    write_LOG("Kopiere httpd.conf fuer win vista");
    if ($a_flag) {
      write_LOG("httpd_vista.conf");
      copy("httpd_vista.conf","$apachepfad"."/conf/httpd.conf") or error("konnte httpd.conf fuer Apache2 nicht kopieren $!\n");
    } else {
      write_LOG("httpd_vista22.conf");
      copy("httpd_vista22.conf","$apachepfad"."/conf/httpd.conf") or error("konnte httpd.conf fuer Apache2.2 nicht kopieren $!\n");
    }
  } else {
    write_LOG("Kopiere httpd.conf fuer irgendein windows");
    if ($a_flag) {
      write_LOG("httpd.conf");
      copy("httpd.conf","$apachepfad"."/conf/httpd.conf") or error("konnte httpd.conf fuer Apache2 nicht kopieren $!\n");
    } else {
      write_LOG("httpd22.conf");
      copy("httpd22.conf","$apachepfad"."/conf/httpd.conf") or error("konnte httpd.conf fuer Apache2.2 nicht kopieren $!\n");
    }
  }
  print "Habe die httpd.conf kopiert\n";
}

print "\nSoll ich die my.ini fuer den MySQL Server kopieren (ja/nein) [ja]";
$eingabe = <STDIN>;
chomp $eingabe;
write_LOG("Frage my.ini copy",$eingabe);
if ($eingabe =~ /ja/i || $eingabe eq '') {
  copy("my.ini","/Programme/MySQL/MySQL Server 5.0/my.ini") or error("konnte my.ini nicht kopieren $!\n");
  print "Habe die my.ini kopiert\n";
}


if ($os eq 'WinXP') {
  print "\nSoll ich den Apache Webserver neu starten, damit die Aenderungen wirksam werden (ja/nein) [ja]";
  $eingabe = <STDIN>;
  chomp $eingabe;
  write_LOG("Frage Apache start",$eingabe);
  if ($eingabe =~ /ja/i || $eingabe eq '') {
    my $service='Apache2.2';
    write_LOG("Apache Service Name: $service");
    $service='Apache2' if ($a_flag);
    my $s=StopService('',$service);
    warte(7,$service);
    print "Habe $service gestoppt\n" if($s);
    $s=StartService('',$service);
    warte(4,$service);
    print "Habe $service gestartet\n" if($s);
    GetStatus('',$service,\%statusHash);
    write_LOG("Apache status",%statusHash);
    if ($statusHash{"CurrentState"} ne '4') {
      print "Konnte Apache nicht starten\n";
    }
  }
  
  
  print "\nSoll ich die MySQL Datenbank neu starten, damit die Aenderungen wirksam werden (ja/nein) [ja]";
  $eingabe = <STDIN>;
  chomp $eingabe;
  if ($eingabe =~ /ja/i || $eingabe eq '') {
    my $service='MySQL';
    my $s=StopService('',$service);
    print "Stoppe $service\n" if($s);
    warte(5,$service);
    GetStatus('',$service,\%statusHash);
    if ($statusHash{"CurrentState"} =~ /[1-7]/) {
      print $service . " ist aktuell " . $statcodeHash{$statusHash{"CurrentState"}} . "\n";
    }
    
    $s=StartService('',$service);
    $serv_erg=warte(5,$service);
    GetStatus('',$service,\%statusHash);
    if ($statusHash{"CurrentState"} =~ /[1-7]/) {
      print $service . " ist aktuell " . $statcodeHash{$statusHash{"CurrentState"}} . "\n";
    }
    if($statusHash{"CurrentState"} eq '4') {
      print "Habe $service gestartet\n";
    } else {
      print $service . " ist aktuell " . $statcodeHash{$statusHash{"CurrentState"}} . "\n";
    }
    write_LOG("MySQL status",%statusHash);
    
  }
  
  
  print "\nSoll ich die tinyHeb Datenbank initialisieren (ja/nein) [ja]";
  $eingabe = <STDIN>;
  chomp $eingabe;
  write_LOG("Frage MySQL init",$eingabe);
  
  if ($eingabe =~ /ja/i || $eingabe eq '') {
    if(warte(1,'MySQL') ne '4') {
      print "Kann die Datenbank nicht initialisieren, weil der Server nicht gestartet werden konnte\nBitte manuell initialisieren\n";
      print "\n\nJetzt muss ein Neustart des Rechners ausgefuehrt werden, damit\n";
      print "die Aenderungen an der Konfiguration des Webservers und des\n";
      print "MySQL Servers (Datenbank) wirksam werden\n\n";
      
      print "danach muss Du noch in das Verzeichnis DATA wechseln und\n";
      print "folgenden Befehl in der Kommandozeile ausfuehren:\n";
      print "mysql -u root < init.sql\n";
      print "ODER falls Du bei der MySQL Installation ein Passwort fuer\n den Datenbankadmin angegeben hast:\n";
      print "mysql -p -u root < init.sql\n\n";
      write_LOG('MYSQL ist gestoppt, setup wird abgebrochen');
      $eingabe=<STDIN>;
      exit(1);
    }

    # Datenbank Version dumpen
    system('"C:/Programme/MySQL/MySQL Server 5.0/bin/mysql" --version >> setup.log');
    print "wenn kein Passwort fuer die MySQL Datenbank vergeben wurde,\nbei der Frage nach dem Passwort bitte ENTER druecken\n";
    open INIT,'"C:/Programme/MySQL/MySQL Server 5.0/bin/mysql" -p -u root < ../DATA/init.sql |' or die "konnte Datenbank nicht initialisieren $!\n";
    while (my $zeile=<INIT>) {
      print "Zeile $zeile\n";
    };
    my $cl=close(INIT);
    if ($? == 0) { 
      print "Habe die Datenbank initialisiert\n";
      print "Jetzt kann tinyHeb in Deinem Browser unter dem Link\nhttp://localhost/tinyheb/hebamme.html aufgerufen werden\n";
    } else {
      print "\nDie Datenbank konnte vermutlich nicht initialisiert werden\n";
      print "Du musst noch in das Verzeichnis DATA wechseln und\n";
      print "folgenden Befehl in der Kommandozeile ausfuehren:\n";
      print "mysql -u root < init.sql\n";
      print "ODER falls Du bei der MySQL Installation ein Passwort fuer\n den Datenbankadmin angegeben hast:\n";
      print "mysql -p -u root < init.sql\n\n";
    }
  }
} else {
  print "\n\nJetzt muss ein Neustart des Rechners ausgefuehrt werden, damit\n";
  print "die Aenderungen an der Konfiguration des Webservers und des\n";
  print "MySQL Servers (Datenbank) wirksam werden\n\n";

  print "danach muss Du noch in das Verzeichnis DATA wechseln und\n";
  print "folgenden Befehl in der Kommandozeile ausfuehren:\n";
  print "mysql -u root < init.sql\n";
  print "ODER falls Du bei der MySQL Installation ein Passwort fuer\n den Datenbankadmin angegeben hast:\n";
  print "mysql -p -u root < init.sql\n\n";
}



print "Bitte die ENTER Taste zum Beenden des Setup druecken\n";
$eingabe=<STDIN>;
write_LOG("Ende setup --------------------------------------------------");


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

sub suche_gswin32 {
  my $gswin32=undef;
  my $i=0;
  # Suche unterhalb /gs
  while ($i<100) {
    my $pfad="/gs/gs8.$i/bin/gswin32c";
    $gswin32=$pfad if (-e "$pfad.exe");
    $i++;
  }

  $i=0;
  # Suche unterhalb /Programme/gs
  while ($i<100) {
    my $pfad="/Programme/gs/gs8.$i/bin/gswin32c";
    $gswin32=$pfad if (-e "$pfad.exe");
    $i++;
  }

  return $gswin32;
}

sub win32_openssl {
  my $openssl='';
  my $pfad="/OpenSSL/bin/openssl";
  return $pfad if (-e "$pfad.exe");
  
  
  # Suche unterhalb /Programme/
  $pfad="/Programme/OpenSSL/bin/openssl";
  return $pfad if (-e "$pfad.exe");

  return undef;
}


sub write_LOG {

  if(!open (LOG,">>setup.log")) {
    print "FEHLER log Datei kann nicht geschrieben werden: $!\n";
    print "Bitte die ENTER Taste zum Beenden des Update druecken\n";
    my $eingabe=<STDIN>;
    exit(1);
  }

  my @log = @_;
  my $print_log = join(':',@log);
  print LOG "LOG:",scalar (localtime),"\t$print_log\n";
  close (LOG);
};

sub error {
  my ($error)=@_;
  write_LOG($error);
  print "FEHLER $error\n";
  print "Bitte die ENTER Taste zum Beenden des Setup druecken\n";
  my $eingabe=<STDIN>;
  exit(1);
}
