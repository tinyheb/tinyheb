  function loeschen() {
  open("krankenkassenerfassung.pl","_top");
  };

  function kassesuchen(name,ik,formular) {
  // öffnet Fenster in dem eine Krankenkasse ausgewählt werden kann
  open("kassenauswahl.pl?name="+name.value+"&ik="+ik.value,"kassenwahl","scrollbars=yes,width=600,height=400");
  };

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
  
function next_satz(formular) {
	var id = 0;
	id = new Number(formular.krank_id.value);	
	id++;
//	alert("naechster Satz"+formular+id);
	if (formular.auswahl.value == 'Anzeigen') {
		open("krankenkassenerfassung.pl?func=1&krank_id="+id,"_top");
	} else {
		alert("Bitte Menuepunkt Anzeigen wählen");
	}
}

function prev_satz(formular) {
	var id = 0;
	id = new Number(formular.krank_id.value);	
	id--;
//	alert("naechster Satz"+formular+id);
	if (formular.auswahl.value == 'Anzeigen') {
		open("krankenkassenerfassung.pl?func=2&krank_id="+id,"_top");
	} else {
		alert("Bitte Menuepunkt Anzeigen wählen");
	}
}


function auswahl_wechsel (formular) {
	var wert=formular.auswahl.value;
	//alert("auswahl wechsel"+wert);
	switch (wert) {
	case 'Neu': {
		//alert("neu");
		formular.vorheriger.disabled=true;
		formular.naechster.disabled=true;
		formular.reset.disabled=false;
		formular.speichern.disabled=false;
		formular.speichern.value='Speichern';
		break;
		}
	case 'Ändern': {
		alert("ändern");
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
