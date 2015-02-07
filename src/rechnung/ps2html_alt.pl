#!/usr/bin/perl -w
# -wT

# Ausgabe von alten Rechnungen, entweder Postscript Format oder Edifact
# wird ausgegeben

# Copyright (C) 2005 - 2013 Thomas Baum <thomas.baum@arcor.de>
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

use lib "../";
use Heb;
use Heb_leistung;
use tiny_string_helpers;

my $l = new Heb_leistung;
my $q = new CGI;
my $h = new Heb;

#print "Content-Type: application/postscript\n";
my $rech_id = $q->param('rech_id') || -1;
my $rechtyp = $q->param('rechtyp') || 1;

$l->rechnung_such("RECH,EDI_AUFTRAG,EDI_NUTZ","RECHNUNGSNR='$rech_id'");
my ($rech,$edi_auf,$edi_nutz)=$l->rechnung_such_next();

if ($rechtyp == 1) {
  if ($q->user_agent =~ /Windows/) {
    my $filename = tiny_string_helpers::string2filename("Rechnung_${rech_id}_alt.pdf");
    print $q->header ( -type => "application/pdf", -expires => "-1d", -content_disposition => "inline; filename=$filename");
    if (!(-d "/tmp/wwwrun")) {
      mkdir "/tmp" if (!(-d "/tmp"));
      mkdir "/tmp/wwwrun";
    }
    unlink('/tmp/wwwrun/file.ps');
    open AUSGABE,">/tmp/wwwrun/file.ps" or
      die "konnte Datei nicht in pdf konvertieren, Schreibfehler für file.ps\n";
    print AUSGABE $rech;
    close AUSGABE;
    if ($^O =~ /linux/) {
      system('ps2pdf /tmp/wwwrun/file.ps /tmp/wwwrun/file.pdf');
    } elsif ($^O =~ /MSWin32/) {
      unlink('/tmp/wwwrun/file.pdf');
      my $gswin=$h->suche_gswin32();
      $gswin='"'.$gswin.'"';
      system("$gswin -q -dCompatibilityLevel=1.2 -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=/tmp/wwwrun/file.pdf -c .setpdfwrite -f /tmp/wwwrun/file.ps");
    } else {
      die "kein Konvertierungsprogramm ps2pdf gefunden\n";
    }

    open AUSGABE,"/tmp/wwwrun/file.pdf" or
      die "konnte Datei nicht konvertieren in pdf\n";
    binmode AUSGABE;
    binmode STDOUT;
    while (my $zeile=<AUSGABE>) {
      print $zeile;
    }
    close AUSGABE;
  } else {
    my $filename = tiny_string_helpers::string2filename("Rechnung_${rech_id}_alt.ps");
    print $q->header ( -type => "application/postscript", -expires => "-1d", -content_disposition => "inline; filename=$filename");
    print $rech;
  }
}

if ($rechtyp == 2) {
  print $q->header ( -type => "text/html", -expires => "-1d");
  print '<head>';
  print '</head>';
  print '<body bgcolor=white>';
  print '<table border="0" width="880" align="left">';
  print '<tr><td><b>Auftragsdatei</b></td></tr>';
  print "<tr><td><textarea name='aufdatei' cols='121' rows='2'>$edi_auf</textarea></td></tr>";
  print '<tr><td><b>Nutzdatendatei</b></td></tr>';
  print "<tr><td><textarea name='nutzdatei' cols='121' rows='37'>$edi_nutz</textarea></td></tr>";
  print '</table>';
  print "</body>";
  print "</html>";
}
