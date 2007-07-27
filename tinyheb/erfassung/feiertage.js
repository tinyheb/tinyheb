/* script für Plausiprüfungen im Rahmen der Feiertagserfassung

# $Id: feiertage.js,v 1.5 2007-07-27 18:55:15 baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2004,2005,2006, 2007 Thomas Baum <thomas.baum@arcor.de>
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
  open("feiertagserfassung.pl","_top");
};

function feiertagsuchen(name,bund,formular) {
  // öffnet Fenster in dem ein Feiertag ausgewählt werden kann
  //  alert("feiertag suchen");
  open("feiertagauswahl.pl?name_feiertag="+name.value+"&bund_feiertag="+bund.value+"&suchen=suchen","feiertagwahl","scrollbars=yes,width=600,height=400");
};


function feiertag_speicher(formular) {
  if (!datum_check(formular.datum_feiertag)) {
    return false;
  }
  return true;
}

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
//alert("feiertag.js geladen");
