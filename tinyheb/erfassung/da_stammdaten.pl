#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# Daten der Datenannahmestellen erfassen, ändern, löschen

# $Id: da_stammdaten.pl,v 1.6 2008-10-05 13:54:03 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2006,2007 Thomas Baum <thomas.baum@arcor.de>
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
use Heb_leistung;
use Heb_datum;
use Heb_krankenkassen;
use Heb;

my $q = new CGI;
my $d = new Heb_datum;
our $h = new Heb;
our $k = new Heb_krankenkassen;

my $TODAY = sprintf "%4.4u-%2.2u-%2.2u",Today();
my $TODAY_tmj = $d->convert_tmj($TODAY);
my @aus = ('Anzeigen','Ändern');
my @status_ik = ('Testphase','Erprobungsphase','Echtbetrieb');
my @schl_typ = ('keine Verschlüsselung','PKCS#7');
my @sig_typ=('keine Signatur','PKCS#7');
my @da=$k->da_such();

our $ik_nummer = $q->param('ik_nummer');
$ik_nummer=$da[1] unless (defined($ik_nummer));
our $ik = $q->param('ik') || '0';
our $mail = $q->param('mail') || '';
our $dtaus = $q->param('dtaus') || '0';
our $schl = $q->param('schl') || '03';
our $sig = $q->param('sig') || '00';

my $abschicken = $q->param('abschicken');

print $q->header ( -type => "text/html", -expires => "-1d");

if (defined($abschicken)) {
  speichern();
}

hole_da_daten();

print '<head>';
print '<title>Parameter Datenannahmestellen</title>';
print '<script language="javascript" src="../Heb.js"></script>';
print '<script language="javascript" src="stammdaten.js"></script>';
print '<link href="../Heb.css" rel="stylesheet" type="text/css">';
print '</head>';


# Alle Felder zur Eingabe ausgeben
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Parameter Datenannahmestellen</h1>';
print '<hr width="90%">';
print '</div><br>';
# Formular ausgeben
print '<form name="da_stammdaten" action="da_stammdaten.pl" method="get" target=_top bgcolor=white>';
print '<table border="0" width="700" align="left">';

# Zeile IK-Nummer
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>IK-Nummer&nbsp; Name</b></td>';
print '</tr>';
print "\n";

print '<tr>';
print "<td>";
print "<select name='ik_nummer' size=1 onChange='window.location=\"da_stammdaten.pl?ik_nummer=\"+ik_nummer.value;'>";
my $j=0;
while ($j <= $#da) {
  my ($name_da)=$k->krankenkasse_sel("kname",$da[$j]);
  print "<option value='$da[$j]' ";
  print ' selected' if ($da[$j] == $ik_nummer);
  print '>';
  print "$da[$j] $name_da";
  print '</option>';
  $j++;
}
print '</td>';
print "</tr>";
print '</table>';
print "\n";

# Informationen zur Datenannahmestelle generieren
my $text='';
my $empf_phys=$k->krankenkasse_empf_phys($ik_nummer);
my ($name_phys)=$k->krankenkasse_sel("KNAME",$empf_phys);
if ($empf_phys != $ik_nummer) {
  $text="E-Mails werden über physikalischen Empfänger $name_phys verschickt.";
  $text.=" Im Feld E-Mail bitte E-Mail Adresse der Annahmestelle $name_phys";
  $text.=" angeben.";
}
my ($pubkey) = $k->krankenkasse_sel("PUBKEY",$ik_nummer);
if (!defined($pubkey) or $pubkey eq '') {
  $text .= "\n" if ($text ne '');
  $text .= "kein öffentlicher Schlüssel der Datenannahmestelle vorhanden";
  $text .= " ein elektronischer Datenaustausch ist nicht möglich";
}
if ($text ne '') {
  print "<tr>";
  print "<td><textarea name='hinweise' cols='112' rows='3' class='disabled' disabled >$text</textarea>";
  print "</td>";
  print "</tr>";
}


# Zeile Status der DA
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>Status (Testindikator)</b></td>';
print '</tr>';
print "\n";
print "<td>";
print "<select name='ik' size=1>";
$j=0;
while ($j <= $#status_ik) {
  print "<option value='$j' ";
  print ' selected' if ($j == $ik);
  print '>';
  print $status_ik[$j];
  print '</option>';
  $j++;
}
print '</td>';
print "</tr>";
print '</table>';
print "\n";


