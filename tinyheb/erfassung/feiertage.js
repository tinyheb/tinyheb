function loeschen() {
  open("feiertagserfassung.pl","_top");
};

function feiertagsuchen(name,bund,formular) {
  // öffnet Fenster in dem ein Feiertag ausgewählt werden kann
  open("feiertagauswahl.pl?name_feiertag="+name.value+"&bund_feiertag="+bund.value+"&suchen=suchen","feiertagwahl","scrollbars=yes,width=600,height=400");
};

function next_satz(formular) {
	var id = 0;
	id = new Number(formular.id_feiertag.value);	
	id++;
//	alert("naechster Satz"+formular+id);
	if (formular.auswahl.value == 'Anzeigen') {
		open("feiertagserfassung.pl?func=1&id_feiertag="+id,"_top");
	} else {
		alert("Bitte Menuepunkt Anzeigen wählen");
	}
}

function prev_satz(formular) {
	var id = 0;
	id = new Number(formular.id_feiertag.value);	
	id--;
//	alert("naechster Satz"+formular+id);
	if (formular.auswahl.value == 'Anzeigen') {
		open("feiertagserfassung.pl?func=2&id_feiertag="+id,"_top");
	} else {
		alert("Bitte Menuepunkt Anzeigen wählen");
	}
}
