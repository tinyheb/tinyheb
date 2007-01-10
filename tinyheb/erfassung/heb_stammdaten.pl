#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Stammdaten der Hebamme erfassen, ändern, löschen

# Copyright (C) 2006, 2007 Thomas Baum <thomas.baum@arcor.de>
# Thomas Baum, 42719 Solingen, Germany

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# any later version.

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
use Heb_leistung;
use Heb_datum;

my $q = new CGI;
my $d = new Heb_datum;
my $h = new Heb;

my $debug=1;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();
my $TODAY_tmj = $d->convert_tmj($TODAY);
my @aus = ('Anzeigen','Ändern');
my @bund = $d->bundeslaender;
my %tarifkz =('00' => 'bundeseinheitlicher Tarif',
	       '24' => 'West Tarif',
	       '25' => 'Ost Tarif');

my $hint = '';

my $stnr = $q->param('stnr') || '';
my $vorname = $q->param('vorname') || '';
my $nachname = $q->param('nachname') || '';
my $strasse = $q->param('strasse') || '';
my $plz = $q->param('plz') || '';
my $ort = $q->param('ort') || '';
my $ik = $q->param('ik') || '';
my $konto = $q->param('konto') || '';
my $blz = $q->param('blz') || '';
my $namebank = $q->param('namebank') || '';
my $tel = $q->param('tel') || '';
my $email = $q->param('email') || '';
my $bundesland = $q->param('bundesland') || 'NRW';
my $tarifkz = $q->param('tarifkz') || '00';
my $privat_faktor = $q->param('privat_faktor') || '1.8';

my $speichern = $q->param('Speichern');
my $abschicken = $q->param('abschicken');

print $q->header ( -type => "text/html", -expires => "-1d");

if (defined($abschicken)) {
  speichern();
}
hole_heb_daten();

print '<head>';
print '<title>Angaben zur Hebamme</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="stammdaten.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';


# Alle Felder zur Eingabe ausgeben
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Angaben zur Hebamme</h1>';
print '<hr width="90%">';
print '</div><br>';
# Formular ausgeben
print '<form name="heb_stammdaten" action="heb_stammdaten.pl" method="get" target=_top onSubmit="return save_heb_stammdaten(this);" bgcolor=white>';
print '<table border="0" width="700" align="left">';

# Zeile Vorname, Nachname, IK
# z1 s1
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>Vorname</b></td>';
print '<td><b>Nachname</b></td>';
print '</tr>';
print "\n";

# z2 s1
print '<tr>';
print "<td><input type='text' name='vorname' value='$vorname' size='40'></td>";
print "<td><input type='text' name='nachname' value='$nachname' size='40'></td>";
print "</tr>";
print '</table>';
print "\n";

# Anschrift
print '<tr><td><table border="0" align="left">';
print '<tr><td>&nbsp;</td></tr>';
print '<tr><td><b>Anschrift</b></td></tr>';
print '<tr>';
print '<td><b>PLZ:</b></td>';
print '<td><b>Ort:</b></td>';
print '<td><b>Strasse:</b></td>';
print '</tr>';
print '<tr>';
print "<td><input type='text' name='plz' value='$plz' size='5' maxlength='5' onChange='plz_check(this)'></td>";
print "<td><input type='text' name='ort' value='$ort' size='40'></td>";
print "<td><input type='text' name='strasse' value='$strasse' size='40'></td>";
print "</tr>";
print '</table>';
print "\n";




# E-Mail
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>Tel.:</b></td>';
print '<td><b>E-Mail Adresse</b></td>';
print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' name='tel' value='$tel' size='20'></td>";
print "<td><input type='text' name='email' value='$email' size='40'></td>";
print "</tr>";
print '</table>';
print "\n";


