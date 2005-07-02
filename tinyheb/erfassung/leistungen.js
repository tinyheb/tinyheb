//alert("leistung.js wird geladen");

function druck (form) {
  //  alert("druck"+form.frau_id.value);
  if (form.frau_id.value > 0) {
    open("../rechnung/rechnung_generierung.pl?frau_id="+form.frau_id.value,"_top");
  } else {
    alert ("Bitte erst Frau auswählen");
  }
}

function aend (fr_id,ls_id,status) {
  // Leistungsposition zum ändern aufrufen
  //  alert("Hallo aendern"+fr_id+"leist_id"+ls_id);
  if (status == 10) {
    open("rechpos.pl?frau_id="+fr_id+"&leist_id="+ls_id+"&func=2","rechpos");
  } else {
    alert("Rechnung wurde gespeichert, ändern nicht möglich");
  }
}
//alert("nach function aendern");

function loe_leistdat (fr_id,ls_id,status) {
  // leistungsposition zum Löschen aufrufen
  // alert("Hallo loeschen"+fr_id+"leist_id"+ls_id);
  if (status == 10) {
    open("rechpos.pl?frau_id="+fr_id+"&leist_id="+ls_id+"&func=3","rechpos");
  } else {
    alert("Rechnung wurde gedruckt, Löschen nicht möglich");
  }
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

function round(wert) {
  // rundet den angegebenen Wert kaufmännisch
  // und liefert den Wert mit 2 NK stellen zurück
  wert+=0.005;
  wertre = /(\d*\.\d{2})/;
  wertre.exec(wert);
  return RegExp.$1;
}


function next_satz_leistart(formular) {
  //  alert("next"+formular.leist_id);
  id = formular.leist_id.value;
  if(formular.auswahl.value == 'Anzeigen') {
    open("leistungsarterfassung.pl?func=1&leist_id="+id,"_top");
  } else {
    alert("Bitte Menuepunkt Anzeigen wählen");
  }
}


function prev_satz_leistart(formular) {
  id = formular.leist_id.value;
  if(formular.auswahl.value == 'Anzeigen') {
    open("leistungsarterfassung.pl?func=2&leist_id="+id,"_top");
  } else {
    alert("Bitte Menuepunkt Anzeigen wählen");
  }
}

//alert("leistungen.js ist geladen");
