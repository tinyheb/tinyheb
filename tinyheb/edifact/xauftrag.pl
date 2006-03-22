#!/usr/bin/perl -w

# erstellen der Auftragsdatei mit GUI für den Datenaustausch mit den
# gestzlichen Krankenkassen

# Copyright (C) 2005,2006 Thomas Baum <thomas.baum@arcor.de>
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

use strict;
use lib '../';

use Tk;
use Tk::JBrowseEntry;
use Tk::HList;
use Tk::ItemStyle;

use Mail::Sender;
use File::stat;

use Heb;
use Heb_Edi;
use Heb_leistung;
use Heb_krankenkassen;
use Heb_stammdaten;


my $path = $ENV{HOME}.'/.tinyheb'; # für temporäre Dateien

my $h = new Heb;
my $e = new Heb_Edi;
my $l = new Heb_leistung;
my $k = new Heb_krankenkassen;
my $s = new Heb_stammdaten;

my %prov=();
$prov{localhost}{mailserver}='localhost';
$prov{localhost}{user_name}='';
$prov{localhost}{user_from}=$h->parm_unique('HEB_EMAIL');
$prov{localhost}{user_pass}='';

my @provider =('localhost');

if (open RC,"$path/.xauftragrc") {
LINE: while (my $zeile=<RC>) {
    next LINE if($zeile =~ /^#/);
    chop ($zeile);
    my @parms = split '\t',$zeile;
    push @provider, $parms[0];
    $prov{$parms[0]}{mailserver}=$parms[0];
    $prov{$parms[0]}{user_name}=$parms[1] || '';
    $prov{$parms[0]}{user_from}=$parms[2] || '';
    $prov{$parms[0]}{user_pass}=$parms[3] || '';
  }
}

my $prov_sel='localhost';
my $user_sel='';
my $user_pass='';
my $user_from=$h->parm_unique('HEB_EMAIL');
my $ignore = 22;


my $mw = MainWindow->new(-title => 'Elektronische Rechnungen',
			 -bg => 'white');

my $h_frame = $mw->Frame();
my $hlist = $h_frame->Scrolled('HList',
			       -scrollbars => 'se',
			       -columns => 7,
			       -header => 1,
			       -width => 95,
			       -itemtype => 'text',
			       -selectforeground => 'blue',
			       -selectmode => 'extended');
$hlist->pack(-expand => 1, 
	     -fill => 'both');
$hlist->headerCreate(0,-text => "RechNr.");
$hlist->headerCreate(1,-text => "Name Frau");
$hlist->headerCreate(2,-text => "Kasse");
$hlist->headerCreate(3,-text => "Kostenträger");
$hlist->headerCreate(4,-text => "DA-Stelle");
$hlist->headerCreate(5,-text => "TestIndikator");
$hlist->headerCreate(6,-text => "Betrag");

fill_hlist();

my $z1_frame = $mw->Frame();

my $z1_knp_f = $z1_frame->Frame(
#			-borderwidth => 3,
#			-relief => 'raised'
			)->pack(-side => 'left',
			       -anchor => 'nw');

$z1_knp_f->Button(-text => 'Senden',
		  -command => \&sendmail,
		 )->pack(-side => 'left',
			);

$z1_knp_f->Button(-text => 'Aktualisieren',
		  -command => \&fill_hlist,
		 )->pack(-side => 'left',
			);

# Checkboxen für --ignore --update
my $cb_ignore = $z1_knp_f->Checkbutton(-text => 'ignore',
				       -onvalue => '24',
				       -offvalue => '22',
				       -variable => \$ignore);
$cb_ignore->pack(-side => 'left',
		 -anchor => 'w',
		 -ipadx => 10);

my $z1_mail_f = $z1_frame->Frame(
#				 -borderwidth => 3,
#				 -relief => 'raised'
				)->pack(-side => 'right',
					-anchor => 'e');
my $z1_prov_f = $z1_mail_f->Frame(
#				  -borderwidth => 3,
#				  -relief => 'raised'
				 )->pack(-side => 'top');
my $z1_from_f = $z1_mail_f->Frame(
#				  -borderwidth => 3,
#				  -relief => 'raised'
				 )->pack(-side => 'bottom',
					 -anchor => 's',
					 -expand => 1,
					 -fill => 'both');
HebLabEntry($z1_from_f,'From',
	    {-textvariable => \$user_from,
	     -width => 30})->pack(-side => 'left');



my $prov = $z1_prov_f->JBrowseEntry(-label => 'Mail Server',
				    -labelPack => [side => 'top', -anchor => 'w'],
				    -variable => \$prov_sel,
				    -choices => \@provider,
				    -browsecmd => \&prov_neu,
				    -state => 'readonly')->pack(-side => 'left');

HebLabEntry($z1_prov_f,'Benutzer Name',
	    {-textvariable => \$user_sel,
	    -width => 25})->pack(-side => 'left');

HebLabEntry($z1_prov_f,'Passwort',
	    {-textvariable => \$user_pass,
	     -show => '*',
	     -width => 10})->pack(-side => 'left',
				 );


$z1_frame->pack(-side => 'bottom',
		-expand => 1,
		-fill => 'both');

$h_frame->pack(-side => 'top',
	       -expand => 1,
	       -fill => 'both');
MainLoop;


sub sendmail {
  my @sel = $hlist->infoSelection;

  foreach (@sel) {
    my $rechnr=$_;
    print "Selektiert: $rechnr, baue Rechnung\n";

    my ($dateiname,$erstell_auf,$erstell_nutz)=$e->edi_rechnung($rechnr);
    $l->rechnung_such("RECH_DATUM,BETRAG,FK_STAMMDATEN,IK","RECHNUNGSNR=$rechnr");
    my ($rechdatum,$betrag,$frau_id,$ik)=$l->rechnung_such_next();
    # prüfen ob zu ik Zentral IK vorhanden ist
    my ($ktr,$zik)=$k->krankenkasse_ktr_da($ik);
    my $test_ind = $k->krankenkasse_test_ind($ik);

    my $dateiname_ext=$dateiname; # Dateiendung der Nutzdatendatei
    $dateiname_ext = $dateiname.'.sig' if ($h->parm_unique('SIG'.$zik) > 0);
    $dateiname_ext = $dateiname.'.enc' if ($h->parm_unique('SCHL'.$zik) > 0);

    open my $debug, ">>$path/maillog";
    $Mail::Sender::NO_X_MAILER=1;
    my $sender = ();
    if ($user_pass ne '') {
      $sender = new Mail::Sender ({smtp => $prov_sel,
				   from => $h->parm_unique('HEB_IK').'<'.$user_from.'>',
				   debug => $debug,
				   auth => 'LOGIN',
				   authid => $user_sel,
				   authpwd => $user_pass,
				   debug_level => 1,
				   boundary => 'tinyheb-'.$rechnr})
	or die "Fehler bei Mailverschicken $Mail::Sender::Error\n";
    } else {
      $sender = new Mail::Sender ({smtp => $prov_sel,
				   from => $h->parm_unique('HEB_IK').'<'.$user_from.'>',
				   debug => $debug,
				   debug_level => 1,
				   boundary => 'tinyheb-'.$rechnr})
	or die "Fehler bei Mailverschicken $Mail::Sender::Error\n";
    }

#    print "SENDER\n";
#    print Pretty $sender;

    $sender->OpenMultipart({to => $h->parm_unique('MAIL'.$zik),
			    bcc => $user_from,
			    subject => $h->parm_unique('HEB_IK')})
      or die "Fehler bei Mailverschicken $Mail::Sender::Error\n";

    my $msg_body='';
    my $crlf = "\x0d\x0a";
    $msg_body .= $dateiname.'.AUF,348,'.$erstell_auf.$crlf;
    # Länge der Nutzdatendatei ermitteln
    my $st=stat("$path/tmp/$dateiname_ext") or die "Datei $dateiname_ext für Message Body nicht vorhanden:$!\n";
    my $laenge_nutz=$st->size;
    $msg_body .= $dateiname.','.$laenge_nutz.','.$erstell_nutz.$crlf;
    $msg_body .= $h->parm_unique('HEB_VORNAME').' '.$h->parm_unique('HEB_NACHNAME').$crlf; # Absender Firmenname
    $msg_body .= $h->parm_unique('HEB_VORNAME').' '.$h->parm_unique('HEB_NACHNAME').$crlf; # Absender Ansprechpartner
    $msg_body .= $user_from.$crlf;
    $msg_body .= $h->parm_unique('HEB_TEL').$crlf;
    
    $sender->Body({charset => 'iso-8859-1',
		   ctype => 'text/plain',
		   encoding => 'Base64',
		   msg => $msg_body})
      or die "Fehler bei Mailverschicken $Mail::Sender::Error\n";

      # Auftragsdatei lesen und verschicken
    open AUF, "$path/tmp/$dateiname.AUF"
      or die "Konnte Auftragsdatei nicht öffnen\n";
    my $auf = <AUF>;
    close AUF;
    $sender->Part(
		    {ctype => 'text/plain',
		     charset => 'iso-8859-1',
		     encoding => 'Base64',
		     name => $dateiname.'.auf',
		     disposition => 'attachment; filename="'.$dateiname.'.auf"',
		     msg => $auf
		     })
      or die "Fehler bei Mailverschicken Auftragsdatei  $Mail::Sender::Error\n";

    # Nutzdatendatei lesen
    my $nutz='';
    open NUTZ, "$path/tmp/$dateiname_ext" or die "Konnte Nutzdatendatei nicht öffnen $!";
  LINE: while (my $zeile=<NUTZ>) {
    $nutz .= $zeile;
  }
  close NUTZ;
    $sender->Part(
                {ctype => 'text/plain',
                 name => $dateiname,
                 charset => 'iso-8859-1',
                 encoding => 'Base64',
                 disposition => 'attachment; filename="'.$dateiname.'";',
                 msg => $nutz
                })
      or die "Fehler bei Mailverschicken Nutzdatendatei  $Mail::Sender::Error\n";

    if ($sender->Close()) { #update nur machen, wenn Rechnung erfolgreich
      print "Rechnung erfolgreich verschickt\n";
      $e->edi_update($rechnr,1,$dateiname,$erstell_auf);
      my $empf_phys=$k->krankenkasse_empf_phys($zik);
      system("mkdir -p $path/tmp/$empf_phys");
      system("mv $path/tmp/$dateiname* $path/tmp/$empf_phys");
    } else {
      print "Konnte Rechnung nicht verschicken: $Mail::Sender::Error\n";
    }
  }
  fill_hlist();
}



sub fill_hlist {
  
  $hlist->delete('all');
  $l->rechnung_such("RECHNUNGSNR,BETRAG,STATUS,FK_STAMMDATEN,IK");

  while (my @erg=$l->rechnung_such_next()) {
    my @erg_frau=$s->stammdaten_frau_id($erg[3]);
    # Daten zur Krankenkasse holen
    my ($name_kk)=$k->krankenkasse_ik("KNAME",$erg[4]);
    my ($ktr,$da)=$k->krankenkasse_ktr_da($erg[4]);
    my $test_ind = $k->krankenkasse_test_ind($erg[4]);
    my ($name_da)=$k->krankenkasse_sel("KNAME",$da);
    my ($name_ktr)=$k->krankenkasse_sel("KNAME",$ktr);
    
    if (defined($test_ind) && $erg[2] < $ignore) {
      $hlist->add($erg[0]);
      $hlist->itemCreate($erg[0],0,-text => $erg[0]);
      $hlist->columnWidth(0,-char,9);
      $hlist->itemCreate($erg[0],1,-text => $erg_frau[1].','.$erg_frau[0]);
      $hlist->columnWidth(1,-char,20);
      $hlist->itemCreate($erg[0],2,-text => $name_kk);
      $hlist->columnWidth(2,-char,15);
      $hlist->itemCreate($erg[0],3,-text => $name_ktr);
      $hlist->columnWidth(3,-char,15);
      $hlist->itemCreate($erg[0],4,-text => $name_da);
      $hlist->columnWidth(4,-char,15);
      my $test_ind_name = 'Test';
      $test_ind_name = 'Erprobung' if ($test_ind == 1);
      $test_ind_name = 'Echtbetrieb' if ($test_ind == 2);
      $hlist->itemCreate($erg[0],5,
			 -text => $test_ind_name,
			);
      my $betrag = sprintf "%4.2f",$erg[1];
      $betrag =~ s/\./,/g;
      my $style=$hlist->ItemStyle('text',-anchor=>'e');
      $hlist->itemCreate($erg[0],6,
			 -itemtype=>'text',
			 -text => $betrag,
			 -style=> $style);
    }
  }
} 


sub prov_neu {
#  print "Provider Selektiert: $prov_sel\n";
  $user_sel=$prov{$prov_sel}{user_name};
  $user_from=$prov{$prov_sel}{user_from};
  $user_pass=$prov{$prov_sel}{user_pass};
}

sub HebLabEntry {
  my ($parent,$label,$parms)=@_;

  my $n_f = $parent->Frame();
  $n_f->Label(-text => $label,
	      -anchor => 'w')->pack(-side => 'top',-anchor => 'w');
  $n_f->Entry(%$parms)->pack(-side => 'bottom');
  return $n_f;
}

