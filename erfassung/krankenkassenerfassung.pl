#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Krankenkassen erfassen, ändern, löschen

# $Id$
# Tag $Name$

# Copyright (C) 2004 - 2012 Thomas Baum <thomas.baum@arcor.de>
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
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use Date::Calc qw(Today);

use lib "../";
use Heb_krankenkassen;
use Heb_datum;

my $q = new CGI;
our $k = new Heb_krankenkassen;
my $d = new Heb_datum;

my $debug=1;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();
my @aus = ('Anzeigen','Ändern','Neu','Löschen');
#my @bund = ('NRW','Bayern','Rheinlandpfalz','Hessen');

our $name = $q->param('name_krankenkasse') || '';
our $kname = $q->param('kname_krankenkasse') || '';
our $asp_tel = $q->param('asp_tel_krankenkasse') || '';
our $asp_name = $q->param('asp_name_krankenkasse') || '';
our $strasse = $q->param('strasse_krankenkasse') || '';
our $plz_haus = $q->param('plz_haus_krankenkasse') || '';
our $plz_post = $q->param('plz_post_krankenkasse') || '';
our $ort = $q->param('ort_krankenkasse') || '';
our $ik = $q->param('ik_krankenkasse') || 0;
our $zik = $q->param('zik_krankenkasse') || '';
our $zik_typ = $q->param('zik_typ') || 0;
our $postfach = $q->param('postfach_krankenkasse') || '';
our $bemerkung = $q->param('bemerkung_krankenkasse') || '';
our $beleg_ik = $q->param('beleg_ik') || '';
our $email = $q->param('email') || '';
our $pubkey = '';

my $speichern = $q->param('Speichern');

my $auswahl = $q->param('auswahl') || 'Anzeigen';
my $abschicken = $q->param('abschicken');
our $func = $q->param('func') || 0;

hole_krank_daten() if ($func == 1 || $func == 2 || $func == 3);
if (($auswahl eq 'Ändern') && defined($abschicken)) {
  aendern();
  $auswahl = 'Anzeigen';
}
if (($auswahl eq 'Neu') && defined($abschicken)) {
  speichern();
  $auswahl = 'Anzeigen';
}

print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>Krankenkassen</title>';
print '<script language="javascript" src="krankenkassen.js"></script>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="stammdaten.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';

if (($auswahl eq 'Löschen') && defined($abschicken)) {
  loeschen();
  print '<script>window.location="krankenkassenerfassung.pl";</script>';
}

# Alle Felder zur Eingabe ausgeben
print '<body id="krankenkassen_window" bgcolor=white>';
print '<div align="center">';
print '<h1>Krankenkassen</h1>';
print '<hr width="100%">';
print '</div><br>';
# Formular ausgeben
print '<form name="krankenkassen" action="krankenkassenerfassung.pl" method="get" target=_top onsubmit="return kasse_speichern(this);" bgcolor=white>';
print '<table border="0" width="700" align="left">';

# Zeile IK, Name, KNAME
# z1 s1
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>IK</b></td>';
print '<td><b>Name</b></td>';
print '<td><b>KName</b></td>';
print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' name='ik_krankenkasse' value='$ik' size='9' onChange='ik_gueltig_check(this)'></td>";
print "<td><input type='text' name='name_krankenkasse' value='$name' size='40'></td>";
print "<td><input type='text' name='kname_krankenkasse' value='$kname' size='40'></td>";
print "<td><input type='button' name='kasse_suchen' value='Suchen' onClick='return kassesuchen();'></tr>";
print '</table>';
print "\n";

# Zeile Telefonnumer
print '<tr><td>';
print '<table border="0" align="left">';
print '<tr><td><b>Tel.:</b></td>';
print '<td><b>Ansprechpartner:</b></td></tr>';
print "<tr><td><input type='text' name='asp_tel_krankenkasse' value='$asp_tel' size='40'></td>";
print "<td><input type='text' name='asp_name_krankenkasse' value='$asp_name' size='40'></td></tr>";
print '</table>';
print "\n";

