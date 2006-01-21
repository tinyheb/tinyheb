//alert("rechnung.js wird geladen");

function druck_fertig(frau_id,vorname,nachname,geb_frau,geb_kind,plz,ort,strasse,kv_nummer,kv_gueltig,versichertenstatus,name_kk,form) {
  // schreibt Rechnung in Fenster und macht update auf Datenbank
  //alert("Drucken Frau"+frau_id+"form"+form+"kk"+name_kk+"plz"+plz);
  // zunächst harte Plausiprüfungen, nur dann wenn keine privat Rechnung
  if (versichertenstatus != 'privat') {
    if (name_kk == '') {
      alert("Es wurde keine gültige Krankenkasse erfasst,\nes kann keine Rechnung produziert werden.\nRechnung wurde nicht gespeichert.");
      return false;
    }
    if (vorname == '') {
      alert("Vorname Frau  wurde nicht erfasst\nes kann keine Rechnung produziert werden. \nRechnung wurde nicht gespeichert.");
      return false;
    }
    if (nachname == '') {
      alert("Nachname Frau  wurde nicht erfasst\nes kann keine Rechnung produziert werden. \nRechnung wurde nicht gespeichert.");
      return false;
    }
    if (geb_frau == '00.00.0000' || geb_frau == '') {
      alert("Geburtsdatum Frau  wurde nicht erfasst\nes kann keine Rechnung produziert werden. \nRechnung wurde nicht gespeichert.");
      return false;
    }
  }

  // weiche Plausiprüfungen
  var error_text = '';

  if (geb_kind == '00.00.0000' || geb_kind == '') {
    error_text=error_text+"Geburtsdatum Kind wurde nicht erfasst\n";
  }
  if (plz == 0 || plz == '') {
    error_text=error_text+"PLZ wurde nicht erfasst\n";
  }
  if (ort == '') {
    error_text=error_text+"Ort wurde nicht erfasst\n";
  }
  if (strasse == '') {
    error_text=error_text+"Strasse wurde nicht erfasst\n";
  }
  if (kv_nummer == 0 || kv_nummer == '') {
    error_text=error_text+"Krankenversicherungsnummer wurde nicht erfasst\n";
  }
  if (kv_gueltig == 0 || kv_gueltig == '') {
    error_text=error_text+"Gültigkeitsdatum Krankenversicherungsnummer wurde nicht erfasst\n";
  }
  if (versichertenstatus == 0 || versichertenstatus == '') {
    error_text=error_text+"Versichertenstatus wurde nicht erfasst\n";
  }

  // prüfen liegen Fehler vor
  if (error_text != '') {
    var erg = confirm("Stammdatenerfassung nicht komplett\n"+error_text+"trotzdem fortfahren?");
    if (!erg) {
      return false;
    }
  }
  
  if (frau_id > 0) {
    open("ps2html.pl?frau_id="+frau_id+"&speichern=save","rechnung");
    // Knopf entgültig Drucken auf disabled stellen
    form.pdruck.disabled=true;
    alert("Rechnung wurde gespeichert\nBitte Rechnung über 'Print All' drucken");
  } else {
    alert("Bitte zunächst Frau auswählen");
  }
};

function bearb_rech(rechnr,status) {
  // Bearbeitungsmaske Rechnung mit Daten füllen
  if (status < 30) {
    open("rechposbear.pl?rechnungsnr="+rechnr,"rechposbear");
  } else {
    alert("Rechnung ist schon gezahlt, keine weitere Bearbeitung");
  }
}

function recherf(frau_id) {
  // springt in Maske zur Rechnungserfassung
  open("../erfassung/rechnungserfassung.pl?frau_id="+frau_id,"_top");
}

function anseh_rech(rech_id) {
  // neues Fenster mit Rechnung öffnen
  if (rech_id > 0) {
    open("druck_alt_rech.pl?rech_id="+rech_id,"rech_alt","scrollbars=yes,width=950,heigth=1100");
  } else {
    alert("Bitte Rechnung anwählen");
  }
}

//alert("rechnung.js ist geladen");
