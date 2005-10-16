#!/usr/bin/perl -w

# Version 0.1 
# erstellen der Auftragsdatei für den Datenaustausch mit den
# gestzlichen Krankenkassen

use strict;
use lib '../';

use Heb_Edi;

my $debug=1;
my $e = new Heb_Edi;

#my $st=$e->gen_auf(0,0,104212516,100,120,12);
#print "st: $st\n";
#print "SLLA_FKT ",$e->SLLA_FKT(123456789,987654321);
#print "SLLA_REC ",$e->SLLA_REC('20050030','20051008');
#print "SLLA_INV ",$e->SLLA_INV('0308691059','3 1','20050030');
#print "SLLA_NAD ",$e->SLLA_NAD('Goldmann',"D+Angelo",19710319,'Rubensstr. 3',42719,'Solingen');
#print "SLLA_ENF ",$e->SLLA_ENF('4',20051008,13.6,3);
#print "SLLA_SUT ",$e->SLLA_SUT('10:00','11:00',60);
#print "SLLA_TXT ",$e->SLLA_TXT('Wehen');
#print "SLLA_BES ",$e->SLLA_BES(1023.32);

#print "UNH ",$e->UNH(2,'SLLA');
#print "UNT ",$e->UNT(4,2);
#my $summe=0;
#my $erg=$e->SLGA(20050056);
#if (defined($erg)) {
#  print $erg;
#}
#($erg,$summe)=$e->SLLA(20050056);
#if (defined($erg)) {
#  print $erg,"Summe: $summe\n";
#}

#print $e->gen_nutz(20050056);
#print length($e->gen_nutz(20050056)),"\n";
my ($dateiname,$erstell_auf,$erstell_nutz)=$e->edi_rechnung(20050056);
print $e->mail($dateiname,20050056,$erstell_auf,$erstell_nutz);
