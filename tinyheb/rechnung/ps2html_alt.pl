#!/usr/bin/perl -wT
# -wT

# Ausgabe von alten Rechnungen, entweder Postscript Format oder Edifact
# wird ausgegeben

# Copyright (C) 2005,2006 Thomas Baum <thomas.baum@arcor.de>
# Thomas Baum, Rubensstr. 3, 42719 Solingen, Germany

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

use lib "../";
use Heb_leistung;

my $l = new Heb_leistung;
my $q = new CGI;


#print "Content-Type: application/postscript\n";
my $rech_id = $q->param('rech_id') || -1;
my $rechtyp = $q->param('rechtyp') || 1;

$l->rechnung_such("RECH,EDI_AUFTRAG,EDI_NUTZ","RECHNUNGSNR=$rech_id");
my ($rech,$edi_auf,$edi_nutz)=$l->rechnung_such_next();

if ($rechtyp == 1) {
  print $q->header ( -type => "application/postscript", -expires => "-1d");
  print $rech;
}
if ($rechtyp == 2) {
  print $q->header ( -type => "text/html", -expires => "-1d");
  print '<head>';
  print '</head>';
  print '<body bgcolor=white>';
  print '<table border="0" width="700" align="left">';
  print '<tr><td><b>Auftragsdatei</b></td></tr>';
  print "<tr><td><textarea name='aufdatei' cols='120' rows='2'>$edi_auf</textarea></td></tr>";
  print '<tr><td><b>Nutzdatendatei</b></td></tr>';
  print "<tr><td><textarea name='nutzdatei' cols='120' rows='37'>$edi_nutz</textarea></td></tr>";
  print '</table>';
  print "</body>";
  print "</html>";
}
