#!/usr/bin/perl -w

# Version 0.1 
# erstellen der Auftragsdatei für den Datenaustausch mit den
# gestzlichen Krankenkassen

use strict;
use Getopt::Long;
use lib '../';

use Heb_Edi;

my $debug=1;
my $e = new Heb_Edi;

my $help=0;
my $update=0;
my $sendmail=0;

my $result = GetOptions('help!' => \$help,
			'mail!' => \$sendmail,
			'update!' => \$update);

if ($help) {
  print "
usage $0 options rechnr
--help <-> help
--update <-> kein update/insert der elektronischen Rechnung in Datenbank
--mail <-> automatischen Senden der Rechnung per Email
";
  exit;
}

my $rechnr = pop @ARGV;

if (!($rechnr =~ /\d{8}/)) {
  die "keine gültige Rechnungsnummer angegeben\n";
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

	    
