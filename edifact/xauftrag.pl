#!/usr/bin/perl -w

# erstellen der Auftragsdatei mit GUI für den Datenaustausch mit den
# gestzlichen Krankenkassen

# Id: $Id$
# Tag $Name$

# Copyright (C) 2005 - 2013 Thomas Baum <thomas.baum@arcor.de>
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
use lib '../';

use Tk;
use Tk::BrowseEntry;
use Tk::HList;
use Tk::ItemStyle;
use Tk::DialogBox;

#use Data::Dumper;

use Mail::Sender;
use File::stat;
use File::Copy;

use Heb;
use Heb_Edi;
use Heb_leistung;
use Heb_krankenkassen;
use Heb_stammdaten;

my $path = $ENV{HOME}; # für temporäre Dateien
if ($^O =~ /MSWin32/) {
  $path .='/tinyheb';
} else {
  $path .='/.tinyheb';
}

if (!(-d "$path/tmp")) { # Zielverzeichnis anlegen
  mkdir "$path" if (!(-d "$path"));
  mkdir "$path/tmp";
}

my $h = new Heb;
my $l = new Heb_leistung;
my $k = new Heb_krankenkassen;
my $s = new Heb_stammdaten;

my $tl; # fenster für Einstellungen

my %prov=();
my @provider =();

my $prov_sel=undef;
my $user_sel='';
my $user_pass='';
my $sig_pass=undef; # Passwort zum privaten Schlüssel
my $user_from=$h->parm_unique('HEB_EMAIL');
my $ignore = 22;

if ($^O !~ /MSWin32/) {
  $prov{localhost}{mailserver}='localhost';
  $prov{localhost}{user_name}='';
  $prov{localhost}{user_from}=$h->parm_unique('HEB_EMAIL');
  $prov{localhost}{user_pass}='';
  @provider=('localhost');
  $prov_sel='localhost';
}



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
    $prov_sel=$parms[0] if (!defined($prov_sel));
  }
} else {
  if (open RC,">$path/.xauftragrc") {
    my ($ename,$eprovider)=split '@',$h->parm_unique('HEB_EMAIL');
    print RC "mail.arcor.de\t$ename\t$ename@","$eprovider\tpasswort\n";
    print RC "mail.web.de\t$ename@","$eprovider\t$ename@","$eprovider\tpasswort\n";
    print RC "provider\tAnmeldenahme\tMailadresse\tPasswort\n";
    close RC;
  }
}

my $mw = MainWindow->new(-title => 'tinyHeb Elektronische Rechnungen',
			 -bg => 'white');

my $menuebar = $mw->Menu;
$mw->configure(-menu => $menuebar);

my $datei = $menuebar->cascade(-label => '~Datei');
$datei->command(
		-label => 'Beenden',
		-command => \&exit,
	       );
my $bearbeiten = $menuebar->cascade(-label => '~Bearbeiten');
$bearbeiten->command(
		     -label => 'Einstellungen',
		     -command => \&einstellungen,
		    );
$bearbeiten->command(
		     -label => 'Einstellungen Speichern',
		     -command => \&einstellungen_speichern,
		    );

