# Package um Stammdaten zu verarbeiten

# $Id: Heb_stammdaten.pm,v 1.14 2008-04-25 15:18:09 thomas_baum Exp $
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

package Heb_stammdaten;

use strict;
use DBI;

use Heb;
my $h = new Heb;
my $debug = 0;
my $dbh=$h->connect; # Verbindung zur Datenbank
my $frau_such; # suchen von Frauen
$frau_such = $dbh->prepare("select ID,VORNAME,NACHNAME,".
			   "DATE_FORMAT(GEBURTSDATUM_FRAU,'%d.%m.%Y'),".
			   "DATE_FORMAT(GEBURTSDATUM_KIND,'%d.%m.%Y'),".
			   "PLZ,ORT,TEL,STRASSE,ANZ_KINDER,ENTFERNUNG, ".
			   "KRANKENVERSICHERUNGSNUMMER,".
			   "KRANKENVERSICHERUNGSNUMMER_GUELTIG,".
			   "VERSICHERTENSTATUS,".
			   "IK,".
			   "NAECHSTE_HEBAMME,".
			   "BEGRUENDUNG_NICHT_NAECHSTE_HEBAMME, ".
			   "KZETGT, ".
			   "TIME_FORMAT(GEBURTSZEIT_KIND,'%H:%i') ".
			   "from Stammdaten where ".
			   "VORNAME like ? and ".
			   "NACHNAME like ? and ".
			   "GEBURTSDATUM_FRAU like ? and ".
			   "GEBURTSDATUM_KIND like ? and ".
			   "PLZ like ? and ".
			   "ORT like ? and ".
			   "STRASSE like ?;");

our $max_frau=0; # maximal vergebene id

sub new {
  my($class) = @_;
  my $self = {};
  bless $self, ref $class || $class;
  $max_frau = $h->parm_unique('STAMMDATEN_ID');
  return $self;
}

sub stammdaten_suchfrau {
  # Sucht nach Frauen in der Datenbank

  my $self=shift; # package Namen vom stack nehmen

  $frau_such->execute(@_) or die $dbh->errstr();

}


sub stammdaten_suchfrau_next {
  my @erg = $frau_such->fetchrow_array();
  for (my $i=0;$i < $#erg;$i++) {
    if (!defined($erg[$i])) {
      $erg[$i]='';
    }
  }
  return @erg;
}


sub stammdaten_ins {
  # fügt neue Person in Datenbank ein

  my $self=shift; # package Namen vom stack nehmen

  my($vorname,
     $nachname,
     $geburtsdatum_frau,
     $strasse,
     $plz,
     $ort,
     $tel,
     $entfernung,
     $krankenversicherungsnummer,
     $krankenversicherungsnummer_gueltig,
     $versichertenstatus,
     $ik,
     $anz_kinder,
     $geburtsdatum_kind,
     $naechste_hebamme,
     $begruendung_nicht_naechste_hebamme,
     $datum,
     $kzetgt,
     $geburtszeit_kind,
     $id_alt) = @_;

  # zunächst neue ID für Frau holen
  $h->parm_such('STAMMDATEN_ID');
  my $id = $h->parm_such_next;
  $id++;
  $id = $id_alt if (defined($id_alt));

  # insert an Datenbank vorbereiten
  my $stammdaten_ins = $dbh->prepare("insert into Stammdaten ".
				     "(ID,VORNAME,NACHNAME,GEBURTSDATUM_FRAU,".
				     "STRASSE,PLZ,ORT,TEL,ENTFERNUNG,".
				     "KRANKENVERSICHERUNGSNUMMER,".
				     "KRANKENVERSICHERUNGSNUMMER_GUELTIG,".
				     "VERSICHERTENSTATUS,IK,".
				     "ANZ_KINDER,GEBURTSDATUM_KIND,".
				     "NAECHSTE_HEBAMME,".
				     "BEGRUENDUNG_NICHT_NAECHSTE_HEBAMME,".
				     "DATUM,".
				     "KZETGT,".
				     "GEBURTSZEIT_KIND".
				     ")".
				     "values (?,?,?,?,".
				     "?,?,?,?,?,".
				     "?,".
				     "?,".
				     "?,?,".
				     "?,?,".
				     "?,".
				     "?,".
				     "?,".
				     "?,".
				     "?);")
    or die $dbh->errstr();
  my $erg = $stammdaten_ins->execute($id,$vorname,$nachname,$geburtsdatum_frau,
				     $strasse,$plz,$ort,$tel,$entfernung,
				     $krankenversicherungsnummer,
				     $krankenversicherungsnummer_gueltig,
				     $versichertenstatus,$ik,
				     $anz_kinder,$geburtsdatum_kind,
				     $naechste_hebamme,
				     $begruendung_nicht_naechste_hebamme,
				     $datum,$kzetgt,$geburtszeit_kind)
#				     $datum,$kzetgt,undef)
    or die $dbh->errstr();

  $h->parm_up('STAMMDATEN_ID',$id) if(!defined($id_alt));
  print "ergebnis ins_id $id<br>\n" if $debug;
  return $id;
}

