#!/usr/bin/perl -wT

# 28.02.2004
# Package um Dat�mer zu verarbeiten

# author: Thomas Baum

package Heb_datum;

use strict;
use DBI;
use Date::Calc qw(check_date Add_Delta_DHMS check_time Today);

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
  $max_feiertag = Heb->parm_unique('KALENDER_ID');
  bless $self, ref $class || $class;
  return $self;
}

sub convert {
  # konvertiert datum vom Format tt.mm.jjjj nach jjj-mm-tt
  # es wird "error" geliefert, falls Datum nicht g�ltig ist
  
  shift; # package namen vom Stack nehmen

  my ($eingabe_datum) = @_;
  return $eingabe_datum if ($eingabe_datum =~ /\d{1,4}-\d{1,2}-\d{1,2}/);
  my ($tag,$monat,$jahr) = split '\.',$eingabe_datum;
  return "error" if (!(defined($tag) && defined($monat) && defined($jahr)));
  $jahr += 1900 if ($jahr > 49 && $jahr < 100);
  $jahr += 2000 if ($jahr < 50); # siehe auch Heb.js
  return "error" if (!check_date($jahr,$monat,$tag));
  return sprintf "%4.4u-%2.2u-%2.2u",$jahr,$monat,$tag;
}


sub convert_tmj {
  # konvertiert datum vom Format jjjj-mm-tt nach tt.mm.jjjj
  # es wird "error" geliefert, falls Datum nicht g�ltig ust
  shift;
  my ($eingabe_datum) = @_;
  return $eingabe_datum if ($eingabe_datum =~ /\d{1,2}\.\d{1,2}\.\d{1,4}/);
  my ($jahr,$monat,$tag) = split '-',$eingabe_datum;
  return "error" if (!(defined($tag) && defined($monat) && defined($jahr)));
  $jahr += 1900 if ($jahr > 49 && $jahr < 100);
  $jahr += 2000 if ($jahr < 50); # siehe auch Heb.js
  return "error" if (!check_date($jahr,$monat,$tag));
  return sprintf "%2.2u.%2.2u.%4.4u",$tag,$monat,$jahr;
}

sub jmt {
  # liefert Tripel jahr,monat,tag
  shift;
  my ($datum) = @_;
  $datum=Heb_datum->convert($datum);
  return split '-',$datum;
}

sub zeit_h {
  # holt die Stunden aus dem Paramter hh:mm
  shift;
  my ($zeit) = @_;
  my ($h,$m) = split ':',$zeit;
  return 0 if (!(defined($h)));
  return $h;
}

sub convert_zeit {
  shift;
  my ($time) = @_;
  return '' if (!defined($time) || $time eq '');
  return $time if($time =~ /^\d{1,2}:\d{2}$/);
  if ($time =~ /^(\d{1,2})(\d{2})$/) {
    return $1.':'.$2;
  }
  return $time;
}

sub check_zeit {
  # pr�ft, ob die zeit eine g�ltige ist
  shift;
  my ($z1) = @_;
  my ($h1,$m1) = split ':',$z1;
  return 0 if (!defined($h1) || !defined($m1));
  return check_time($h1,$m1,0);
}

sub dauer_m {
  # eingabe 2 zeiten im Format hh:mm es wird die Dauer in Minuten berechnet
  shift;
  my ($z1,$z2)= @_;
  my ($h1,$m1) = split ':',$z1;
  my ($h2,$m2) = split ':',$z2;
  $h2 *=-1;
  $m2 *=-1;
  my ($y,$m,$d,$H,$M,$S)=Add_Delta_DHMS(1900,1,1,$h1,$m1,0,0,$h2,$m2,0);
  my $erg = $H*60+$M;
  return $erg;
}


sub monat {
  # liefert den aktuellen Monat
  my ($y,$m,$d)=Today();
  $m=sprintf "%2.2u",$m;
  return $m;
}

sub fuerzeit_check {
  # ermittelt aus Fuerzeit, ob Flag auf komma Werte rechnen gesetzt ist
  shift;
  my ($fz) = @_;
  $fz = 0 unless(defined($fz));
  $fz =~ /(E{0,1})(\d{1,3})/;
  return ($1,$2);
}


sub feiertag_ins {
  # f�gt neuen Feiertag in Datenbank ein
  shift;

  # zun�chst neue ID f�r Kalender Eintrag holen
  my $id = Heb->parm_unique('KALENDER_ID');
  $id++;
  # insert an DB vorbereiten
  my $feiertag_ins = $dbh->prepare("insert into Kalender ".
                                        "(ID,NAME,BUNDESLAND,DATUM) ".
                                        "values (?,?,?,?);")
    or die $dbh->errstr();
  my $erg = $feiertag_ins->execute($id,@_)
    or die $dbh->errstr();
  Heb->parm_up('KALENDER_ID',$id);
  $max_feiertag = $id;
  return $max_feiertag;
}


sub feiertag_update {
  # speichert ge�nderte Daten ab
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
  # l�scht Krankenkasse aus der Datenbank
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
  shift; # package Namen vom stack nehmen
  $feiertag_such->execute(@_) or die $dbh->errstr();
}

sub feiertag_such_next {
  return $feiertag_such->fetchrow_array();
}

sub feiertag_feier_id {
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


sub feiertag_datum {
  # pr�ft ob Datum ein Feiertag ist
  shift;
  my $datum=shift;

  my $feier_datum = $dbh->prepare("select * from Kalender where ".
				  "DATUM = ?;")
    or die $dbh->errstr();
  $datum=Heb_datum->convert($datum);
  my $erg = $feier_datum->execute($datum) or die $dbh->errstr();
  return $erg if ($erg > 0);
  return 0;
}

sub max {
  # gibt die h�chste ID zur�ck
  return $max_feiertag;
}

1;
