/* script für Navigation 
# im Rahmen der Parametererfassung

# $Id$
# Tag $Name$

# Copyright (C) 2004,2005,2006,2007 Thomas Baum <thomas.baum@arcor.de>
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


function next_satz_parms(formular) {
  //  alert("next"+formular.leist_id);
  id = formular.id.value;
  if(formular.auswahl.value == 'Anzeigen') {
    open("parameter.pl?func=1&id="+id,"_top");
  } else {
    alert("Bitte Menuepunkt Anzeigen wählen");
  }
}

function prev_satz_parms(formular) {
  id = formular.id.value;
  if(formular.auswahl.value == 'Anzeigen') {
    open("parameter.pl?func=2&id="+id,"_top");
  } else {
    alert("Bitte Menuepunkt Anzeigen wählen");
  }
}


function parmsuchen(pname,pvalue,pbeschreibung) {
  // öffnet Fenster in Parameter gesucht und ausgewählt werden kann
  open("parameterauswahl.pl?pname="+pname.value+"&pvalue="+pvalue.value+"&pbeschreibung="+pbeschreibung.value+"&suchen=Suchen","parmauswahl","scrollbars=yes,width=700,height=400");
}


function p_eintrag(parm_id,name,wert,beschreibung) {
  // in Parent Dokument übernehmen
  var formular=opener.window.document.forms[0];
  formular.id.value=parm_id;
  formular.id2.value=parm_id;
  formular.pname.value=name;
  formular.pvalue.value=wert;
  formular.pbeschreibung.value=beschreibung;
}
