  function loeschen() {
  open("stammdatenerfassung.pl","_top");
  };

  function frausuchen(vorname,nachname,geb,formular) {
  // öffnet Fenster in dem eine Frau ausgewählt werden kann
  open("frauenauswahl.pl?vorname="+vorname.value+"&nachname="+nachname.value+"&geb_f="+geb.value+"&suchen=Suchen","frauenwahl","scrollbars=yes,width=700,height=400");
  };

  function datum_check(datum) {
//    alert("Eingabe"+datum);
    re=/^\d{1,2}\.\d{1,2}\.\d{1,4}$/;
    if (datum.value != '' && !re.test(datum.value)) {
      alert("Bitte Datum im Format tt.mm.jjjj erfassen");
      datum.focus();
      datum.select();
    }
  }

  function kvnr_check(kvnummer) {
  re=/^\d{10}$/;
  if (kvnummer.value != '' && !re.test(kvnummer.value)) {
    alert("Bitte KV-Nummer 10 stellig numerisch erfassen");
    kvnummer.focus();
    kvnummer.select();
  }
  }

  function plz_check(plz) {
//  alert("PLZ"+plz.value);
  re=/\d{5}/;
  if (plz.value != '' && !re.test(plz.value)) {
    alert("Bitte PLZ 5 stellig numerisch erfassen");
    plz.focus();
    plz.select();
  }
  }

  function set_focus(formular) {
  var i=formular.length;
  var y=0;
  while ( i >= 0 ) {
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
  
  function kassen_auswahl() {
  // öffnet Fenster in dem eine Krankenkasse ausgewählt werden kann
  open("kassenauswahl.pl","kassenwahl","scrollbars=yes,width=600,height=400");
  }


  function frau_eintrag(frau_id,vorname,nachname,geb_f,geb_k,plz,ort,tel,strasse,bundesland,entfernung,kranknr,kranknrguelt,verstatus,nae_heb,begr_nicht_nae_heb) {
  // übertragt Daten in die Stammdatenmaske

    // in Parent Dokument übernehmen
    // alert("parent"+opener.document.forms[0]);
    opener.document.stammdaten.frau_id.value=frau_id;
    opener.document.stammdaten.vorname.value=vorname;
    opener.document.stammdaten.nachname.value=nachname;
    opener.document.stammdaten.geburtsdatum_frau.value=geb_f;
    opener.document.stammdaten.plz.value=plz;
    opener.document.stammdaten.ort.value=ort;
    opener.document.stammdaten.strasse.value=strasse;
    opener.document.stammdaten.geburtsdatum_kind.value=geb_k;
    var bund=['NRW','Bayern','Rheinlandpfalz','Hessen'];
    for (var i=0; i<4;i++) {
       if (bund[i] == bundesland) {
         opener.document.stammdaten.bundesland.selectedIndex=i;
       }
    }
    opener.document.stammdaten.entfernung.value=entfernung;
    opener.document.stammdaten.krankenversicherungsnummer.value=kranknr;
    opener.document.stammdaten.krankenversicherungsnummer_gueltig.value=kranknrguelt;
    opener.document.stammdaten.tel.value=tel;

    for (i=0;i<opener.document.stammdaten.versichertenstatus.options.length;i++) {
       if ( opener.document.stammdaten.versichertenstatus.options[i].text == verstatus) {
         opener.document.stammdaten.versichertenstatus.selectedIndex=i;
       }
    }
    opener.document.stammdaten.naechste_hebamme.checked = false;      
    opener.document.stammdaten.nicht_naechste_heb.disabled=false;
    if (nae_heb=='j') {
      opener.document.stammdaten.naechste_hebamme.checked = true;
      opener.document.stammdaten.nicht_naechste_heb.disabled=true;
    }
    opener.document.stammdaten.nicht_naechste_heb.value=begr_nicht_nae_heb;
}
    

  function kk_eintrag(ik,name,plz,ort,strasse) {
  // übertragt Krankenkassedaten in die Stammdatenmaske

    // in Parent Dokument übernehmen
    // alert("parent"+opener.document.forms[0]);
    var formular = opener.document.stammdaten;
    formular.ik_krankenkasse.value=ik;
    formular.name_krankenkasse.value=name;
    formular.strasse_krankenkasse.value=strasse;
    formular.ort_krankenkasse.value=plz+' '+ort;

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