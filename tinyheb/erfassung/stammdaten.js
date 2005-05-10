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


  function frau_eintrag(frau_id,vorname,nachname,geb_f,geb_k,plz,ort,tel,strasse,bundesland,entfernung,kranknr,kranknrguelt,verstatus,nae_heb,begr_nicht_nae_heb) {
  // übertragt Daten in die Stammdatenmaske

    // in Parent Dokument übernehmen
    formular = opener.document.forms[0];
    //alert("frau"+formular.name);
    formular.frau_id.value=frau_id;
    formular.vorname.value=vorname;
    formular.nachname.value=nachname;
    formular.geburtsdatum_frau.value=geb_f;
    formular.geburtsdatum_kind.value=geb_k;
    if (formular.name == 'rechnungen_gen') {
      // postscript rechnung neu laden
      open("../rechnung/ps2html.pl?frau_id="+frau_id,"rechnung");
      return true;
    }
    if(formular.name == 'rechnung') {
      open("rechpos.pl?frau_id="+frau_id,"rechpos");
      return true;
    } else {
      formular.plz.value=plz;
      formular.ort.value=ort;
      formular.strasse.value=strasse;
      
      var bund=['NRW','Bayern','Rheinlandpfalz','Hessen'];
      for (var i=0; i<4;i++) {
	if (bund[i] == bundesland) {
	  formular.bundesland.selectedIndex=i;
	}
      }
      formular.entfernung.value=entfernung;
      formular.krankenversicherungsnummer.value=kranknr;
      formular.krankenversicherungsnummer_gueltig.value=kranknrguelt;
      formular.tel.value=tel;
      
      for (i=0;i<formular.versichertenstatus.options.length;i++) {
	if ( formular.versichertenstatus.options[i].text == verstatus) {
	  formular.versichertenstatus.selectedIndex=i;
	}
      }
      formular.naechste_hebamme.checked = false;      
      formular.nicht_naechste_heb.disabled=false;
      if (nae_heb=='j') {
	formular.naechste_hebamme.checked = true;
	formular.nicht_naechste_heb.disabled=true;
      }
      formular.nicht_naechste_heb.value=begr_nicht_nae_heb;
    }
  }
    

function check_begr(wert,formular) {
// ändert im übergebenen Formular ob Begründung erfasst werden kann oder nicht
	// alert("check_begr"+wert.checked);
	formular.nicht_naechste_heb.disabled=wert.checked;

}

function next_satz(formular) {
	var id = 0;
	id = new Number(formular.frau_id.value);	
	id++;
//	alert("naechster Satz"+formular+id);
	if (formular.auswahl.value == 'Anzeigen') {
		open("stammdatenerfassung.pl?func=1&frau_id="+id,"_top");
	} else {
		alert("Bitte Menuepunkt Anzeigen wählen");
	}
}

function prev_satz(formular) {
	var id = 0;
	id = new Number(formular.frau_id.value);	
	id--;
//	alert("naechster Satz"+formular+id);
	if (formular.auswahl.value == 'Anzeigen') {
		open("stammdatenerfassung.pl?func=2&frau_id="+id,"_top");
	} else {
		alert("Bitte Menuepunkt Anzeigen wählen");
	}
}