# Anschrift Bundesland und Tarifkennzeichen und Privat Faktor
print '<tr><td><table border="0" align="left">';
print '<tr><td>&nbsp;</td></tr>';
print '<tr><td colspan=3><b>Tarif- und Abrechnungs- relevante Angaben</b></td></tr>';
print '<tr>';
print '<td><b>IK-Nummer</b></td>';
print '<td><b>Steuernummer</b></td>';
print '<td><b>Bundesland:</b></td>';
print '<td><b>Tarifkennzeichen:</b></td>';
print '<td><b>privat Faktor:</b></td>';
print '</tr>';
print '<tr>';
print "<td><input type='text' name='ik' value='$ik' size='10' maxlength='9' onChange='ik_gueltig_check(this)'></td>";
print "<td><input type='text' name='stnr' value='$stnr' size=14'></td>";
print "<td>";
print "<select name='bundesland' size=1>";
my $j=0;
while ($j <= $#bund) {
  print '<option';
  print ' selected' if ($bund[$j] eq $bundesland);
  print '>';
  print $bund[$j];
  print '</option>';
  $j++;
}
print '</td>';
print '<td>';
print "<select name='tarifkz' size=1>";
foreach my $key (sort keys %tarifkz) {
  print "<option value='$key' ";
  print ' selected' if ($key eq $tarifkz);
  print '>';
  print $tarifkz{$key};
  print "</option>\n";
}
print '</td>';
print "<td><input type='text' name='privat_faktor' value='$privat_faktor' size='9' onChange='numerisch_check(this)'></td>";
print "</tr>";
print '</table>';
print "\n";


# Zeile Bankeverbindung
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr><td>&nbsp;</td></tr>';
print '<tr><td><b>Bankverbindung</b></td></tr>';
print '<tr>';
print '<td><b>Konto:</b></td>';
print '<td><b>BLZ:</b></td>';
print '<td><b>Name Bank:</b></td>';
print '</tr>';

# Eingabe Felder
print "<tr>";
print "<td><input type='text' name='konto' value='$konto' size='12'></td>";
print "<td><input type='text' name='blz' value='$blz' size='9'></td>";
print "<td><input type='text' name='namebank' value='$namebank' size='40'></td>";
print '</tr>';
print '</table>';
print "\n";

# leere Zeile
print '<tr><td>&nbsp;</td></tr>';
print "\n";

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';

print '<td><input type="submit" name="abschicken" value="Speichern"></td>';
print '<td><input type="button" name="hauptmenue" value="Hauptmenue" onClick="haupt();"></td>';

print '</tr>';
print '</table>';
print '</form>';
print '</tr>';
print '</table>';
print <<SCRIPTE;
<script>
</script>
SCRIPTE
print "</body>";
print "</html>";

sub speichern {
  # Speichert die Daten in der Stammdaten Datenbank
  # print "Speichern in DB\n";
  # Datümer konvertierten
  $h->parm_up('HEB_STNR',$stnr);
  $h->parm_up('HEB_VORNAME',$vorname);
  $h->parm_up('HEB_NACHNAME',$nachname);
  $h->parm_up('HEB_STRASSE',$strasse);
  $h->parm_up('HEB_ORT',$ort);
  $h->parm_up('HEB_PLZ',$plz);
  $h->parm_up('HEB_IK',$ik);
  $h->parm_up('HEB_KONTO',$konto);
  $h->parm_up('HEB_BLZ',$blz);
  $h->parm_up('HEB_NAMEBANK',$namebank);
  $h->parm_up('HEB_TEL',$tel);
  $h->parm_up('HEB_EMAIL',$email);
  $h->parm_up('HEB_BUNDESLAND',$bundesland);
  $h->parm_up('HEB_TARIFKZ',$tarifkz); 
  $privat_faktor =~ s/,/\./g;
  $h->parm_up('PRIVAT_FAKTOR',$privat_faktor);
  return;
}


sub hole_heb_daten {
  $stnr = $h->parm_unique('HEB_STNR');
  $vorname = $h->parm_unique('HEB_VORNAME');
  $nachname = $h->parm_unique('HEB_NACHNAME');
  $strasse = $h->parm_unique('HEB_STRASSE');
  $ort = $h->parm_unique('HEB_ORT');
  $plz = $h->parm_unique('HEB_PLZ');
  $ik = $h->parm_unique('HEB_IK');
  $konto = $h->parm_unique('HEB_KONTO');
  $blz = $h->parm_unique('HEB_BLZ');
  $namebank = $h->parm_unique('HEB_NAMEBANK');
  $tel = $h->parm_unique('HEB_TEL');
  $email = $h->parm_unique('HEB_EMAIL');
  
$bundesland = $h->parm_unique('HEB_BUNDESLAND');
  $h->parm_ins('HEB_BUNDESLAND','NRW','Bundesland aus dem die Hebamme kommt') if(!defined($bundesland));
  $bundesland = $h->parm_unique('HEB_BUNDESLAND');

  $tarifkz = $h->parm_unique('HEB_TARIFKZ');
  $privat_faktor = $h->parm_unique('PRIVAT_FAKTOR');
  $privat_faktor =~ s/\./,/g;

  return;
}

