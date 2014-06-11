
# globales Package für die Hebammen Verarbeitung

# $Id: string_helpers.pm,v 1.19 2014-06-11 23:36:03 renkljs Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2003 - 2013 Thomas Baum <thomas.baum@arcor.de>
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

package tiny_string_helpers;

sub string2filename
{
    my %umlaute = ("ä" => "ae", "ö" => "oe", "ü" => "ue", "Ä" => "Ae", "Ö" => "oe", "Ü" => "ue", "ß" => "ss");
    my $umlautekeys = join ("|", keys(%umlaute));

    $_[0] =~ s/($umlautekeys)/$umlaute{$1}/g;
    $_[0] =~ s/[^A-Za-z0-9\-\._]//g;

    return $_[0];
}

1;

