#!/usr/bin/perl -wT
#-w
#-d:ptkdb
#-d:DProf  

# author: Thomas Baum
# 28.02.2004
# Auswahl einer Krankenkasse

use strict;
use CGI;
use Date::Calc qw(Today);

use lib "../";
use Heb_krankenkassen;

my $q = new CGI;
my $k = new Heb_krankenkassen;

my $debug=1;

my $name = $q->param('name') || '';
my $kname = $q->param('kname') || '';
my $ort = $q->param('ort') || '';
my $plz_haus = $q->param('plz_haus') || '';
my $plz_post = $q->param('plz_post') || '';
my $ik = $q->param('ik') || '';
my $fk_krankenkasse = -1;

my $suchen = $q->param('suchen');
my $abschicken = $q->param('abschicken');

print $q->header ( -type => "text/html", -expires => "-1d");

# Alle Felder zur Eingabe ausgeben
print '<head>';
print '<title>Krankenkasse suchen</title>';
print '</head>';
print '<body bgcolor=white>';
print '<div align="center">';
print '<h1>Krankenkasse suchen</h1>';
print '<hr width="100%">';
print '</div><br>';
# Formular ausgeben
print '<form name="kasse_suchen" action="kassenauswahl.pl" method="get" target=_self>';
print '<h3>Suchkriterien:</h3>';
print '<table border="0" width="500" align="left">';

# Name, Ort, PLZ, IK, als Suchkriterien vorgeben
# z1 s1
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print "<td><b>IK</b></td>\n";
print "<td><b>Name</b></td>\n";
print "<td><b>KName</b></td>\n";
print "<td><b>Ort</b></td>\n";
print "<td><b>PLZ Hausanschrift</b></td>\n";
print "<td><b>PLZ Postfach</b></td>\n";
print '</tr>';
print "\n";

print '<tr>';
print "<td><input type='text' name='ik' value='$ik' size='10'></td>";
print "<td><input type='text' name='name' value='$name' size='20'></td>";
print "<td><input type='text' name='kname' value='$kname' size='20'></td>";
print "<td><input type='text' name='ort' value='$ort' size='20'></td>";
print "<td><input type='text' name='plz_haus' value='$plz_haus' size='7'></td>";
print "<td><input type='text' name='plz_post' value='$plz_post' size='7'></td>";
print '</table>';
print "\n";

# Zeile mit Knöpfen für unterschiedliche Funktionen
print '<tr>';
print '<td>';
print '<table border="0" align="left">';
print '<tr>';
print '<td><input type="submit" name="suchen" value="Suchen"></td>';
print '<td>';
print '<input type="button" name="zurueck" value="Zurück" onClick="self.close()"></td>';
print '</tr>';
print '</table>';

# Prüfen, ob gesucht werden soll
if (defined($suchen)) {
  # alle Kassen ausgeben, die den Kriterien entsprechen
  print '<tr>';
  print '<td>';
  print '<table border="1" align="left">';
  print '<tr>';
  print "<td><b>IK</b></td>\n";
  print "<td><b>Name</b></td>\n";
  print "<td><b>KName</b></td>\n";
  print "<td><b>PLZ Hausanschrift</b></td>\n";
  print "<td><b>PLZ Postfach</b></td>\n";
  print "<td><b>Ort</b></td>\n";
  print "<td><b>Strasse</b></td>\n";
  print '</tr>';
  $name = '%'.$name.'%';
  $kname = '%'.$kname.'%';
  $plz_haus = $plz_haus.'%';
  $plz_post = $plz_post.'%';
  $ort = '%'.$ort.'%';
  $ik = '%'.$ik.'%';
  $k->krankenkasse_such($name,$plz_haus,$ort,$ik);
  while (my ($k_ik,$k_kname,$k_name,$k_strasse,$k_plz_haus,$k_plz_post,$k_ort,$k_postfach,$k_asp_name,$k_asp_tel,$k_zik,$k_bemerkung) = $k->krankenkasse_such_next) {
    print '<tr>';
    print "<td>$k_ik</td>";
    print "<td>$k_name</td>";
    print "<td>$k_kname</td>";
    print "<td>$k_plz_haus</td>";
    print "<td>$k_plz_post</td>";
    print "<td>$k_ort</td>";
    print "<td>$k_strasse</td>";
#    print "<td>$k_postfach,$k_asp_name,$k_asp_tel,$k_zik,$k_bemerkung</td>";
    print '<td><input type="button" name="waehlen" value="Auswählen"';
    print "onclick=\"kk_eintrag('$k_ik','$k_kname','$k_name','$k_plz_haus','$k_plz_post','$k_ort','$k_strasse','$k_zik','$k_asp_tel','$k_bemerkung','$k_postfach');self.close()\"></td>";
    print "</tr>\n";
  }
}
print '</form>';
print '</tr>';
print '</table>';

print <<SCRIPTE;
<script>
  function zurueck() {
    kassenauswahl.close();
  }
  function kk_eintrag(k_ik,kname,name,plz_haus,plz_post,ort,strasse,zik,asp_tel,bemerkung,postfach) {
    // alert("gewählt"+name+plz+ort+strasse+ik);
    // in Parent Dokument übernehmen
    // alert("parent"+opener.window.document.forms[0].name);
    var formular=opener.window.document.forms[0];
    formular.ik_krankenkasse.value=k_ik;
    formular.name_krankenkasse.value=name;
    formular.strasse_krankenkasse.value=strasse;
    if (formular.name == 'krankenkassen') {
       formular.kname_krankenkasse.value=kname;
       formular.ort_krankenkasse.value = ort;
       formular.ort2_krankenkasse.value = ort;
       formular.plz_haus_krankenkasse.value = plz_haus;
       formular.plz_post_krankenkasse.value = plz_post;
       formular.zik_krankenkasse.value = zik;
       formular.asp_tel_krankenkasse.value = asp_tel;
       formular.bemerkung_krankenkasse.value = bemerkung;
       formular.postfach_krankenkasse.value = postfach;
    } else {
       formular.ort_krankenkasse.value=plz_haus+' '+ort;
    }
  }
</script>
SCRIPTE
print "</body>";
print "</html>";