# E-Mail
print '<tr><td><table border="0" align="left">';
print '<tr><td><b>E-Mail</b></td></tr>';
print '</tr>';
print '<tr>';
print "<td><input type='text' name='mail' value='$mail' size='80'></td>";
print "</tr>";
print '</table>';
print "\n";




# Verschlüsselung und Signatur
print '<tr><td><table border="0" align="left">';
print '<tr>';
print '<td><b>Verschlüsselung:</b></td>';
print '<td><b>Signatur</b></td>';
print '</tr>';
print "\n";

print '<tr>';
print "<td>";
print "<select name='schl' size=1>";
if ($schl == 0) {
  print '<option selected value="00">keine Verschlüsselung</option>';
  print '<option value="03">PKCS#7 Verschlüsselung</option>';
} else {
  print '<option value="00">keine Verschlüsselung</option>';
  print '<option selected value="03">PKCS#7 Verschlüsselung</option>';
}
print "</td>";

print "<td>";
print "<select name='sig' size=1>";
if ($sig == 0) {
  print '<option selected value="00">keine Signatur</option>';
  print '<option value="03">PKCS#7 Signatur</option>';
} else {
  print '<option value="00">keine Signatur</option>';
  print '<option selected value="03">PKCS#7 Signatur</option>';
}
print "</td>";
print "</tr>";
print '</table>';
print "\n";


# Datenaustauschreferenz
print '<tr><td><table border="0" align="left">';
print '<tr><td><b>Datenaustauschreferenz</b></td></tr>';
print '<tr>';
print "<td><input type='text' name='dtaus' value='$dtaus' size='5' maxlength='5'></td>";
print "</tr>";
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
print "</body>";
print "</html>";

sub speichern {
  # Speichert die Daten in der Stammdaten Datenbank
  # print "Speichern in DB\n";
  # Datümer konvertierten
  $sig = sprintf "%2.2u",$sig;
  $schl = sprintf "%2.2u",$schl;
  $ik = sprintf "%2.2u",$ik;
  $h->parm_up('IK'.$ik_nummer,$ik);
  $h->parm_up('MAIL'.$ik_nummer,$mail);
  $h->parm_up('SCHL'.$ik_nummer,$schl);
  $h->parm_up('SIG'.$ik_nummer,$sig);
  $h->parm_up('DTAUS'.$ik_nummer,$dtaus);
  return;
}


sub hole_da_daten {
  my ($name_da)=$k->krankenkasse_sel("kname",$ik_nummer);
  $ik=$h->parm_unique("IK".$ik_nummer);
  if(!defined($ik)) {
    $h->parm_ins("IK".$ik_nummer,'00',"Datenannahmestelle (hier $name_da) Testindikator 0=Test, 1=Erprobungsphase, 2=Produktion");
    $ik=0;
  }


  $mail=$h->parm_unique("MAIL".$ik_nummer);
  if(!defined($mail)) {
    $h->parm_ins("MAIL".$ik_nummer,'',"Mailadresse der Datenannahmestelle (hier $name_da) zwingend im Format NAME".'<mail@blab.blub.de>');
    $mail='';
  }


  $sig=$h->parm_unique("SIG".$ik_nummer);
  if(!defined($sig)) {
    $h->parm_ins("SIG".$ik_nummer,'00',"Signatur für diese Datenannahmestelle (hier $name_da) 0=keine, 2=PEM, 3=PKCS#7");
    $sig=00;
  }
  $sig = sprintf "%u",$sig;


  $schl=$h->parm_unique("SCHL".$ik_nummer);
  if(!defined($schl)) {
    $h->parm_ins("SCHL".$ik_nummer,'03',"Verschlüsselung für diese Datenannahmestelle (hier $name_da) 0=keine, 2=PEM, 3=PKCS#7");
    $schl=03;
  }
  $schl = sprintf "%u",$schl;

  $dtaus=$h->parm_unique("DTAUS".$ik_nummer);
  if(!defined($dtaus)) {
    $h->parm_ins("DTAUS".$ik_nummer,'1',"Datenaustauschreferenz für diese Datenannahmestelle (hier $name_da)");
    $dtaus=1;
  }
  return;
}

