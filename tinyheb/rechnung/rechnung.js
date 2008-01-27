/* script für Plausiprüfungen im Rahmen der
# Rechnungserfassung/ Generierung und Navigation

# $Id: rechnung.js,v 1.20 2008-01-27 08:59:46 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2004,2005,2006,2007 Thomas Baum <thomas.baum@arcor.de>
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


//alert("rechnung.js wird geladen");

function druck_fertig(frau_id,vorname,nachname,geb_frau,geb_kind,plz,ort,strasse,kv_nummer,kv_gueltig,versichertenstatus,name_kk,test_ind,form) {
  // schreibt Rechnung in Fenster und macht update auf Datenbank
  //alert("Drucken Frau"+frau_id+"form"+form+"kk"+name_kk+"plz"+plz);
  // zunächst harte Plausiprüfungen, nur dann wenn keine privat Rechnung

  var error_text = '';

  if (versichertenstatus != 'privat' && versichertenstatus != 'SOZ') {
    if (name_kk == '') {
      alert("Es wurde keine gültige Krankenkasse erfasst,\nes kann keine Rechnung produziert werden.\nRechnung wurde nicht gespeichert.");
      return false;
    }
    if (vorname == '') {
      alert("Vorname Frau  wurde nicht erfasst\nes kann keine Rechnung produziert werden. \nRechnung wurde nicht gespeichert.");
      return false;
    }
    if (nachname == '') {
      alert("Nachname Frau  wurde nicht erfasst\nes kann keine Rechnung produziert werden. \nRechnung wurde nicht gespeichert.");
      return false;
    }
    if (geb_frau == '00.00.0000' || geb_frau == '') {
      alert("Geburtsdatum Frau  wurde nicht erfasst\nes kann keine Rechnung produziert werden. \nRechnung wurde nicht gespeichert.");
      return false;
    }
    if (geb_kind == '00.00.0000' || geb_kind == '') {
      alert("Geburtsdatum Kind wurde nicht erfasst\nes kann keine Rechnung produziert werden. \nRechnung wurde nicht gespeichert.");
      return false;
    }
    if (kv_nummer == 0 || kv_nummer == '') {
      alert("Krankenversicherungsnummer wurde nicht erfasst\nes kann keine Rechnung produziert werden.\nRechnung wurde nicht gespeichert");
      return false;
    }
    if (versichertenstatus == 0 || versichertenstatus == '') {
      alert("Versichertenstatus wurde nicht erfasst\nes kann keine Rechnung produziert werden.\nRechnung wurde nicht gespeichert");
      return false;
    }
    if (kv_gueltig == 0 || kv_gueltig == '') {
      error_text=error_text+"Gültigkeitsdatum Krankenversicherungsnummer wurde nicht erfasst\n";
    }
  }

  if (versichertenstatus == 'privat' && name_kk != '') {
    alert("Privat versichert und IK-Nummer Krankenkasse angegeben\nRechnung wird nicht produziert\nBitte Stammdaten korrigieren\nRechnung wurde nicht gespeichert");
    return false;
  }

  // weiche Plausiprüfungen

  if (plz == 0 || plz == '') {
    error_text=error_text+"PLZ wurde nicht erfasst\n";
  }
  if (ort == '') {
    error_text=error_text+"Ort wurde nicht erfasst\n";
  }
  if (strasse == '') {
    error_text=error_text+"Strasse wurde nicht erfasst\n";
  }

  // prüfen liegen Fehler vor
  if (error_text != '') {
    var erg = confirm("Stammdatenerfassung nicht komplett\n"+error_text+"trotzdem fortfahren?");
    if (!erg) {
      return false;
    }
  }
  
  if (frau_id > 0) {
    open("ps2html.pl?frau_id="+frau_id+"&speichern=save","rechnung");
    // Knopf entgültig Drucken auf disabled stellen
    form.pdruck.disabled=true;
    var text ='';
    if (test_ind == -1 || test_ind == 0) {
      text="Rechnung wurde gespeichert\nBitte Rechnung über 'Print All' drucken";
    }
    if (test_ind == 1) {
      text="Rechnung wurde gespeichert\nBitte Rechnung über 'Print All' drucken\nund sowohl per Post wie auch E-Mail verschicken";
    }
    if (test_ind == 2) {
      text="Rechnung wurde gespeichert\nBei Bedarf Begleitzettel drucken\nRechnung per E-Mail verschicken";
    }
    alert(text);
  } else {
    alert("Bitte zunächst Frau auswählen");
  }
};

function mahn_fertig(frau_id,rechnr,form) {
  form.pdruck.disabled=true;
  open("mahnung.pl?frau_id="+frau_id+"&speichern=save&rechnr="+rechnr,"mahnung");
}

function mahn_gen (rechnr) {
  // springt in Maske Mahnungsgenerierung
  //alert("hier mahnung");
  if (rechnr.value != '') {
    //    opener.opener.window.location="mahnung_generierung.pl?rechnr="+rechnr.value;
    open("mahnung_generierung.pl?rechnr="+rechnr.value,"_top");
  } else {
    alert("Bitte vorher Rechnung zur Bearbeitung auswählen");
    return false;
  }
}

function bearb_rech(rechnr,status) {
  // Bearbeitungsmaske Rechnung mit Daten füllen
  if (status < 30) {
    open("rechposbear.pl?rechnungsnr="+rechnr,"rechposbear");
  } else {
    alert("Rechnung ist schon gezahlt oder Storniert, keine weitere Bearbeitung");
  }
}

function recherf(frau_id) {
  // springt in Maske zur Rechnungserfassung
  open("../erfassung/rechnungserfassung.pl?frau_id="+frau_id,"_top");
}

function anseh_rech(rech_id,status) {
  // neues Fenster mit Rechnung öffnen
  if (rech_id > 0) {
    if (status == 80) {
      alert("Achtung diese Rechnung wurde Storniert");
    }
    open("druck_alt_rech.pl?rech_id="+rech_id,"rech_alt","scrollbars=yes,width=950,heigth=1100,resizable=yes");
  } else {
    alert("Bitte Rechnung anwählen");
  }
}

function save_rechposbear(form) {
  // prüft, ob der gezahlte Betrag kleiner oder größer als der
  // ursprüngliche Rechnungsbetrag ist, wenn ja, Abfrage
  // ob trotzdem gespeichert werden soll
  var rbetrag_gez=form.r_betraggez.value;
  var betrag=form.betrag.value;
  var betrag_gez=form.betraggez.value;

  if(form.status.value >= 30) {
    alert("Rechnungs ist schon erledigt oder Storniert, es wurde nichts gespeichert");
    return false;
  }

  //  alert("datum:"+form.zahl_datum.value);
  if(!datum_check(form.zahl_datum)) {
    return false;
  }
  if (!numerisch_check(form.betraggez)) {
    return false;
  }
  if (betrag_gez == '' || form.rechnungsnr.value == '') {
    return true;
  }

  betrag_gez=tonumber(betrag_gez);
  betrag=tonumber(betrag);
  rbetrag_gez=tonumber(rbetrag_gez);
  var summe=betrag_gez+rbetrag_gez;
  //alert("Werte: "+rbetrag_gez+" "+betrag+" "+betrag_gez+"summe:"+summe);
  summe = summe * 100;
  summe = Math.round(summe);
  summe =summe / 100;
  //alert("gerundet:"+summe);
  if (summe > betrag) {
    var erg=confirm("gezahlter Betrag ist größer als Rechnungsbetrag,\ntrotzdem speichern?");
    if (!erg) {
      return false;
    } else {
      form.ignore.value=1;
      return true;
    }
  }
  if (summe < betrag) {
    var erg=prompt("gezahlter Betrag ist kleiner als Rechnungsbetrag,\ntrotzdem auf erledigt setzten (ja/nein)?","nein");
    if (!erg) {
      return false;
    } else {
      if (erg == 'ja' || erg == 'JA') {
	form.ignore.value=1;
	return true;
      } else {
	form.ignore.value=0;
	return true;
      }
    }
  }
  //  alert("speicher Ende");
  return true;
}

function tonumber(wert) {
  //  alert ("tonumber:"+wert);
  re=/^(\d{0,5}),{0,1}(\d{0,2})$/;
  var retnum=re.test(wert);
  var vk=RegExp.$1;
  var nk=RegExp.$2;
  if (!retnum) {
    //    alert("hat nicht gematched");
    vk=0;
    nk=0;
  }
  //  alert ("Ergebnis vk:"+vk+"nk:"+nk);
  if (nk=='') {
    nk=0;
  }
  var ergebnis=Number(vk+"."+nk);
  return ergebnis;
}

//alert("rechnung.js ist geladen");
