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
our $feiertag_such; # suchen von Feiertagen
our $max_feiertag=0; # maximal vergebene ID

sub new {
  my($class) = @_;
  my $self = {};
  $dbh = Heb->connect;
  $feiertag_such = $dbh->prepare("select ID,NAME,BUNDESLAND, ".
				 "DATE_FORMAT(DATUM,'%d.%m.%Y') ".
				 "from Kalender where ".
				 "NAME LIKE ? and ".
				 "BUNDESLAND LIKE ? and ".
				 "DATUM LIKE ?;");
  my $max_id = $dbh->prepare("select max(id) from Kalender;") or die $dbh->errstr();
  $max_id->execute() or die $dbh->errstr();
  $max_feiertag = $max_id->fetchrow_array();

  bless $self, ref $class || $class;
  return $self;
}

sub convert {
  # konvertiert datum vom Format tt.mm.jjjj nach jjj-mm-tt
  # es wird "error" geliefert, falls Datum nicht gültig ist
  
  shift; # package namen vom Stack nehmen

  my ($eingabe_datum) = @_;
  return $eingabe_datum if ($eingabe_datum =~ /\d{4}-\d{2}-\d{2}/);
  my ($tag,$monat,$jahr) = split '\.',$eingabe_datum;
  return "error" if (!(defined($tag) && defined($monat) && defined($jahr)));
  return "error" if (!check_date($jahr,$monat,$tag));
  return sprintf "%4.4u-%2.2u-%2.2u",$jahr,$monat,$tag;
}


sub convert_tmj {
  # konvertiert datum vom Format jjjj-mm-tt nach tt.mm.jjjj
  # es wird "error" geliefert, falls Datum nicht gültig ust
  shift;
  my ($eingabe_datum) = @_;
  return $eingabe_datum if ($eingabe_datum =~ /\d{2}\.\d{2}\.\d{4}/);
  my ($jahr,$monat,$tag) = split '-',$eingabe_datum;
  return "error" if (!(defined($tag) && defined($monat) && defined($jahr)));
  return "error" if (!check_date($jahr,$monat,$tag));
  return sprintf "%2.2u.%2.2u.%4.4u",$tag,$monat,$jahr;
}


sub zeit_h {
  # holt die Stunden aus dem Paramter hh:mm
  shift;
  my ($zeit) = @_;
  my ($h,$m) = split ':',$zeit;
  return $h;
}


sub feiertag_ins {
  # fügt neuen Feiertag in Datenbank ein

  shift;

  # insert an DB vorbereiten
  my $feiertag_ins = $dbh->prepare("insert into Kalender ".
                                        "(ID,NAME,BUNDESLAND,DATUM) ".
                                        "values (?,?,?,?);")
    or die $dbh->errstr();
  my $erg = $feiertag_ins->execute('NULL',@_)
    or die $dbh->errstr();
  $max_feiertag = $feiertag_ins->{'mysql_insertid'};
  return $max_feiertag;
}


sub feiertag_update {
  # speichert geänderte Daten ab
  shift;
  # updaten an DB vorbereiten
  my $feiertag_up = $dbh->prepare("update Kalender set ".
                                       "NAME=?,BUNDESLAND=?,DATUM=? ".
                                       "where ID=?;")
    or die $dbh->errstr();
  my $erg = $feiertag_up->execute(@_)
    or die $dbh->errstr();
  return $erg;
}


sub feiertag_delete {
  # löscht Krankenkasse aus der Datenbank
  shift;
  # delete an DB vorbereiten
  my $feiertag_del = $dbh->prepare("delete from Kalender ".
				   "where ID=?;")
    or die $dbh->errstr();
  my $erg = $feiertag_del->execute(@_)
    or die $dbh->errstr();
  return $erg;
}


sub feiertag_such {
  # Sucht nach Krankenkassen in der Datenbank

  shift; # package Namen vom stack nehmen
  $feiertag_such->execute(@_) or die $dbh->errstr();
}

sub feiertag_such_next {
  return $feiertag_such->fetchrow_array();
}

sub feiertag_feier_id {
  # holgt alle Daten zu einer Krankenkasse
  shift;

  my $feier_id = $dbh->prepare("select NAME,BUNDESLAND,".
			       "DATE_FORMAT(DATUM,'%d.%m.%Y') ".
                               "from Kalender where ID = ?;")
    or die $dbh->errstr();
  $feier_id->execute(@_) or die $dbh->errstr();
  my @erg = $feier_id->fetchrow_array();
  for (my $i=0;$i < $#erg;$i++) {
    if (!defined($erg[$i])) {
      $erg[$i]='';
    }
  }
  return @erg;
}

sub max {
  # gibt die höchste ID zurück
  return $max_feiertag;
}

1;
