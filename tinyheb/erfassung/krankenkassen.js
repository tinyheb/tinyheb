/* script für Plausiprüfungen und Navigation 
# im Rahmen der Krankenkassenerfassung

# Copyright (C) 2004,2005,2006 Thomas Baum <thomas.baum@arcor.de>
# Thomas Baum, Rubensstr. 3, 42719 Solingen, Germany

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# any later version.

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

function next_satz(formular) {
  // holt die in ik angegebene Krankenkasse ins Fenster
  //	alert("naechster Satz"+ik);
  ik = formular.ik_krankenkasse.value;
  if (formular.auswahl.value == 'Anzeigen') {
    open("krankenkassenerfassung.pl?func=1&ik_krankenkasse="+ik,"_top");
  } else {
    alert("Bitte Menuepunkt Anzeigen wählen");
  }
}


function prev_satz(formular) {
  // holt die in ik angegebene Krankenkasse ins Fenster
  //	alert("naechster Satz"+ik);
  ik = formular.ik_krankenkasse.value;
  if (formular.auswahl.value == 'Anzeigen') {
    open("krankenkassenerfassung.pl?func=2&ik_krankenkasse="+ik,"_top");
  } else {
    alert("Bitte Menuepunkt Anzeigen wählen");
  }
}
