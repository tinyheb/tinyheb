/* script für generelle Plausiprüfungen und Navigation
# im Rahmen der Leistungserfassung

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


//alert("Heb.js wird geladen");

function haupt() {
  // springt von einem Untermenue ins Hauptmenue
open("../hebamme.html","_top");
}

function stamm(id,formular) {
  // springt von einem Untermenue in die Stammdatenerfassung
  if (formular.name != 'rechnungen_gen' && formular.name != 'rechposbear' &&
      formular.name != 'mahnung_gen') {
    open("stammdatenerfassung.pl?func=3&frau_id="+id,"_top");
  } else {
    open("../erfassung/stammdatenerfassung.pl?func=3&frau_id="+id,"_top");
  }
}

function plz_check(plz) {
  // prüft ob die erfasste PLZ einen gültigen Wert hat
  re=/^\d{5}$/;
  if (plz.value != '' && !re.test(plz.value)) {
    alert("Bitte PLZ 5 stellig numerisch erfassen");
    plz.focus();
    plz.select();
    return false;
  }
  return true;
}

function numerisch_check(num) {
  // prüft ob der übergebene Wert numerisch oder leer ist.
  if (num.value == '') { return true; }
  re=/^\d{0,5},{0,1}\d{0,2}$/;
  if (num.value != '' && !re.test(num.value)) {
    alert("Bitte numerischen Wert erfassen");
    num.focus();
    num.select();
    return false;
  }
  return true;
}


function datum_check(datum) {
// prüft ob Datum im Format tt.mm.jjjj erfasst wurde, oder leer ist
  //  alert("datum value"+datum.value);
  if (datum.value == '') { return true; }
  re=/^(\d{1,2})[\.,](\d{1,2})[\.,](\d{1,4})$/;
  var ret = re.exec(datum.value);
  var j = Number (RegExp.$3);
  var m = Number (RegExp.$2);
  var t = Number (RegExp.$1);
  //alert("datum_check"+datum);
  if (!ret) {
    alert("Bitte Datum im Format tt.mm.jjjj erfassen");
    datum.select();
    datum.focus();
    return false;
  } else {

    if (j>99 && j<1900) {
      alert("Bitte gültiges Datum erfassen");
      datum.select();
      datum.focus();
      return false;
    }
    if (j<50 && j<100) {j += 2000;}
    if (j>49 && j<100) {j += 1900;}
    // prüfen ob Datum existiert, z.B. 31.2.05
    if (t > 31 || m > 12 ||
	m == 0 || t == 0 ||
	(m == 2 && t > 29) ||  // Februar
	(m == 2 && t > 28 && (!(j % 4)==0)) || // Februar ohne Schaltjahr
       	((m==4 || m==6 || m==9 || m==11) && t > 30) // Monate mit 30 Tagen
	) {
      alert("Bitte gültiges Datum erfassen");
      datum.select();
      datum.focus();
      return false;
    }
    datum.value=RegExp.$1+"."+RegExp.$2+"."+j;
  }
  return true;
}


function uhrzeit_check(uhrzeit) {
  if (uhrzeit.value != '') {
    //             alert ("Uhrzeit"+Event.type);
    // prüft ob Uhrzeit im Format hh:mm oder hhmm erfasst wurde, oder leer ist
    re=/^(\d{1,2}):(\d{1,2})$/;
      if (re.test(uhrzeit.value) && (RegExp.$1 < 24 && RegExp.$2 < 60)) {
	return true;
      } else {
	//	alert("noch nicht korrekt 2");
	re2=/^(\d{1,2})(\d{2})$/;
	if (re2.test(uhrzeit.value) && RegExp.$1 < 24 && RegExp.$2 < 60) {
	  uhrzeit.value=RegExp.$1+':'+RegExp.$2;
	  return true;
	} else {
	  alert("Bitte gültige Uhrzeit im Format hh:mm erfassen");
	  uhrzeit.select();
	  uhrzeit.focus();
	  return false;
	}
      }
  }
  return true;
}

function set_focus(formular) {
// setzt den Focus auf das erste Formularfeld das leer ist
var i=formular.length;
var y=1;
while ( i >= 1 ) {
	if (undefined != formular.elements[i]) {
      	if (formular.elements[i].value == '') {
           y = i;
        }
    }
  i--;
}
formular.elements[y].focus();
formular.elements[y].select();
}
  
function auswahl_wechsel (formular) {
// in Abhängigkeit der gewählten Funktion werden Knöpfe disabled/enabled
	var wert=formular.auswahl.value;
	//	alert("auswahl wechsel"+wert+formular.auswahl.value);
	switch (wert) {
	case 'Neu': {
		//alert("neu");
		formular.vorheriger.disabled=true;
		formular.naechster.disabled=true;
		formular.reset.disabled=false;
		formular.abschicken.disabled=false;
		formular.abschicken.value='Speichern';
		break;
		}
	case 'Ändern': {
		//alert("ändern");
		formular.vorheriger.disabled=true;
		formular.naechster.disabled=true;
		formular.reset.disabled=true;
		formular.abschicken.disabled=false;
		formular.abschicken.value='Speichern';
		break;
		}
	case 'Anzeigen': {
		//alert("anzeigen");
		formular.vorheriger.disabled=false;
		formular.naechster.disabled=false;
		formular.reset.disabled=true;
		formular.abschicken.disabled=true;
		break;
		}
	case 'Löschen': {
		//alert("loeschen");
		formular.vorheriger.disabled=true;
		formular.naechster.disabled=true;
		formular.reset.disabled=false;
		formular.abschicken.disabled=false;
		formular.abschicken.value='Löschen';
		break;
		}
	default: {
		alert("default");
		}
	}
}		


function kk_eintrag(name,plz,ort,strasse,ik) {
  //alert("gewählt"+name+plz+ort+strasse+ik);
    // in Parent Dokument übernehmen
    // alert("parent"+opener.window.document.forms[0].name);
    var formular=opener.window.document.forms[0];
    formular.ik_krankenkasse.value=ik;
    formular.name_krankenkasse.value=name;
    formular.strasse_krankenkasse.value=strasse;
    if (formular.name == 'krankenkassen') {
       formular.ort_krankenkasse.value = ort;
       formular.plz_krankenkasse.value = plz;
       //   formular.krank_id.value = krank_id;
    } else {
       formular.ort_krankenkasse.value=plz+' '+ort;
    }
  }
//alert("heb.js ist geladen");
