# Package um Datümer zu verarbeiten

# $Id: Heb_datum.pm,v 1.25 2008-04-25 15:12:12 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2004,2005,2006,2007,2008 Thomas Baum <thomas.baum@arcor.de>
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
# author: Thomas Baum

package Heb_datum;

use strict;
use DBI;
use Date::Calc qw(check_date Add_Delta_DHMS check_time Today Day_of_Week Decode_Month);

use Heb;

my $debug = 1;
my $h= new Heb;
my $dbh=$h->connect; # Verbindung zur Datenbank
my $feiertag_such; # suchen von Feiertagen
my $max_feiertag=0; # maximal vergebene ID


$feiertag_such = $dbh->prepare("select ID,NAME,BUNDESLAND, ".
			       "DATE_FORMAT(DATUM,'%d.%m.%Y') ".
			       "from Kalender where ".
			       "NAME LIKE ? and ".
			       "BUNDESLAND LIKE ? and ".
			       "DATUM LIKE ?;");
$max_feiertag = $h->parm_unique('KALENDER_ID');

sub new {
  my($class) = @_;
  my $self = {};

  push @{$self->{BUNDESLAENDER}},'NRW','Bayern','Hessen','Niedersachsen','Hamburg','Rheinland-Pfalz','Thüringen','Sachsen-Anhalt','Sachsen';
  bless $self, ref $class || $class;
  return $self;
}

sub bundeslaender {
  my $self = shift;
  return @{$self->{BUNDESLAENDER}};
}

sub convert {
  # konvertiert datum vom Format tt.mm.jjjj nach jjj-mm-tt
  # es wird "error" geliefert, falls Datum nicht gültig ist
  
  my $self=shift; # package namen vom Stack nehmen

  my ($eingabe_datum) = @_;
  return unless($eingabe_datum);
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
  # es wird "error" geliefert, falls Datum nicht gültig ust
  my $self=shift;
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
  my $self=shift;
  my ($datum) = @_;
  $datum=$self->convert($datum);
  return split '-',$datum;
}

sub zeit_h {
  # holt die Stunden aus dem Paramter hh:mm
  my $self=shift;
  my ($zeit) = @_;
  my ($h,$m) = split ':',$zeit;
  return 0 if (!$h);
  return $h;
}

sub ist_saona {
  # prüft ob Samstag nach 12:00 oder Nacht ist
  my $self=shift;
  my($datum,$zeit)=@_;

#  $datum =~ s/-//g;
  my $dow=Day_of_Week($self->jmt($datum));
  return 1 if ($dow == 6 && $self->zeit_h($zeit) >= 12);
  return 1 if ($dow < 6 && ($self->zeit_h($zeit) >= 20 || 
			    $self->zeit_h($zeit) < 8));
  return undef;
}


sub wotag {
  my $self=shift;
  my ($datum)=@_;
  my $dow=Day_of_Week($self->jmt($datum));
  return 'Feiertag' if($self->feiertag_datum($datum));
  return 'Montag' if($dow == 1);
  return 'Dienstag' if($dow == 2);
  return 'Mittwoch' if($dow == 3);
  return 'Donnerstag' if($dow == 4);
  return 'Freitag' if($dow == 5);
  return 'Samstag' if($dow == 6);
  return 'Sonntag' if($dow == 7);
  return undef;
}

sub wotagnummer {
  my $self=shift;
  my ($datum)=@_;
  my $dow=Day_of_Week($self->jmt($datum));
  return 8 if($self->feiertag_datum($datum));
  return $dow;
}




sub convert_zeit {
  my $self=shift;
  my ($time) = @_;
  return '' if (!$time);
  return $time if($time =~ /^\d{1,2}:\d{2}$/);
  if ($time =~ /^(\d{1,2})(\d{2})$/) {
    return $1.':'.$2;
  }
  return $time;
}

sub check_zeit {
  # prüft, ob die zeit eine gültige ist
  my $self=shift;
  my ($z1) = @_;
  my ($h1,$m1) = split ':',$z1;
  return 0 if (!$h1 || !$m1);
  return check_time($h1,$m1,0);
}

sub dauer_m {
  # eingabe 2 zeiten im Format hh:mm es wird die Dauer in Minuten berechnet
  my $self=shift;
  my ($z1,$z2)= @_;
  return 0 if(!$z1 || !$z2);
  my ($h1,$m1) = split ':',$z1;
  my ($h2,$m2) = split ':',$z2;
  return 0 if(!$h2 || !$m2);
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
  my $self=shift;
  my ($fz) = @_;
  $fz = 0 unless($fz);
  $fz =~ /(E{0,1})(\d{1,3})/;
  return ($1,$2);
}


sub feiertag_ins {
  # fügt neuen Feiertag in Datenbank ein
  my $self=shift;

  # zunächst neue ID für Kalender Eintrag holen
  my $id = $h->parm_unique('KALENDER_ID');
  $id++;
  # insert an DB vorbereiten
  my $feiertag_ins = $dbh->prepare("insert into Kalender ".
                                        "(ID,NAME,BUNDESLAND,DATUM) ".
                                        "values (?,?,?,?);")
    or die $dbh->errstr();
  my $erg = $feiertag_ins->execute($id,@_)
    or die $dbh->errstr();
  $h->parm_up('KALENDER_ID',$id);
  $max_feiertag = $id;
  return $max_feiertag;
}


sub feiertag_update {
  # speichert geänderte Daten ab
  my $self=shift;
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
  my $self=shift;
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
  # prüft ob Datum ein Feiertag ist
  shift;
  my $datum=shift;

  my $feier_datum = $dbh->prepare("select * from Kalender where ".
				  "DATUM = ?;")
    or die $dbh->errstr();
  my $erg = $feier_datum->execute($datum) or die $dbh->errstr();
  return $erg if ($erg > 0);
  return 0;
}



sub extract_date {
  # macht aus OpenSSL Datum einen "vernünftigen" Datumswert
  my $self=shift;
  my ($date_string)=@_;
  
  my ($mm,$dd,$time,$yyyy,$time_zone)=split ' ',$date_string;
  $mm=Decode_Month($mm);
  return sprintf "%4.4u%2.2u%2.2u",$yyyy,$mm,$dd;
}



sub max {
  # gibt die höchste ID zurück
  return $max_feiertag;
}

1;
