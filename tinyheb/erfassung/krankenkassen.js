/* script für Plausiprüfungen und Navigation 
# im Rahmen der Krankenkassenerfassung

# $Id: krankenkassen.js,v 1.10 2008-10-05 13:19:39 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2004,2005,2006,2007,2008 Thomas Baum <thomas.baum@arcor.de>
# Thomas Baum, 42719 Solingen, Germany

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/


function loeschen() {
  open("krankenkassenerfassung.pl","_top");
};

function kassesuchen() {
  // öffnet Fenster in dem eine Krankenkasse ausgewählt werden kann
  open("kassenauswahl.pl","kassenwahl","scrollbars=yes,width=800,height=400");
};

function next_satz_kasse(formular) {
  // holt die in ik angegebene Krankenkasse ins Fenster
  //	alert("naechster Satz"+ik);
  ik = formular.ik_krankenkasse.value;
  if (formular.auswahl.value == 'Anzeigen') {
    open("krankenkassenerfassung.pl?func=1&ik_krankenkasse="+ik,"_top");
  } else {
    alert("Bitte Menuepunkt Anzeigen wählen");
  }
}

function prev_satz_kasse(formular) {
  // holt die in ik angegebene Krankenkasse ins Fenster
  //	alert("naechster Satz"+ik);
  ik = formular.ik_krankenkasse.value;
  if (formular.auswahl.value == 'Anzeigen') {
    open("krankenkassenerfassung.pl?func=2&ik_krankenkasse="+ik,"_top");
  } else {
    alert("Bitte Menuepunkt Anzeigen wählen");
  }
}

function kasse_speichern(formular) {
  // plausiprüfungen bevor formular submittet wird.
  if (!plz_check(formular.plz_haus_krankenkasse)) {
    return false;
  }
  if (!plz_check(formular.plz_post_krankenkasse)) {
    return false;
  }
  if(!ik_gueltig_check(formular.ik_krankenkasse)) {
    return false;
  }
  if(!ik_gueltig_check(formular.zik_krankenkasse)) {
    return false;
  }  
  if(!ik_gueltig_check(formular.beleg_ik)) {
    return false;
  }

  return true;
}


function kk_eintrag(k_ik,kname,name,plz_haus,plz_post,ort,strasse,status_edi) {
  //  alert("gewählt"+name+plz_haus+ort+strasse+k_ik);
  // in Parent Dokument übernehmen
  // alert("parent"+opener.window.document.forms[0].name);
  var formular=opener.window.document.forms[0];
  if (formular.name == 'krankenkassen') {
    opener.window.location="krankenkassenerfassung.pl?func=3&ik_krankenkasse="+k_ik;
  } else {
    formular.ik_krankenkasse.value=k_ik;
    formular.name_krankenkasse.value=name;
    formular.strasse_krankenkasse.value=strasse;
    formular.ort_krankenkasse.value=plz_haus+' '+ort;
    formular.status_edi_krankenkasse.value=status_edi;
  }
}
