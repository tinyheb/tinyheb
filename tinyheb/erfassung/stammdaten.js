/* script für Plausiprüfungen und Navigation 
# im Rahmen der Stammdatenerfassung

# Copyright (C) 2004,2005,2006 Thomas Baum <thomas.baum@arcor.de>
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
*/

// alert('lade stammdaten.js');

function loeschen() {
  open("stammdatenerfassung.pl","_top");
};

function rechnung_erfassen(formular) {
  // öffnet Fenster in dem Rechnungspositionen erfasst werden können
  if (formular.auswahl.value == 'Anzeigen' && formular.frau_id.value > 0) {
    open("rechnungserfassung.pl?frau_id="+formular.frau_id.value,"_top");
  } else {
    alert('Bitte Menuepunkt Anzeigen und Frau wählen');
  }
}

var fenster_route;

function route_ber(formular,strasse_start,plz_start,ort_start) {
  if (!(fenster_route instanceof Window) || fenster_route.closed) {
    fenster_route=window.open("http://maps.google.de/maps?saddr="+plz_start+" "+ort_start+","+strasse_start+"&daddr="+formular.plz.value+" "+formular.ort.value+","+formular.strasse.value+"&f=d&hl=de&btnG=Route%20berechnen","route");
    fenster_route.focus();
  }
  else {
    fenster_route.location="http://maps.google.de/maps?saddr="+plz_start+" "+ort_start+","+strasse_start+"&daddr="+formular.plz.value+" "+formular.ort.value+","+formular.strasse.value+"&f=d&hl=de&btnG=Route%20berechnen";
    fenster_route.focus();
  }
}

function frausuchen(vorname,nachname,geb,formular) {
  // öffnet Fenster in dem eine Frau ausgewählt werden kann
  open("frauenauswahl.pl?vorname="+vorname.value+"&nachname="+nachname.value+"&geb_f="+geb.value+"&suchen=Suchen&sel_status=alle","frauenwahl","scrollbars=yes,width=700,height=400");
  };


function frauenauswahl(formular) {
  // plausiprüfungen bevor formular submittet wird.
   if (!datum_check(formular.geb_f)) {
    return false;
  }
  if (!datum_check(formular.geb_k)) {
    return false;
  }
  if (!plz_check(formular.plz)) {
    return false;
  }
  return true;
}


function frau_speicher(formular) {
  // plausiprüfungen bevor formular gespeichert wird.
  //  alert('check speicher anfang');
  if (!datum_check(formular.geburtsdatum_frau)) {
    return false;
  }
  if (!datum_check(formular.geburtsdatum_kind)) {
    return false;
  }
  if (!plz_check(formular.plz)) {
    return false;
  }
  if (!kvnr_check(formular.krankenversicherungsnummer)) {
    return false;
  }
  if (!kvnr_gueltig_check(formular.krankenversicherungsnummer_gueltig)) {
    return false;
  }
  if (!ik_gueltig_check(formular.ik_krankenkasse)) {
    return false;
  }
  //alert('check speicher ende');
  return true;
}

function save_heb_stammdaten(formular) {
  // plausiprüfungen für angaben zur hebamme
  if (!ik_gueltig_check(formular.ik)) {
    return false;
  }
  if (!plz_check(formular.plz)) {
    return false;
  }
  if (!numerisch_check(formular.privat_faktor)) {
    return false;
  }
  return true;
}


function kvnr_check(kvnummer) {
  re=/^\d{9,10}$/;
  if (kvnummer.value != '' && !re.test(kvnummer.value)) {
    alert("Bitte KV-Nummer 10 stellig numerisch erfassen");
    kvnummer.focus();
    kvnummer.select();
    return false;
  }
  return true;
}

function ik_gueltig_check(ik_nummer) {
  // prüfung auf gültige ik nummer
  re =/^\d{9}$/;
  if (ik_nummer.value != '' && !re.test(ik_nummer.value)) {
    // prüfen, ob 7-stellig erfasst wurde
    re =/^\d{7}$/;
    if (!re.test(ik_nummer.value)) {
      alert("Bitte IK-Nummer 9-stellig numerisch erfassen");
      ik_nummer.focus();
      ik_nummer.select();
      return false;
    } else {
      ik_nummer.value = '10'+ik_nummer.value;
      return luhn(ik_nummer.value);
    }
  }
  return luhn(ik_nummer.value);
}

