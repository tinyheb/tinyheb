#!/usr/bin/perl -w

# $Id: auftrag.pl,v 1.15 2008-07-20 16:55:29 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# erstellen der Auftragsdatei für den Datenaustausch mit den
# gestzlichen Krankenkassen

# Copyright (C) 2005,2006,2007,2008 Thomas Baum <thomas.baum@arcor.de>
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
use Getopt::Long;
use File::Copy;
use lib '../';

use Heb_Edi;
use Heb_leistung;
use Heb_krankenkassen;
use Heb;

my $path = $ENV{HOME}; # für temporäre Dateien
if ($^O =~ /MSWin32/) {
  $path .='/tinyheb';
} else {
  $path .='/.tinyheb';
}
if (!(-d "$path/tmp")) { # Zielverzeichnis anlegen
  mkdir "$path/tmp";
}


my $debug=1;

my $l = new Heb_leistung;
my $k = new Heb_krankenkassen;
my $h = new Heb;

my $help=0;
my $update=0;
my $sendmail=0;
my $ignore=0;
my $sig_pass='';

my $result = GetOptions('help!' => \$help,
			'mail!' => \$sendmail,
			'update!' => \$update,
			'passin=s' => \$sig_pass,
			'ignore!' => \$ignore);

if ($help) {
  print "
usage $0 options rechnr
--help <-> help
--update <-> update/insert der elektronischen Rechnung in Datenbank (default kein update)
--ignore <-> wenn Rechnung elektronisch gestellt oder Teilgezahlt, wird trotzdem elektronische Rechnung gestellt und ggf. update auf Datenbank gemacht
--mail <-> automatischen Senden der Rechnung per Email, sonst Ausgabe nach stdout
";
  exit;
}

my $rechnr = pop @ARGV;

if (!($rechnr =~ /\d{8}/)) {
  die "keine gültige Rechnungsnummer angegeben\n";
}

$l->rechnung_such("ZAHL_DATUM,BETRAGGEZ,BETRAG,STATUS,IK","RECHNUNGSNR=$rechnr");
my ($zahl_datum,$betraggez,$betrag,$status,$ik)=$l->rechnung_such_next();

die "Rechnung nicht vorhanden Abbruch\n" if (!defined($status));

if ($status > 20 && !($ignore) ) {
  die "Rechnung wurde schon elektronisch gestellt oder ist schon (Teil-)bezahlt Rechnungsstatus ist:$status\n";
}

my $e = new Heb_Edi($rechnr,
		    sig_pass => $sig_pass);
if(!defined($e)) {
  die "Fehler: $Heb_Edi::ERROR Abbruch\n";
}
my ($dateiname,$erstell_auf,$erstell_nutz)=$e->edi_rechnung($rechnr);

die "keine Datenannahmestelle vorhanden oder nicht Parametrisiert keine elektronische Rechnung erstellt \n" unless(defined($dateiname));

my $erg=$e->mail($dateiname,$rechnr,$erstell_auf,$erstell_nutz);

if($update) {
  die "die Rechnung ist schon (Teil-)bezahlt, es kann kein update mehr gemacht werden\n" if($status > 23);
  $e->edi_update($rechnr,$ignore,$dateiname,$erstell_auf);
}

if ($sendmail) {
  # ergebnis nach sendmail pipen
  open SEND, "| /usr/sbin/sendmail -t -f ".$h->parm_unique('HEB_EMAIL')
    or die "konnte sendmail nicht öffnen $!\n";
  print SEND $erg;
  close SEND;
} else {
  print $erg;
}

# Am Ende alle erstellten Zwischendateien verschieben, in Verzeichnis
# für Datenannahmestelle
my ($ktr,$zik)=$k->krankenkasse_ktr_da($ik);
my $empf_phys=$k->krankenkasse_empf_phys($zik);
print "Rechnung erfolgreich verschickt\n";
#$e->edi_update($rechnr,1,$dateiname,$erstell_auf);
if (!(-d "$path/tmp/$empf_phys")) { # Zielverzeichnis anlegen
  mkdir "$path/tmp/$empf_phys";
}
foreach my $ext ('','.AUF','.enc','.sig','.base64') {
  if (-e "$path/tmp/$dateiname$ext") {
    move("$path/tmp/$dateiname$ext","$path/tmp/$empf_phys/$dateiname$ext");
  }
}


	    
