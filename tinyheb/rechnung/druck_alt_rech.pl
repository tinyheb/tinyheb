#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# alte Rechnungen anzeigen

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

my $q = new CGI;
my $l = new Heb_leistung;

my $rech_id = $q->param('rech_id') || 0;

$l->rechnung_such("RECH,EDI_DATUM","RECHNUNGSNR=$rech_id");
my ($rech,$edi_datum)=$l->rechnung_such_next();

print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>alte Rechnung anzeigen</title>';
print '</head>';

print '<table border="0" align="left">';

print "<tr>";
print "<td><input type='button' name='pdruck' value='zurück' onclick='self.close()'</td>";
if (defined($edi_datum) && $edi_datum ne '' && $edi_datum ne '0000-00-00 00:00:00') {
  print '<td>';
  print "<select name='rechtyp' size=1 onChange='anzeige_wechsel();'>";
  print '<option selected value="1">Papier Rechnung</option>';
  print '<option value="2">elektronische Rechnung</option>';
  print "</td>\n";
}
print '</tr>';
print '</table>';
print "\n";

print "<iframe src='ps2html_alt.pl?rech_id=$rech_id' name='rechnung_alt' width='880' height='650' scrolling='auto' frameborder='1'>" if ($rech_id > 0);
print "<iframe src='../blank.html' name='rechnung_alt' width='880' height='650' scrolling='yes' frameborder='1'>" if ($rech_id == 0);
print "</iframe>";

print "<br><input type='button' name='pdruck' value='zurück' onclick='self.close()'";
print "</body>";

print <<SCRIPTE;
<script>
  function anzeige_wechsel() {
    var tag=window.document.getElementsByName("rechtyp");
//    alert("Anzeige wechsel"+tag[0]+tag[0].value);
    open("ps2html_alt.pl?rech_id=$rech_id&rechtyp="+tag[0].value,"rechnung_alt");
  }
</script>
SCRIPTE

print "</html>";


