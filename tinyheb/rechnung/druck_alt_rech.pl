#!/usr/bin/perl -wT
#-wT
#-d:ptkdb
#-d:DProf  

# author: Thomas Baum
# 20.08.2005
# alte Rechnungen anzeigen

use strict;
use CGI;

use lib "../";

my $q = new CGI;

my $rech_id = $q->param('rech_id') || 0;

print $q->header ( -type => "text/html", -expires => "-1d");


print '<head>';
print '<title>alte Rechnung anzeigen</title>';
print '</head>';

print '<table border="0" width="700" align="left">';

print "<tr>";
print "<td><input type='button' name='pdruck' value='zurück' onclick='self.close()'</td>";
print '</tr>';
print '</table>';
print "\n";

print "<iframe src='ps2html_alt.pl?rech_id=$rech_id' name='rechnung_alt' width='880' height='800' scrolling='auto' frameborder='1'>" if ($rech_id > 0);
print "<iframe src='../blank.html' name='rechnung_alt' width='880' height='650' scrolling='yes' frameborder='1'>" if ($rech_id == 0);
print "</iframe>";

print "<br><input type='button' name='pdruck' value='zurück' onclick='self.close()'";
print "</body>";
print "</html>";


