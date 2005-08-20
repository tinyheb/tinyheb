#!/usr/bin/perl -wT
# -wT

use strict;
use CGI;

use lib "../";
use Heb_leistung;

my $l = new Heb_leistung;
my $q = new CGI;


#print "Content-Type: application/postscript\n";
my $rech_id = $q->param('rech_id') || -1;

$l->rechnung_such("RECH","RECHNUNGSNR=$rech_id");
my $rech=$l->rechnung_such_next() || '';

print $q->header ( -type => "application/postscript", -expires => "-1d");
print $rech;

