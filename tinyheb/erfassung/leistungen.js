/* script für Plausiprüfungen und Navigation 
# im Rahmen der Leistungserfassung

# $Id: leistungen.js,v 1.12 2008-02-12 18:35:42 thomas_baum Exp $
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
*/

//alert("leistung.js wird geladen");


function dia(form) {
  var begruendung = form.begruendung.value;
  //  alert("DIA"+begruendung);
  if (begruendung == 'Attest (auf ärztliche Anordnung)') {
    //   alert("Attest");
    // jetzt neues Feld aufnehmen
    var ueberschrift=document.createElement("TR");
    ueberschrift.id='dia_felder';
    //  alert("überschrift-Id"+ueberschrift.id);
    var tab=document.getElementById("haupt_tab");
    var km_node=document.getElementById("zeile3_tab");
    tab.insertBefore(ueberschrift,km_node);
    ueberschrift.innerHTML="<td><table><tr><td colspan='2'><b>Diagnose Angaben</b></td></tr><tr><td><b>Schlüssel</b></td><td><b>Text</b></td></tr><tr><td><input type='text' name='dia_schl' size='12' maxlength='12'></td><td><input type='text' name='dia_text' size='80' maxlength='70'></td></tr></table></td>";
  } else {
    // Felder müssen entfernt werden, falls vorhanden
    var tab=document.getElementById("haupt_tab");
    var ueberschrift=document.getElementById("dia_felder");
    // alert("ueberschrift"+ueberschrift);
    // überschrift nur entfernen, wenn vorhanden
    if (ueberschrift != null) {
      tab.removeChild(ueberschrift);
    }
  }
}



function leistartsuchen (posnr) {
  open("leistungsartauswahl.pl?suchen=Suchen&posnr="+posnr,"leistungsartauswahl","scrollbars=yes,width=700,height=400");
}


function druck (form) {
  //  alert("druck"+form.frau_id.value);
  if (form.frau_id.value > 0) {
    open("../rechnung/rechnung_generierung.pl?frau_id="+form.frau_id.value,"_top");
  } else {
    alert ("Bitte erst Frau auswählen");
  }
}

function aend (fr_id,ls_id,status) {
  // Leistungsposition zum ändern aufrufen
  //  alert("Hallo aendern"+fr_id+"leist_id"+ls_id);
  if (status == 10) {
    open("rechpos.pl?frau_id="+fr_id+"&leist_id="+ls_id+"&func=2","rechpos");
  } else {
    alert("Rechnung wurde gespeichert, ändern nicht möglich");
  }
}
//alert("nach function aendern");

function loe_leistdat (fr_id,ls_id,status) {
  // leistungsposition zum Löschen aufrufen
  // alert("Hallo loeschen"+fr_id+"leist_id"+ls_id);
  if (status == 10) {
    open("rechpos.pl?frau_id="+fr_id+"&leist_id="+ls_id+"&func=3","rechpos");
  } else {
    alert("Rechnung wurde gedruckt, Löschen nicht möglich");
  }
}

function wo_tag(datum,uhrzeit,form) {
  // liefert den Wochentag zu dem angegebenen Datum und Uhrzeit
  // datum ist im format tt.mm.jjjj
  // 0 ist Sonntag, usw.
  // falls Samstag wird auf 8 gestellt, wenn vor 12:00
  
  if (uhrzeit == '') uhrzeit = '10:00';
  //alert("Hallo2 wo tag"+datum+uhrzeit+form);
  var re =/(\d{1,2})\.(\d{1,2})\.(\d{1,4})/g;
  var re_uhr =/(\d{1,2}):(\d{1,2})/g;
  var ret = re.exec(datum);
  if (ret==null) {re.exec(datum);} // Fehler im Browser beheben
  var j = new Number(RegExp.$3);
  var m = new Number(RegExp.$2);
  var t = new Number(RegExp.$1);
  ret = re_uhr.exec(uhrzeit);
  if (ret==null) {re_uhr.exec(uhrzeit);}
  var h = new Number(RegExp.$1);
  //alert("h"+h);
  m--;
  var d = new Date(j,m,t); 
  var wtag = '';
  if (d.getDay()==0) {wtag = 'Sonntag'};
  if (d.getDay()==1) {wtag = 'Montag'};
  if (d.getDay()==2) {wtag = 'Dienstag'};
  if (d.getDay()==3) {wtag = 'Mittwoch'};
  if (d.getDay()==4) {wtag = 'Donnerstag'};
  if (d.getDay()==5) {wtag = 'Freitag'};
  if (d.getDay()==6 && h < 12) {wtag = 'Samstag vor 12:00'};
  if (d.getDay()==6 && h >= 12) {wtag = 'Samstag nach 12:00'};
  form.wotag.value = wtag;
  //alert("datum"+d);
  
}

function zeit_preis(preis,zeit,mass) {
  // berechnet in Abhängigkeit der Zeit den Preis
  // datum ist im format tt.mm.jjjj
  // 0 ist Sonntag, usw.
  var re =/(\d{1,2}):(\d{1,2})/g;
    var ret = re.exec(zeit);
    if (ret==null) {re.exec(zeit);} // Fehler im Browser beheben
    var h = new Number(RegExp.$1);
    var m = new Number(RegExp.$2);
    var minuten = h*60+m;
    var rest = minuten % mass;
    var ber = minuten - rest;
    ber = ber / mass;
    ber++;
    var preis = preis * ber;
    preis = preis + 0.005; // runden
    preisre = /(\d*\.\d{2})/;
    preisre.exec(preis);
    preis = RegExp.$1;
    return preis;
}

function leistung_speicher(formular) {
  //alert("speichern");
  //  Plausiprüfungen, bevor Formular abgeschickt wird.
  if(!uhrzeit_check(formular.zeit_von)) {
    //    alert("Zeit von nicht korrekt erfasst");
    return false;
  }
  if(!uhrzeit_check(formular.zeit_bis)) {
    //    alert("Zeit bis nicht korrekt erfasst");
    return false;
  }
  if(!datum_check(formular.datum)) {
    //    alert("Datum nicht korrekt erfasst");
    return false;
  }
  if(!numerisch_check(formular.entfernung_tag)) {
    //  alert ("numeric prüfung");
    return false;
  }
  if(!numerisch_check(formular.entfernung_nacht)) {
    //  alert ("numeric prüfung");
    return false;
  }
  return true;
}

function round(wert) {
  // rundet den angegebenen Wert kaufmännisch
  // und liefert den Wert mit 2 NK stellen zurück
  wert+=0.005;
  wertre = /(\d*\.\d{2})/;
  wertre.exec(wert);
  return RegExp.$1;
}


function next_satz_leistart(formular) {
  //  alert("next"+formular.leist_id);
  id = formular.leist_id.value;
  if(formular.auswahl.value == 'Anzeigen') {
    open("leistungsarterfassung.pl?func=1&leist_id="+id,"_top");
  } else {
    alert("Bitte Menuepunkt Anzeigen wählen");
  }
}


function prev_satz_leistart(formular) {
  id = formular.leist_id.value;
  if(formular.auswahl.value == 'Anzeigen') {
    open("leistungsarterfassung.pl?func=2&leist_id="+id,"_top");
  } else {
    alert("Bitte Menuepunkt Anzeigen wählen");
  }
}

//alert("leistungen.js ist geladen");
