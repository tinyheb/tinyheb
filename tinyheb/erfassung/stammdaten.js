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

function frausuchen(vorname,nachname,geb,formular) {
  // öffnet Fenster in dem eine Frau ausgewählt werden kann
  open("frauenauswahl.pl?vorname="+vorname.value+"&nachname="+nachname.value+"&geb_f="+geb.value+"&suchen=Suchen","frauenwahl","scrollbars=yes,width=700,height=400");
  };

function kvnr_check(kvnummer) {
  re=/^\d{10}$/;
  if (kvnummer.value != '' && !re.test(kvnummer.value)) {
    alert("Bitte KV-Nummer 10 stellig numerisch erfassen");
    kvnummer.focus();
    kvnummer.select();
  }
}

function ik_gueltig_check(ik_nummer) {
  // prüfung auf gültige ik nummer
  re =/^\d{9}$/;
  if (ik_nummer.value != '' && !re.test(ik_nummer.value)) {
    alert("Bitte IK-Nummer 9 stellig numerisch erfasseb");
    ik_nummer.focus();
    ik_nummer.select();
  }
}

function kvnr_gueltig_check(kvnr_gueltig) {
//  alert("gueltig"+kvnr_gueltig.value);
  re=/^[0-1][0-9]\d{2}$/;
  if (kvnr_gueltig.value != '' && !re.test(kvnr_gueltig.value)) {
    alert("Bitte Gültigkeit im Format mmjj erfassen");
    kvnr_gueltig.focus();
    kvnr_gueltig.select();
  }
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
