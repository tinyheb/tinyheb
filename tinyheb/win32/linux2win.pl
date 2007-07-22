#!/usr/bin/perl -w

# Erzeugt aus einer tinyHeb Linux Version eine Windows Version
# Zeilenende werden angepasst,
# Shebang Zeile geändert

# $Id: linux2win.pl,v 1.2 2007-07-22 11:18:42 baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2007 Thomas Baum <thomas.baum@arcor.de>
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

use strict;
use Getopt::Std;

my %option = ();
getopts("f:",\%option);


my $base_dir=$option{f} or '.';

my @dirs =qw(apache2 edifact erfassung rechnung tools win32 .);

foreach my $dir (@dirs) {
  print "\nBearbeite Verzeichnis $dir\n";
  opendir (DIR,"$base_dir../$dir") or die "konnte Verzeichnis $dir nicht lesen $!\n";
  my @allfiles = grep {$_ ne '.' and $_ ne '..'} readdir DIR;
#  print "Dateien: @allfiles\n";

  foreach  my $file (@allfiles) {
    if (-f "$base_dir../$dir/$file") {
      print "Bearbeite Datei $file\n";
      open FILE,"$base_dir../$dir/$file" or 
	die "konnte Datei $base_dir../$dir/$file nicht lesen $!\n";
      my @alllines=<FILE>;
      close FILE;
      my @winlines = grep { chomp } @alllines;
      
      for my $i (0  .. $#winlines) {
	$winlines[$i] =~ s/!\/usr\/bin\/perl/!perl/i;
      }
      if ($^O =~ /linux/) {
	open (FILE,">:raw","$base_dir../$dir/$file") or
	  die "konnte Datei $base_dir../$dir/$file nicht schreiben $!\n";
	print FILE join "\x0d\x0a",@winlines;
	print FILE "\x0d\x0a";
      } else {
	open FILE,">$base_dir../$dir/$file" or
	  die "konnte Datei $base_dir../$dir/$file nicht schreiben $!\n";
	print FILE join "\n",@winlines;
	print FILE "\n";
      }
      close FILE;
    }
  }
}
