#!/usr/bin/perl -wT

# 28.02.2004
# Package um Datümer zu verarbeiten

# author: Thomas Baum

package Heb_datum;

use strict;
use DBI;
use Date::Calc qw(check_date);

use Heb;

my $debug = 1;
our $dbh; # Verbindung zur Datenbank

sub new {
  my($class) = @_;
  my $self = {};
  $dbh = Heb->connect;
  bless $self, ref $class || $class;
  return $self;
}

sub convert {
  # konvertiert datum vom Format tt.mm.jjjj nach jjj-mm-tt
  # es wird "error" geliefert, falls Datum nicht gültig ist
  
  shift; # package namen vom Stack nehmen

  my ($eingabe_datum) = @_;
  my ($tag,$monat,$jahr) = split '\.',$eingabe_datum;
  return "error" if (!(defined($tag) && defined($monat) && defined($jahr)));
  return "error" if (!check_date($jahr,$monat,$tag));
  return sprintf "%4.4u-%2.2u-%2.2u",$jahr,$monat,$tag;
}

1;
