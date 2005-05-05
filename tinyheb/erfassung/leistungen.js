//alert("leistung.js wird geladen");

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
  if (formular.dauer_leistung.value != '') {
    ok = ok || true;
  } else {
    alert("Bitte Dauer der Leistungserbringung erfassen");
    formular.dauer_leistung.focus();
    formular.dauer_leistung.select();
    return false;
  }
  // wenn alles ok ist, dürfen Werte nicht mehr geändert werden
  formular.datum_leistung.disabled = true;
  var dl_tag = document.getElementsByName('datum_leistung');
  dl_tag = dl_tag[0].className='disabled';
  formular.uhrzeit_leistung.disabled = true;
  dl_tag = document.getElementsByName('uhrzeit_leistung');
  dl_tag = dl_tag[0].className='disabled';
  formular.dauer_leistung.disabled = true;
  dl_tag = document.getElementsByName('dauer_leistung');
  dl_tag = dl_tag[0].className='disabled';
  var parms=formular.gruppen_auswahl.selectedIndex;
  parms = "?gruppen_auswahl="+parms;
  parms = parms+"&datum_leistung="+formular.datum_leistung.value;
  parms = parms+"&dauer_leistung="+formular.dauer_leistung.value;
  parms = parms+"&uhrzeit_leistung="+formular.uhrzeit_leistung.value;
  parms = parms+"&frau_id="+formular.frau_id.value;
  //  alert("parm:"+parms);
  open("leistungserfassung_f2.pl"+parms,"leistungserfassung_f2");
}

function druck (form) {
  //  alert("druck"+form.frau_id.value);
  open("../rechnung/rechnung_generierung.pl?frau_id="+form.frau_id.value,"_top");
}

function aend (fr_id,ls_id) {
  // Leistungsposition zum ändern aufrufen
  //  alert("Hallo aendern"+fr_id+"leist_id"+ls_id);
  open("rechpos.pl?frau_id="+fr_id+"&leist_id="+ls_id+"&func=2","rechpos");
}
//alert("nach function aendern");

function loe_leistdat (fr_id,ls_id) {
  // leistungsposition zum Löschen aufrufen
  // alert("Hallo loeschen"+fr_id+"leist_id"+ls_id);
  open("rechpos.pl?frau_id="+fr_id+"&leist_id="+ls_id+"&func=3","rechpos");
}

function datum_uhrzeit_neu (doc) {
  var formular=doc.leistungen_f1;
  formular.datum_leistung.disabled = false;
  var dl_tag = doc.getElementsByName('datum_leistung');
  dl_tag = dl_tag[0].className='enabled';
  formular.uhrzeit_leistung.disabled = false;
  dl_tag = doc.getElementsByName('uhrzeit_leistung');
  dl_tag = dl_tag[0].className='enabled';
  formular.dauer_leistung.disabled = false;
  dl_tag = doc.getElementsByName('dauer_leistung');
  dl_tag = dl_tag[0].className='enabled';
  open("../blank.html","leistungserfassung_f2");
  formular.datum_leistung.focus();
  formular.datum_leistung.select();
}

function wo_tag(datum,uhrzeit,form) {
  // liefert den Wochentag zu dem angegebenen Datum und Uhrzeit
  // datum ist im format tt.mm.jjjj
  // 0 ist Sonntag, usw.
  // falls Samstag wird auf 8 gestellt, wenn vor 12:00
  
  if (uhrzeit == '') uhrzeit = '10:00';
  //alert("Hallo2 wo tag"+datum+uhrzeit+form);
  var re =/(\d{1,2})\.(\d{1,2})\.(\d{1,4})/g;
  var re_uhr =/(\d{1,2}):(\d{1,2})/g;
  var ret = re.exec(datum);
  if (ret==null) {re.exec(datum);} // Fehler im Browser beheben
  var j = new Number(RegExp.$3);
  var m = new Number(RegExp.$2);
  var t = new Number(RegExp.$1);
  ret = re_uhr.exec(uhrzeit);
  if (ret==null) {re_uhr.exec(uhrzeit);}
  var h = new Number(RegExp.$1);
  //alert("h"+h);
  m--;
  var d = new Date(j,m,t); 
  var wtag = '';
  if (d.getDay()==0) {wtag = 'Sonntag'};
  if (d.getDay()==1) {wtag = 'Montag'};
  if (d.getDay()==2) {wtag = 'Dienstag'};
  if (d.getDay()==3) {wtag = 'Mittwoch'};
  if (d.getDay()==4) {wtag = 'Donnerstag'};
  if (d.getDay()==5) {wtag = 'Freitag'};
  if (d.getDay()==6 && h < 12) {wtag = 'Samstag vor 12:00'};
  if (d.getDay()==6 && h >= 12) {wtag = 'Samstag nach 12:00'};
  form.wotag.value = wtag;
  //alert("datum"+d);
  
}

function zeit_preis(preis,zeit,mass) {
  // berechnet in Abhängigkeit der Zeit den Preis
  // datum ist im format tt.mm.jjjj
  // 0 ist Sonntag, usw.
  var re =/(\d{1,2}):(\d{1,2})/g;
    var ret = re.exec(zeit);
    if (ret==null) {re.exec(zeit);} // Fehler im Browser beheben
    var h = new Number(RegExp.$1);
    var m = new Number(RegExp.$2);
    var minuten = h*60+m;
    var rest = minuten % mass;
    var ber = minuten - rest;
    ber = ber / mass;
    ber++;
    var preis = preis * ber;
    preis = preis + 0.005; // runden
    preisre = /(\d*\.\d{2})/;
    preisre.exec(preis);
    preis = RegExp.$1;
    return preis;
}

function leistung_speicher(formular) {
  alert("hallo leistung_speicher");
  // alle disabled Knöpfe auf enabled stellen, damit Werte übergeben werden
  var i=formular.length-1;
  while (i >= 1) {
        alert("leistungspeicher"+i+formular.elements[i]);
    if (undefined != formular.elements[i]) {
      formular.elements[i].disabled=false;
    }
    i--;
  }
  return true;
}

function next_satz(formular) {
  // Datensatz mit dem nächst größeren Datum/Uhrzeit ausgeben
  alert("nächster Satz");
  if (formular.auswahl.value == 'Anzeigen') {
    var parms=formular.gruppen_auswahl.selectedIndex;
    parms = "?gruppen_auswahl="+parms;
    parms = parms+"&datum_leistung="+formular.datum_leistung.value;
    parms = parms+"&dauer_leistung="+formular.dauer_leistung.value;
    parms = parms+"&uhrzeit_leistung="+formular.uhrzeit_leistung.value;
    parms = parms+"&frau_id="+formular.frau_id.value;
    parms = parms+"&func=2";
    alert("parm:"+parms);
    open("leistungserfassung_f2.pl"+parms,"leistungserfassung_f2");
  } else {
    alert("Bitte Menuepunkt Anzeigen wählen");
  }
}

function round(wert) {
  // rundet den angegebenen Wert kaufmännisch
  // und liefert den Wert mit 2 NK stellen zurück
  wert+=0.005;
  wertre = /(\d*\.\d{2})/;
  wertre.exec(wert);
  return RegExp.$1;
}

//alert("leistungen.js ist geladen");
