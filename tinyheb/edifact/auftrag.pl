#!/usr/bin/perl -w

# Version 0.1 
# erstellen der Auftragsdatei für den Datenaustausch mit den
# gestzlichen Krankenkassen

use strict;
use Getopt::Long;
use lib '../';

use Heb_Edi;
use Heb_leistung;

my $debug=1;
my $e = new Heb_Edi;
my $l = new Heb_leistung;

my $help=0;
my $update=0;
my $sendmail=0;
my $ignore=0;

my $result = GetOptions('help!' => \$help,
			'mail!' => \$sendmail,
			'update!' => \$update,
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

$l->rechnung_such("ZAHL_DATUM,BETRAGGEZ,BETRAG,STATUS","RECHNUNGSNR=$rechnr");
my ($zahl_datum,$betraggez,$betrag,$status)=$l->rechnung_such_next();

die "Rechnung nicht vorhanden Abbruch\n" if (!defined($status));

if ($status > 20 && !($ignore) ) {
  die "Rechnung wurde schon elektronisch gestellt oder ist schon (Teil-)bezahlt Rechnungsstatus ist:$status\n";
}

my ($dateiname,$erstell_auf,$erstell_nutz)=$e->edi_rechnung($rechnr);

die "Zentral IK ist keine Datenannahmestelle oder nicht Parametrisiert keine elektronische Rechnung erstellt \n" unless(defined($dateiname));

my $erg=$e->mail($dateiname,$rechnr,$erstell_auf,$erstell_nutz);
if ($sendmail) {
  # ergebnis nach sendmail pipen
  open SEND, "| /usr/sbin/sendmail -t"
    or die "konnte sendmail nicht öffnen $!\n";
  print SEND $erg;
  close SEND;
} else {
  print $erg;
}
if($update) {
  die "die Rechnung ist schon (Teil-)bezahlt, es kann kein update mehr gemacht werden\n" if($status > 23);
  $e->edi_update($rechnr,$ignore);
}

	    