# Zeile Email
print '<tr><td>';
print '<table border="0" align="left">';
print '<tr><td><b>E-Mail:</b></td></tr>';
print "<tr><td><input type='text' name='email' value='$email' size='50'></td></tr>";
print '</table>';
print '</td></tr>';
print "\n";

# leere Zeile
print '<tr><td>&nbsp;</td></tr>';

# Zeile PLZ, Ort, Strasse für Hausanschrift
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr><td><b>Hausanschrift</b><td></tr>';
print '<tr>';
print '<td><b>PLZ</b></td>';
print '<td><b>Ort:</b></td>';
print '<td><b>Strasse:</b></td>';
print '</tr>';
# Eingabe Felder
print "<tr>";
print "<td><input type='text' name='plz_haus_krankenkasse' value='$plz_haus' size='5' onchange='return plz_check(this)'></td>";
print "<td><input type='text' name='ort_krankenkasse' value='$ort' size='40'></td>";
print "<td><input type='text' name='strasse_krankenkasse' value='$strasse' size='40'></td>";
print '</tr>';
print '</table>';
print "\n";

# Zeile PLZ, Ort, Postfach für Postanschrift
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr><td><b>Postanschrift</b><td></tr>';
print '<tr>';
print '<td><b>PLZ</b></td>';
print '<td><b>Ort:</b></td>';
print '<td><b>Postfach:</b></td>';
print '</tr>';
# Eingabe Felder
print "<tr>";
print "<td><input type='text' name='plz_post_krankenkasse' value='$plz_post' size='5' onChange='return plz_check(this)'></td>";
print "<td><input type='text' disabled class=disabled name='ort2_krankenkasse' value='$ort' size='40'></td>";
print "<td><input type='text' name='postfach_krankenkasse' value='$postfach' size='6'></td>";
print '</tr>';
print '</table>';
print "\n";

# leere Zeile
print '<tr><td>&nbsp;</td></tr>';


# Zeile der ZIK und Bemerkung
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><b>ZIK:</b></td>';
print '<td><b>ZIK Typ:</b></td>';
print '<td><b>Bemerkung:</b></td>';
print '</tr>';

# Eingabe Felder
print "<tr>";
print "<td valign='top'><input type='text' name='zik_krankenkasse' value='$zik' size='9' onChange='ik_gueltig_check(this)'></td>";
print "<td valign='top'><input type='text' name='zik_typ' value='$zik_typ' size='2' maxsize='1'></td>";
print "<td valign='bottom'><textarea name='bemerkung_krankenkasse' cols='70' rows='2'>$bemerkung</textarea></td>";
if ($zik ne '' && $zik > 0) {
  print "<td valign='top'><input type='button' name='kasse_aufrufen' value='Aufrufen' onClick='window.location=\"krankenkassenerfassung.pl?func=3&ik_krankenkasse=$zik\";'></td>";
}
print '</tr>';
print '</table>';
print "\n";


print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><b>IK für Papierbelege:</b></td>';
print '</tr>';
print "<tr>";
print "<td><input type='text' name='beleg_ik' value='$beleg_ik' size='9' onChange='ik_gueltig_check(this)'></td>";
if ($beleg_ik ne '' && $beleg_ik > 0) {
  print "<td><input type='button' name='kasse_aufrufen' value='Aufrufen' onClick='window.location=\"krankenkassenerfassung.pl?func=3&ik_krankenkasse=$beleg_ik\";'></td>";
}
print '</tr>';
print '</table>';
print "\n";




# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td colspan 3>';
print '<table border="0" align="left">';
print '<tr>';
print '<td>';
print "<select name='auswahl' size=1 onChange='auswahl_wechsel(document.krankenkassen)'>";
my $i=0;
while ($i <= $#aus) {
  print "<option value='$aus[$i]'";
  print ' selected' if ($aus[$i] eq $auswahl);
  print '>';
  print $aus[$i];
  print '</option>';
  $i++;
}
print '</select>';
print '</td>';
print '<td>';
print '<input type="button" name="reset" value="Inhalt löschen"';
print ' onClick="loeschen()">';
print '</td>';
print '<td>';
print '<input type="submit" name="abschicken" value="Speichern">';
print '</td>';
print '<td>';
print '<input type="button" name="vorheriger" value="vorheriger Datensatz" onclick="prev_satz_kasse(document.krankenkassen)">';
print '</td>';
print '<td>';
print '<input type="button" name="naechster" value="nächster Datensatz" onclick="next_satz_kasse(document.krankenkassen)">';
print '</td>';
print '<td><input type="button" name="hauptmenue" value="Hauptmenue" onClick="haupt();"></td>';
print '</tr>';
print '</table>';
print '</form>';
print '</tr>';
print '</table>';
print "<script>set_focus(document.krankenkassen);auswahl_wechsel(document.krankenkassen);</script>";
print "</body>";
print "</html>";


sub speichern {
  # Speichert die Daten in der Krankenkassen Datenbank
  $plz_post = 0 if($plz_post eq '');
  $plz_haus = 0 if($plz_haus eq '');
  $zik = 0 unless($zik);
  $beleg_ik = 0 unless($beleg_ik);
  my $erg = $k->krankenkassen_ins($ik,$kname,$name,$strasse,$plz_haus,$plz_post,$ort,$postfach,$asp_name,$asp_tel,$zik,$bemerkung,$zik_typ,$beleg_ik,$email);
  $plz_post = '' if($plz_post == 0);
  $plz_haus = '' if($plz_haus == 0);
  $zik = '' if($zik == 0);
  $beleg_ik = '' if($beleg_ik == 0);
  return $erg;
}

sub loeschen {
  # löscht Datensatz aus der Stammdaten Datenbank
  my $erg = $k->krankenkassen_delete($ik);
  return $erg;
}

sub aendern {
  # Ändert die Daten zur angegebenen Krankenkassen in der Datenbank
  $plz_post = 0 if($plz_post eq '');
  $plz_haus = 0 if($plz_haus eq '');
  $zik = 0 unless($zik);
  $beleg_ik = 0 unless($beleg_ik);
  my $erg = $k->krankenkassen_update($kname,$name,$strasse,$plz_haus,$plz_post,$ort,$postfach,$asp_name,$asp_tel,$zik,$bemerkung,$zik_typ,$beleg_ik,$email,$ik);
  $plz_post = '' if($plz_post == 0);
  $plz_haus = '' if($plz_haus == 0);
  $zik = '' if($zik == 0);
  $beleg_ik = '' if($beleg_ik == 0);
  return $erg;
}

sub hole_krank_daten {
  $name='';

  $ik = $k->krankenkasse_next_ik($ik) if ($func==1);
  $ik = $k->krankenkasse_prev_ik($ik) if ($func==2);

  ($ik,$kname,$name,$strasse,$plz_haus,$plz_post,$ort,$postfach,$asp_name,$asp_tel,$zik,$bemerkung,$pubkey,$zik_typ,$beleg_ik,$email)= $k->krankenkassen_krank_ik($ik);

  $ik = '' unless($ik);
  $kname = '' unless($kname);
  $name = '' unless($name);
  $strasse = '' unless($strasse);
  $ort = '' unless($ort);
  $postfach = '' unless($postfach);
  $asp_name = '' unless($asp_name);
  $asp_tel = '' unless($asp_tel);
  $bemerkung = '' unless($bemerkung);
  $email = '' unless($email);
  $kname =~ s/'/&#145;/g;
  $name =~ s/'/&#145;/g;
  $strasse =~ s/'/&#145;/g;
  $plz_haus = $plz_haus ? sprintf "%5.5u",$plz_haus : '';
  $plz_post = $plz_post ? sprintf "%5.5u",$plz_post : '';

  $beleg_ik='' unless ($beleg_ik);
  $zik='' unless ($zik);
  $zik_typ='' unless ($zik_typ);
  return;
}