my $h_frame = $mw->Frame();
my $hlist = $h_frame->Scrolled('HList',
			       -scrollbars => 'osoe',
			       -columns => 7,
			       -header => 1,
			       -width => 115,
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
				       -onvalue => '29',
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


my $z2_prov_f = $z1_prov_f->Frame(
#			   -borderwidth => 3,
#			   -relief => 'raised'
			   )->pack(-side => 'left');
$z2_prov_f->Label(-text => 'Mail Provider')->pack(-side => 'top',
						  -anchor => 'w');

#my $prov = $z1_prov_f->BrowseEntry(#-label => 'Mail Server',
#my $prov_entry = $z2_prov_f->BrowseEntry(#-label => 'Mail Server',
#				   -variable => \$prov_sel,
#				   -choices => \@provider,
#				   -background => 'white',
#				   -browsecmd => \&prov_neu,
#				   -state => 'readonly')->pack(-side => 'left',
#							       -anchor => 'w',
#
#							      );

my $prov_entry;
paint_prov_entry();

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

prov_neu();

MainLoop;


sub sendmail {
  my @sel = $hlist->infoSelection;

RECH:  foreach (@sel) {
    my $rechnr=$_;
    print "Selektiert: $rechnr, baue Rechnung\n";

    $l->rechnung_such("RECH_DATUM,BETRAG,FK_STAMMDATEN,IK","RECHNUNGSNR=$rechnr");
    my ($rechdatum,$betrag,$frau_id,$ik)=$l->rechnung_such_next();
    # prüfen ob zu ik Zentral IK vorhanden ist
    my ($ktr,$zik)=$k->krankenkasse_ktr_da($ik);
    my $test_ind = $k->krankenkasse_test_ind($ik);

    if ($h->parm_unique('SIG'.$zik) > 0 && !defined($sig_pass)) {
      print "passwort muss angegeben werden\n";
      get_sig_pass();
    }

    if(!$h->parm_unique('MAIL'.$zik)) {
      fehler("Fehler bei Mailverschicken von Rechnung $rechnr:\nE-Mail Adresse der Datenannahmestelle unbekannt,\n bitte in den Parametern der Datenannahmestellen nachpflegen \nversenden wird abgebrochen ");
      last RECH;
    }

    my $e = new Heb_Edi($rechnr,
		       sig_pass => $sig_pass);

    if (!defined($e)) {
      fehler($Heb_Edi::ERROR." versenden wird abgebrochen.");
      $sig_pass=undef;
      last RECH;
    }

    open my $debug, ">>$path/maillog";
    $Mail::Sender::NO_X_MAILER=1;
    my $sender = undef;
    if ($user_pass ne '') {
      $sender = new Mail::Sender ({smtp => $prov_sel,
				   from => $h->parm_unique('HEB_IK').'<'.$user_from.'>',
				   debug => $debug,
				   auth => 'LOGIN',
				   authid => $user_sel,
				   authpwd => $user_pass,
				   TLS_allowed => 0,
				   debug_level => 3,
				   boundary => 'tinyheb-'.$rechnr});
    } else {
      $sender = new Mail::Sender ({smtp => $prov_sel,
				   from => $h->parm_unique('HEB_IK').'<'.$user_from.'>',
				   debug => $debug,
				   debug_level => 3,
				   boundary => 'tinyheb-'.$rechnr});
    }

    if ($sender < 0){
      fehler("Fehler bei Mailverschicken von Rechnung $rechnr: $Mail::Sender::Error\nversenden wird abgebrochen.");
      last RECH;
    }
#    print "SENDER\n";
#    print Pretty $sender;

    if ($sender->OpenMultipart({to => $h->parm_unique('MAIL'.$zik),
				bcc => $user_from,
				subject => $h->parm_unique('HEB_IK')}) < 0) {
      fehler("Fehler bei Mailverschicken von Rechnung $rechnr: $Mail::Sender::Error\nversenden wird abgebrochen ");
      last RECH;
    }

    # Edi Rechnung entgültig erstellen
    my ($dateiname,$erstell_auf,$erstell_nutz)=(undef,undef,undef);
    ($dateiname,$erstell_auf,$erstell_nutz)=$e->edi_rechnung($rechnr);
    if(!defined($dateiname)) {
      fehler("Fehler bei Mailverschicken von Rechnung $rechnr:\nelektronische Rechnung konnte nicht erstellt werden $! \nversenden wird abgebrochen ");
      last RECH;
    }
    my $dateiname_ext=$dateiname; # Dateiendung der Nutzdatendatei
    $dateiname_ext = $dateiname.'.sig' if ($h->parm_unique('SIG'.$zik) > 0);
    $dateiname_ext = $dateiname.'.enc' if ($h->parm_unique('SCHL'.$zik) > 0);


    my $msg_body='';
    my $crlf = "\x0d\x0a";
    $msg_body .= $dateiname.'.AUF,348,'.$erstell_auf.$crlf;
    # Länge der Nutzdatendatei ermitteln
    my $st=stat("$path/tmp/$dateiname_ext");
    if(!defined($st)) {
      fehler("Datei $dateiname_ext für Message Body nicht vorhanden:$!\nversenden wird abgebrochen");
      last RECH;
    }
    my $laenge_nutz=$st->size;
    $msg_body .= $dateiname.','.$laenge_nutz.','.$erstell_nutz.$crlf;
    $msg_body .= $h->parm_unique('HEB_VORNAME').' '.$h->parm_unique('HEB_NACHNAME').$crlf; # Absender Firmenname
    $msg_body .= $h->parm_unique('HEB_VORNAME').' '.$h->parm_unique('HEB_NACHNAME').$crlf; # Absender Ansprechpartner
    $msg_body .= $user_from.$crlf;
    $msg_body .= $h->parm_unique('HEB_TEL').$crlf;
    
    if ($sender->Body({charset => 'iso-8859-1',
		       ctype => 'text/plain',
		       encoding => 'Base64',
		       msg => $msg_body}) < 0) {
      fehler("Fehler bei Mailverschicken von Rechnung $rechnr: $Mail::Sender::Error\nversenden wird abgebrochen ");
      last RECH;
    }

      # Auftragsdatei lesen und verschicken
    open AUF, "$path/tmp/$dateiname.AUF"
      or die "Konnte Auftragsdatei nicht öffnen\n";
    my $auf = <AUF>;
    close AUF;
    if($sender->Part(
		    {ctype => 'text/plain',
		     charset => 'iso-8859-1',
		     encoding => 'Base64',
		     name => $dateiname.'.auf',
		     disposition => 'attachment; filename="'.$dateiname.'.auf"',
		     msg => $auf
		    }) < 0) {
      fehler("Fehler bei Mailverschicken von Rechnung $rechnr: $Mail::Sender::Error\nversenden wird abgebrochen ");
      last RECH;
    }

    # Nutzdatendatei lesen
    my $nutz='';
    open NUTZ,"$path/tmp/$dateiname_ext" or die "Konnte Nutzdatendatei nicht öffnen $!";
    binmode NUTZ;

  LINE: while (my $zeile=<NUTZ>) {
    $nutz .= $zeile;
  }
  close NUTZ;

    if (length($nutz) < 10) {
      print "Laenge Nutz",length($nutz),"\n";
      fehler("Nutzdaten nicht ok bitte Autor benachrichtigen\nversenden wird abgebrochen ");
      last RECH;
    }

    if ($sender->Part(
                {# ctype => 'text/plain',
                 name => $dateiname,
                 charset => 'iso-8859-1',
                 encoding => 'Base64',
                 disposition => 'attachment; filename="'.$dateiname.'";',
                 msg => $nutz
                }) < 0) {
      fehler("Fehler bei Mailverschicken von Rechnung $rechnr: $Mail::Sender::Error\nversenden wird abgebrochen ");
      last RECH;
    }


    if ($sender->Close()) { #update nur machen, wenn Rechnung erfolgreich
      print "Rechnung erfolgreich verschickt\n";
      $e->edi_update($rechnr,1,$dateiname,$erstell_auf);
      my $empf_phys=$k->krankenkasse_empf_phys($zik);
      if (!(-d "$path/tmp/$empf_phys")) { # Zielverzeichnis anlegen
	mkdir "$path/tmp/$empf_phys";
      }
      foreach my $ext ('','.AUF','.enc','.sig') {
	if (-e "$path/tmp/$dateiname$ext") {
	  move("$path/tmp/$dateiname$ext","$path/tmp/$empf_phys/$dateiname$ext");
	}
      }
      $mw->messageBox(-title => 'Rechnungsversand',
		      -type => 'OK',
		      -message => "Rechnung $rechnr erfolgreich verschickt",
		      -default => 'OK'
		      );
    } else {
      fehler("Fehler bei Mailverschicken von Rechnung $rechnr: $Mail::Sender::Error\nversenden wird abgebrochen ");
      last RECH;
    }
  }
  fill_hlist();
}



sub fehler {
  my ($text)=@_;
  $mw->messageBox(-title => 'Rechnungsversand',
		  -type => 'OK',
		  -message => "$text\n",
		  -default => 'OK'
		 );
}


sub hinweis {
  my ($text)=@_;
  $mw->messageBox(-title => 'Hinweis',
		  -type => 'OK',
		  -message => "$text\n",
		  -default => 'OK'
		 );
}




sub fill_hlist {
  
  $hlist->delete('all');
  $l->rechnung_such("RECHNUNGSNR,BETRAG,STATUS,FK_STAMMDATEN,IK");

  while (my @erg=$l->rechnung_such_next()) {
    my @erg_frau=$s->stammdaten_frau_id($erg[3]);
    # Daten zur Krankenkasse holen
    my ($name_kk)=$k->krankenkasse_sel("KNAME",$erg[4]);
    my ($ktr,$da)=$k->krankenkasse_ktr_da($erg[4]);
    my $test_ind = $k->krankenkasse_test_ind($erg[4]);
    my ($name_da)=$k->krankenkasse_sel("KNAME",$da);
    my ($name_ktr)=$k->krankenkasse_sel("KNAME",$ktr);
    
    if (defined($test_ind) && $erg[2] < $ignore) {
      $hlist->add($erg[0]);
      $hlist->itemCreate($erg[0],0,-text => $erg[0]);
      $hlist->columnWidth(0,-char,9);
      $hlist->itemCreate($erg[0],1,-text => $erg_frau[1].','.$erg_frau[0]);
      $hlist->columnWidth(1,-char,30);
      $hlist->itemCreate($erg[0],2,-text => $name_kk);
      $hlist->columnWidth(2,-char,20);
      $hlist->itemCreate($erg[0],3,-text => $name_ktr);
      $hlist->columnWidth(3,-char,20);
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

sub get_sig_pass {
  my $db = $mw->DialogBox( -title => 'Zertifikat Passwort',
			   -buttons => ['OK','Abbrechen'],
			   -default_button => 'OK'
			 );
  $db->add('Label',
	   -text => "Rechnung soll signiert werden,")->pack(-side => 'top',-anchor => 'w');
 $db->add('Label',
	   -text => "bitte Passwort des Schlüssels eingeben")->pack(-side => 'top',-anchor => 'w');
  $db->add('Entry',
	   -textvariable => \$sig_pass,
	  -show => '*',
	  -width => 40)->pack(-side => 'bottom',-anchor => 'w');
  my $answer=$db->Show();
}


sub einstellungen {
  if (!Exists($tl)) {
    $tl = $mw->Toplevel();
    $tl->title("Einstellungen");

    my @einst_provider=();
    my @einst_name=();
    my @einst_from=();
    my @einst_pass=();
    my $i=0;

    my $line_f2 = $tl->Frame()->pack(-side => 'bottom');

    foreach my $p (@provider) {
      push @einst_provider,$p;
#      print "PROV $p\n";
      push @einst_name,$prov{$p}{user_name};
      push @einst_from,$prov{$p}{user_from};
      push @einst_pass,$prov{$p}{user_pass};
      
      my $line_f = $tl->Frame(
			      # -borderwidth => 3,
			      # -relief => 'raised'
			     )->pack(-side => 'top',
				     -anchor => 'n',
				     -expand => 1,
				     -fill => 'both');

      my $state='normal';
      $state = 'disabled' if ($einst_provider[$i] eq 'localhost');
      HebLabEntry($line_f,"Mailserver/ Provider $i",
		  {-textvariable => \$einst_provider[$i],
		   -state => $state,
		   -width => 20})->pack(-side => 'left');
      
      HebLabEntry($line_f,'Benutzer Name',
		  {-textvariable => \$einst_name[$i],
		   -width => 25})->pack(-side => 'left');

      HebLabEntry($line_f,'From',
		  {-textvariable => \$einst_from[$i],
		   -width => 30})->pack(-side => 'left');

      HebLabEntry($line_f,'Passwort',
		  {-textvariable => \$einst_pass[$i],
		   -show => '*',
		   -width => 10})->pack(-side => 'left');
      $i++;
    }

    $line_f2->Button(-text => "Einstellungen übernehmen und Schließen",
		-command => sub {$tl->withdraw;
				 my $x=0;
				 while ($x < $i) {
				   $provider[$x]=$einst_provider[$x];
				   $prov{$einst_provider[$x]}{mailserver}=$einst_provider[$x];
				   $prov{$einst_provider[$x]}{user_name}=$einst_name[$x];
				   $prov{$einst_provider[$x]}{user_from}=$einst_from[$x];
				   $prov{$einst_provider[$x]}{user_pass}=$einst_pass[$x];
				   print $provider[$x],"\n";
				   $x++;
				 }
				 $prov_sel=$provider[0];
				 prov_neu();
				 $prov_entry->packForget;
				 paint_prov_entry();})->pack(-side => 'left');
    $line_f2->Button(-text => "Abbrechen",
		-command => sub{$tl->destroy;})->pack(-side => 'left');

  } else {
    $tl->deiconify();
    $tl->raise();
  }
  
}


sub paint_prov_entry {
  $prov_entry = $z2_prov_f->BrowseEntry(#-label => 'Mail Server',
					-variable => \$prov_sel,
					-choices => \@provider,
					# -background => 'white',
					-browsecmd => \&prov_neu,
					-state => 'readonly')->pack(-side => 'left',
                                                               -anchor => 'w',
                                                              );

}

sub einstellungen_speichern {
  # in Datei speichern
  unless (open RC,">$path/.xauftragrc") {
    hinweis("FEHLER: Einstellungen konnten nicht gespeichert werden\n$!");
    return;
  }

  foreach my $p (@provider) {
    print RC $p,"\t",$prov{$p}{user_name},"\t",$prov{$p}{user_from},"\t",$prov{$p}{user_pass},"\n" if ($p ne 'localhost');
  }
  close RC;
  hinweis("Einstellungen erfolgreich gespeichert");
}
