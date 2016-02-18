/* Gibt die Versionsnummer aus

# Copyright (C) 2008 Thomas Baum <thomas.baum@arcor.de>
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


window.onload=function() {
  var version=document.getElementById('version');

  // Versionsnummer ermitteln
  var id='$Name: tinyheb-1-7-2 $';
  //var id="$Name: not supported by cvs2svn $";
  id=id.slice(1,-1);
  //  alert("ID"+id);
  var ar=id.split('-')
  var txtNode='';
  if (typeof ar[1] != "undefined") {
    txtNode=document.createTextNode(ar[1]+'.'+ar[2]+'.'+ar[3]);
  } else {
    txtNode=document.createTextNode('development');
  }
  version.appendChild(txtNode);
}
