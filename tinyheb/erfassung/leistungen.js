function leistungenbearbeiten(formular) {
	// öffnet einen Frame, in dem die Leistungen erfasst werden können
	// zunächst Plausi Prüfungen durchführen
	var error='';
	var ok = true;
	if (formular.frau_id.value > 0) {
		ok = ok || true;
	} else {
		alert("Bitte Frau über Knopf Suchen auswählen");
		formular.frau_suchen.focus();
		return false;
	}
	if (formular.datum_leistung.value != '') {
		ok = ok || true;
	} else {
		alert("Bitte Datum der Leistungserbringung erfassen");
		formular.datum_leistung.focus();
		formular.datum_leistung.select();
		return false;
	}
	if (formular.uhrzeit_leistung.value != '') {
		ok = ok || true;
	} else {
		alert("Bitte Uhrzeit der Leistungserbringung erfassen");
		formular.uhrzeit_leistung.focus();
		formular.uhrzeit_leistung.select();
		return false;
	}		
	open("leistungserfassung_f2.pl","leistungserfassung_f2");
};

function wo_tag(datum) {
	// liefert den Wochentag zu dem angegebenen Datum
	// datum ist im format tt.mm.jjjj
	// 0 ist Sonntag, usw.
	var re =/(\d{1,2})\.(\d{1,2})\.(\d{1,4})/g;
	var ret = re.exec(datum);
	if (ret==null) {re.exec(datum);} // Fehler im Browser beheben
	var j = new Number(RegExp.$3);
	var m = new Number(RegExp.$2);
	var t = new Number(RegExp.$1);
	//alert("jmt"+j+m+t+datum);
	m--;
	var d = new Date(j,m,t); 
	//alert("datum"+d);
	return d.getDay();
}