sub stammdaten_update {
  # speichert geänderte Daten ab
  my $self=shift;
  # update an Datenbank vorbereiten
  my $stammdaten_up = $dbh->prepare("update Stammdaten set ".
				    "VORNAME=?,NACHNAME=?,GEBURTSDATUM_FRAU=?,".
				    "STRASSE=?,PLZ=?,ORT=?,TEL=?,ENTFERNUNG=?,".
				    "KRANKENVERSICHERUNGSNUMMER=?,".
				    "KRANKENVERSICHERUNGSNUMMER_GUELTIG=?,".
				    "VERSICHERTENSTATUS=?,IK=?,".
				    "ANZ_KINDER=?,GEBURTSDATUM_KIND=?,".
				    "NAECHSTE_HEBAMME=?,".
				    "BEGRUENDUNG_NICHT_NAECHSTE_HEBAMME=?,".
				    "DATUM=?, ".
				    "KZETGT=?, ".
				    "GEBURTSZEIT_KIND=? ".
				    "where ID=?;")
    or die $dbh->errstr();
  my $erg = $stammdaten_up->execute(@_)
    or die $dbh->errstr();

  print "ergebnis $erg<br>\n" if $debug;
  return $erg;
}


sub stammdaten_delete {
  # löscht Datensatz aus der Datenbank
  my $self=shift;
  # delete an Datenbank vorbereiten
  my $stammdaten_del = $dbh->prepare("delete from Stammdaten ".
				     "where ID=?;")
    or die $dbh->errstr();
  my $erg = $stammdaten_del->execute(@_)
    or die $dbh->errstr();
   
  print "ergebnis $erg<br>\n" if $debug;
  return $erg;
}  


sub stammdaten_frau_id {
  # holt alle Daten zu einer Frau
  my $self=shift;

  my ($id) = @_;

  my $frau_id = $dbh->prepare("select VORNAME,NACHNAME,".
			      "DATE_FORMAT(GEBURTSDATUM_FRAU,'%d.%m.%Y'),".
			      "DATE_FORMAT(GEBURTSDATUM_KIND,'%d.%m.%Y'),".
			      "PLZ,ORT,TEL,STRASSE,ANZ_KINDER,ENTFERNUNG, ".
			      "KRANKENVERSICHERUNGSNUMMER,".
			      "KRANKENVERSICHERUNGSNUMMER_GUELTIG,".
			      "VERSICHERTENSTATUS,".
			      "IK,".
			      "NAECHSTE_HEBAMME,".
			      "BEGRUENDUNG_NICHT_NAECHSTE_HEBAMME, ".
			      "KZETGT, ".
			      "TIME_FORMAT(GEBURTSZEIT_KIND,'%H:%i') ".
			      "from Stammdaten where ".
			      "ID = $id;")
    or die $dbh->errstr();
  $frau_id->execute() or die $dbh->errstr();
  my @erg = $frau_id->fetchrow_array();
  for (my $i=0;$i < 16;$i++) {
    if (!defined($erg[$i])) {
      $erg[$i]='';
    }
  }
  return @erg;
}

sub stammdaten_next_id {
  # holt zur gegebenen Frau die nächste Frau
  my $self=shift;
  my ($id) = @_;
  my $stammdaten_next_id =
    $dbh->prepare("select ID from Stammdaten where ".
		  "ID > ? limit 1;")
      or die $dbh->errstr();
  $stammdaten_next_id->execute($id) or die $dbh->errstr();
  return $stammdaten_next_id->fetchrow_array();
}

sub stammdaten_prev_id {
  # holt zur gegebenen Frau die vorhergehende Frau
  my $self=shift;
  my ($id) = @_;
  my $stammdaten_prev_id =
    $dbh->prepare("select ID from Stammdaten where ".
		  "ID < ? order by ID desc limit 1;")
      or die $dbh->errstr();
  $stammdaten_prev_id->execute($id) or die $dbh->errstr();
  return $stammdaten_prev_id->fetchrow_array();
}

sub max {
  # gibt die höchste ID zurück
  return $max_frau;
}
1;