function luhn (ik) {
  //alert("Übergeben "+ik);
  var text=ik.toString();
  var pruefziffer = Number(text.charAt(8));
  var laenge=text.length;
  if (laenge == 0) {
    return true;
  }
  if (laenge != 9) {
    alert("Prüfziffer konnte nicht berechnet werden.\nBitte IK-Nummer 9-stellig numerisch erfassen");
    return false;
  }
  var erg=text.substring(0,2);
  for (i=2;i<7;i+=2) {
    //    alert("Bin bei Ziffer "+text.charAt(i)+"i ist"+i);
    var zahl = Number(text.charAt(i));
    zahl *= 2;
    if(zahl > 9) {
      zahl=quersum(zahl);
    }
    erg += zahl.toString();
    erg += text.charAt(i+1);
    //    alert("zwischenergebniss :"+erg);
  }
  var quer=quersum(erg.substring(2,8));
  quer = quer % 10; // Rest berechnen
  //  alert("quersumme ergebnis:"+quer+" 9 stelle"+pruefziffer);
  if (quer != pruefziffer) {
    alert("keine gültige IK-Nummer, Prüfziffer der IK Nummer falsch");
    return false;
  } else {
    return true;
  }
}


function quersum (sum) {
  //alert("berechne quersumme für"+sum);
  var text=sum.toString();
  var laenge=text.length;
  var erg=0;
  var i=0;
  for(i=0;i<laenge;i++) {
    var zahl = Number(text.charAt(i));
    erg+=zahl;
    //    alert("quersumme zw"+erg);
  }
  //  alert("Quersumme "+erg);
  return erg;
}
    

function kvnr_gueltig_check(kvnr_gueltig) {
  //  alert("gueltig"+kvnr_gueltig.value);
  if (kvnr_gueltig.value != '') {
    re=/^([0-1][0-9])\d{2}$/;
    var ret=re.test(kvnr_gueltig.value);
    if (kvnr_gueltig.value != '' && !ret || RegExp.$1 > 12 || RegExp.$1 < 1) {
      alert("Bitte Gültigkeit im Format mmjj erfassen");
      kvnr_gueltig.focus();
      kvnr_gueltig.select();
      return false;
    }
  }
  return true;
}

  function kassen_auswahl() {
    // öffnet Fenster in dem eine Krankenkasse ausgewählt werden kann
    open("kassenauswahl.pl","kassenwahl","scrollbars=yes,width=750,height=400");
  }


  function frau_eintrag(frau_id) {
    // in Parent Dokument übernehmen
    formular = opener.document.forms[0];
    //alert("frau"+formular.name);
    if (formular.name == 'rechnungen_gen') {
      // rechnungsformular erneut laden
      opener.window.location="../rechnung/rechnung_generierung.pl?frau_id="+frau_id;
      return true;
    }
    if(formular.name == 'rechnung') {
      opener.window.location="rechnungserfassung.pl?frau_id="+frau_id;
      return true;
    } else {
      opener.window.location="stammdatenerfassung.pl?func=3&frau_id="+frau_id;
      return true;
    }
  }
    

function check_begr(wert,formular) {
// ändert im übergebenen Formular ob Begründung erfasst werden kann oder nicht
	// alert("check_begr"+wert.checked);
	formular.nicht_naechste_heb.disabled=wert.checked;

}

function next_satz(formular) {
	id = formular.frau_id.value;	
//	alert("naechster Satz"+formular+id);
	if (formular.auswahl.value == 'Anzeigen') {
		open("stammdatenerfassung.pl?func=1&frau_id="+id,"_top");
	} else {
		alert("Bitte Menuepunkt Anzeigen wählen");
	}
}

function prev_satz(formular) {
	id = formular.frau_id.value;	
//	alert("naechster Satz"+formular+id);
	if (formular.auswahl.value == 'Anzeigen') {
		open("stammdatenerfassung.pl?func=2&frau_id="+id,"_top");
	} else {
		alert("Bitte Menuepunkt Anzeigen wählen");
	}
}

//alert('stammdaten.js geladen');
