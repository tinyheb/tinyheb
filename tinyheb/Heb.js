//alert("Heb.js wird geladen");

function kassesuchen(name,ik,formular) {
// öffnet Fenster in dem eine Krankenkasse ausgewählt werden kann
open("kassenauswahl.pl?name="+name.value+"&ik="+ik.value,"kassenwahl","scrollbars=yes,innerwidth=700,height=400");
  };

function haupt() {
  // springt von einem Untermenue ins Hauptmenue
open("../hebamme.html","_top");
}

function stamm(id,formular) {
  // springt von einem Untermenue in die Stammdatenerfassung
  if (formular.name != 'rechnungen_gen') {
    open("stammdatenerfassung.pl?func=3&frau_id="+id,"_top");
  } else {
    open("../erfassung/stammdatenerfassung.pl?func=3&frau_id="+id,"_top");
  }
}

function plz_check(plz) {
  // prüft ob die erfasste PLZ einen gültigen Wert hat
  re=/\d{5}/;
  if (plz.value != '' && !re.test(plz.value)) {
    alert("Bitte PLZ 5 stellig numerisch erfassen");
    plz.focus();
    plz.select();
  }
}


function datum_check(datum) {
// prüft ob Datum im Format tt.mm.jjjj erfasst wurde, oder leer ist
  if (datum.value == '') { return true; }
  re=/^(\d{1,2}\.\d{1,2}\.)(\d{1,4})$/;
  var ret = re.exec(datum.value);
  //alert("datum_check"+datum);
  if (!ret) {
    alert("Bitte Datum im Format tt.mm.jjjj erfassen");
    datum.select();
    datum.focus();
    return false;
  } else {
    var j = Number (RegExp.$2);
    if (j>99 && j<1900) {
      alert("Bitte gültiges Datum erfassen");
      datum.select();
      datum.focus();
      return false;
    }
    if (j<50 && j<100) {j += 2000;}
    if (j>49 && j<100) {j += 1900;}
    datum.value=RegExp.$1+j;
  }
}


function uhrzeit_check(uhrzeit) {
  if (uhrzeit.value != '') {
    //   alert ("uhrzeit"+uhrzeit.value);
    // prüft ob Uhrzeit im Format hh:mm oder hhmm erfasst wurde, oder leer ist
    re=/^(\d{1,2}):(\d{1,2})$/;
      if (re.test(uhrzeit.value) && (RegExp.$1 < 24 && RegExp.$2 < 60)) {
	return true;
      } else {
	//	alert("noch nicht korrekt 2");
	re2=/(\d{1,2})(\d{2})$/;
	if (re2.test(uhrzeit.value) && RegExp.$1 < 24 && RegExp.$2 < 60) {
	  uhrzeit.value=RegExp.$1+':'+RegExp.$2;
	  return true;
	} else {
	  alert("Bitte gültige Uhrzeit im Format hh:mm erfassen");
	  uhrzeit.focus();
	  uhrzeit.select();
	  return false;
	}
      }
  }
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
		//var tag=window.document.getElementsByName("abschicken");	
		//tag[0].style.visibility="hidden";
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
