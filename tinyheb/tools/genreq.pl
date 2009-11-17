#!/usr/bin/perl -w

# erstellen eines Zertifikatrequest und senden an die ITSG

# $Id: genreq.pl,v 1.7 2009-11-17 08:58:19 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $

# Copyright (C) 2007,2008,2009 Thomas Baum <thomas.baum@arcor.de>
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
use Tk::Dialog;

use Mail::Sender;
use File::stat;
use File::Copy;

use Heb;

my %prov=();
my @provider =();

my $path = $ENV{HOME}; # für temporäre Dateien
if ($^O =~ /MSWin32/) {
  $path .='/tinyheb';
} else {
  $path .='/.tinyheb';
}

mkdir "$path" if (!(-d "$path"));

my $h = new Heb;

my $openssl ='openssl';

$openssl = $h->win32_openssl() if ($^O =~ /MSWin32/);

my $prov_sel=undef;
my $user_sel='';
my $user_pass='';
my $user_from=$h->parm_unique('HEB_EMAIL');

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




my $name_hebamme='Hebamme '.$h->parm_unique('HEB_VORNAME').' '.$h->parm_unique('HEB_NACHNAME');
$name_hebamme=subst_sonder($name_hebamme);
my $ansprechpartner='';
my $ik='IK'.$h->parm_unique('HEB_IK');
my $priv_pass='';
my $priv_pass2='';


my $mw = MainWindow->new(-title => 'tinyHeb Zertifikatgenerierung',
			 -bg => 'white');

my $menuebar = $mw->Menu;
$mw->configure(-menu => $menuebar);

my $datei = $menuebar->cascade(-label => '~Datei');
$datei->command(
		-label => 'Beenden',
		-command => \&exit,
	       );

my $z1_frame = $mw->Frame();
HebLabEntry($z1_frame,'IK',
	    {-textvariable => \$ik,
	     -state => 'disabled',
	    -width => 12})->pack(-side => 'top',
				-anchor => 'w',
				);
HebLabEntry($z1_frame,'Name der Hebamme',
	    {-textvariable => \$name_hebamme,
	     -state => 'disabled',
	     -width => 40})->pack(-side => 'top',
				  -anchor => 'w',
				 );

HebLabEntry($z1_frame,'Name Ansprechpartner',
	    {-textvariable => \$ansprechpartner,
	     -validate => 'all',
	     -validatecommand => \&check,
	     -invalidcommand => sub {$mw->bell},
	     -width => 40,
	     -background => 'white',
	    })->pack(-side => 'top',
		     -anchor => 'w',
				 );

HebLabEntry($z1_frame,'Passwort für Zertifikat',
	    {-textvariable => \$priv_pass,
	     -width => 15,
	     -show => '*',
	     -background => 'white',
	    })->pack(-side => 'top',
		     -anchor => 'w',
		    );

HebLabEntry($z1_frame,'Passwort für Zertifikat wiederholen',
	    {-textvariable => \$priv_pass2,
	     -width => 15,
	     -show => '*',
	     -background => 'white',
	    })->pack(-side => 'top',
		     -anchor => 'w',
		    );

$z1_frame->Button(-text => 'Zertifikat generieren',
		  -command => \&gen_cert,
		 )->pack(-side => 'bottom',
			 -anchor => 'w',
			);


my $z2_frame=$mw->Frame();
$z2_frame->Label(-text => 'Status der Generierung')->pack(-side => 'top',
							  -anchor => 'w',
							  );
my $erg = $z2_frame->Scrolled('Text',
#			      -scrollbars => 'oeoe',
			      -scrollbars => 'se',
			      -width => 80,
			      -height => 20,
			      )->pack(-side => 'bottom',
				     );


my $mail_frame = $z1_frame->Frame(
				  -borderwidth => 2,
				  -relief => 'raised',
				 )->pack(-side => 'left',
					 -expand => 1,
					 -fill => 'both',
					 -pady => 10,
					 -anchor => 'w');

#my $z1_mail_f = $z1_frame->Frame(
$mail_frame->Label(-text => 'Angaben zur Mailversendung',
		   -anchor => 'w')->pack(-side => 'top',
					 -anchor => 'w');
my $z1_mail_f = $mail_frame->Frame(
#                                -borderwidth => 3,
#                                -relief => 'raised',

                                )->pack(-side => 'left',
                                        -anchor => 'e');
my $z1_prov_f = $z1_mail_f->Frame(
#                                 -borderwidth => 3,
#                                 -relief => 'raised'
                                 )->pack(-side => 'top');
my $z1_from_f = $z1_mail_f->Frame(
                                 -borderwidth => 3,
                                 -relief => 'raised'
                                 )->pack(-side => 'top',
                                         -anchor => 'w',
#                                         -expand => 1,
#                                         -fill => 'both'
					);

my $z2_prov_f = $z1_prov_f->Frame(
#                          -borderwidth => 3,
#                          -relief => 'raised'
                           )->pack(-side => 'left');
$z2_prov_f->Label(-text => 'Mail Provider')->pack(-side => 'top',
                                                  -anchor => 'w');

my $prov = $z2_prov_f->BrowseEntry(
                                   -variable => \$prov_sel,
                                   -choices => \@provider,
				   -background => 'white',
                                   -browsecmd => \&prov_neu,
                                   -state => 'readonly')->pack(-side => 'left',
                                                               -anchor => 'w',
                                                              );

HebLabEntry($z1_prov_f,'Benutzer Name',
            {-textvariable => \$user_sel,
	     -width => 25,
	    -background => 'white'})->pack(-side => 'left');
HebLabEntry($z1_prov_f,'Passwort',
            {-textvariable => \$user_pass,
             -show => '*',
	     -background =>'white',
             -width => 10})->pack(-side => 'left',
                                 );
HebLabEntry($z1_mail_f,'From',
            {-textvariable => \$user_from,
             -width => 30,
	     -background =>'white',
	    })->pack(-side => 'left');


$z1_frame->pack(-side => 'top',
		-expand => 1,
		-fill => 'both');

$z2_frame->pack(-side => 'bottom',
		-expand => 1,
		-fill => 'both');

prov_neu();

MainLoop;



sub fehler {
  my ($text)=@_;
  $mw->messageBox(-title => 'Nachricht',
		  -type => 'OK',
		  -message => "$text\n",
		  -default => 'OK'
		 );
}



sub HebLabEntry {
  my ($parent,$label,$parms)=@_;

  my $n_f = $parent->Frame();
  $n_f->Label(-text => $label,
	      -anchor => 'w')->pack(-side => 'top',-anchor => 'w');
  $n_f->Entry(%$parms)->pack(-side => 'bottom',-anchor => 'w');
  return $n_f;
}



sub gen_cert {
  # zunächst privaten Schlüssel generieren
  if ($priv_pass ne $priv_pass2) {
    fehler("Die beiden Passwörter stimmen nicht überein,\nGenerierung des Zertifikates abgebrochen\n");
    return;
  }
  if ($priv_pass eq '') {
    fehler("Passwort muss angegeben sein\nGenerierung des Zertifikates abgebrochen\n");
    return;
  }
  
  if ($ansprechpartner eq '') {
    fehler("Ansprechpartner muss angegeben sein\nGenerierung des Zertifikates abgebrochen\n");
    return;
  }


  # prüfen, ob schon ein Zertifikatrequest vorliegt
#  print "prüfe Pfad",-e $path.'/'.substr($h->parm_unique('HEB_IK'),0,8).'.crq',"\n";
  if (-e $path.'/'.substr($h->parm_unique('HEB_IK'),0,8).'.crq') {
    my $cert_quest='';
    $cert_quest=warnung("Es existiert schon eine Zertifikatanfrage, soll diese überschrieben werden?");
    return if($cert_quest eq 'Nein' || $cert_quest eq 'Abbruch');
  }

  
  # prüfen, ob schon ein privater Schlüssel vorliegt
  my $priv_key_quest='Ja';
  if (-e "$path/privkey.pem") {
    $priv_key_quest=warnung("Es existiert schon ein privater Schlüssel, soll ein neuer generiert werden?");
    return if($priv_key_quest eq 'Abbruch');
  }

  # prüfen auf openssl installation
  if(!($openssl)) {
    fehler("keine openssl Installation gefunden");
    exit 1;
  }
  
  my $hilf=undef;
  my $cl=undef;

  if ($priv_key_quest eq 'Ja') {
    $erg->insert('end',"Generiere neuen privaten Schlüssel\n");
  
    $hilf=open PRIVKEY,"$openssl genrsa -passout pass:\"$priv_pass\" -des3 2048|";
    if (!defined($hilf)) {
      $erg->insert('end',"konnte privaten Schlüssel nicht generieren");
      fehler("konnte privaten Schlüssel nicht generieren, Zertifikatgenerierung wird abgebrochen");
      exit(1);
    }
  
    open (AUS,">:raw","$path/privkey.pem") or return (undef,"konnte privaten Schlüssel nicht schreiben");
    while (my $zeile=<PRIVKEY>) {
      print AUS $zeile;
    }
    close AUS;
    $cl=close PRIVKEY;
    if (!$cl && $? != 0) {
      $erg->insert('end',"schwerer OpenSSL Fehler aufgetreten, bitte OpenSSL Installation prüfen, Zertifikatgenerierung wird abgebrochen"); # openssl hat Fehler gemeldet
      exit(1);
    }
    $erg->insert('end',"Habe privaten Schlüssel generiert\n");
  } else {
    $erg->insert('end',"arbeite mit bestehendem privaten Schlüssel\n");
  }

  my $pass_quest='';
  $pass_quest=warnung("Soll eine verschlüsselte Sicherung des Passwortes angelegt werden?");
  return if($pass_quest eq 'Abbruch');
  if($pass_quest eq 'Ja') {
    unlink("$path/pass.pem");
    $hilf=undef;
    $hilf=open PASS,"|$openssl smime -encrypt -out $path/pass.pem -outform DER -des3 ../certs/tinyheb_cert.pem";
    
    if (!defined($hilf)) {
      $erg->insert('end',"konnte verschlüsseltes Passwort nicht schreiben");
      fehler("konnte verschlüsseltes Passwort nicht schreiben, Zertifikatgenerierung wird abgebrochen");
      exit(1);
    }
    print PASS $priv_pass;

    my $cl = close PASS;
    print "CL $cl frage $?\n";
    if (!$cl && $? != 0) {
      $erg->insert('end',"schwerer OpenSSL Fehler bei Passwort Kopie aufgetreten, bitte OpenSSL Installation und Passwort prüfen, Zertifikatgenerierung wird abgebrochen"); # openssl hat Fehler gemeldet
      fehler("schwerer OpenSSL Fehler bei Passwort Kopie aufgetreten, bitte OpenSSL Installation und Passwort prüfen, Zertifikatgenerierung wird abgebrochen");
    exit(1);
    }

  }

  my $st=stat("$path/privkey.pem");
  if (!defined($st) || $st->size == 0) {
    fehler("Privater Schlüssel nicht vorhanden, Zertifikatgenerierung wird abgebrochen\n");
    exit(1);
  }
  

  
  $erg->insert('end',"\nGeneriere Zertifikat Request\n");
  $hilf=undef;
  $hilf=open REQ,"$openssl req -new -key $path/privkey.pem -passin pass:\"$priv_pass\" -outform DER -subj \"/C=DE/O=ITSG TrustCenter fuer sonstige Leistungserbringer/OU=$name_hebamme/OU=$ik/CN=$ansprechpartner/\"|";

  if (!defined($hilf)) {
    $erg->insert('end',"konnte Request nicht generieren");
    fehler("konnte Request nicht generieren, Zertifikatgenerierung wird abgebrochen");
    exit(1);
  }

  my $out_path=$path.'/'.substr($h->parm_unique('HEB_IK'),0,8).'.crq';
  #  print "OUT_PATH: $out_path\n";
  open (AUS,">:raw","$out_path") or return (undef,"konnte Zertifikatrequest nicht schreiben");
  while (my $zeile=<REQ>) {
    print AUS $zeile;
  }
  close AUS;
  $cl = close REQ;
  if (!$cl && $? != 0) {
    $erg->insert('end',"schwerer OpenSSL Fehler aufgetreten, bitte Passwort prüfen, Zertifikatgenerierung wird abgebrochen"); # openssl hat Fehler gemeldet
    fehler("schwerer OpenSSL Fehler aufgetreten, bitte Passwort prüfen, Zertifikatgenerierung wird abgebrochen");
    exit(1);
  }
  
  $st=undef;
  $st=stat("$out_path");
  if (!defined($st) || $st->size == 0) {
    fehler("konnte Zertifikatrequest nicht schreiben, Zertifikatgenerierung wird abgebrochen\n");
    exit(1);
  }
  
  

  $erg->insert('end',"Habe Request generiert\n");
  
  $erg->insert('end',"\nExtrahiere öffentlichen Schlüssel aus Zertifikat\n");
  
  $hilf=undef;
  $hilf=open PUB,"$openssl req -in $out_path -inform DER -pubkey -noout|";
  if (!defined($hilf)) {
    print "konnte öffentlichen Schlüssel nicht extrahieren $!\n";
    $erg->insert('end',"konnte öffentlichen Schlüssel nicht extrahieren");
    exit(1);
  }

  open (AUS,">:raw","$path/pubkey.pem") or return (undef,"konnte PUBKEY nicht schreiben");
  while (my $zeile=<PUB>) {
    print AUS $zeile;
  }
  close AUS;
  $cl = close PUB;    
  if (!$cl && $? != 0) {
    $erg->insert('end',"schwerer OpenSSL Fehler aufgetreten, bitte OpenSSL Installation prüfen, Zertifikatgenerierung wird abgebrochen"); # openssl hat Fehler gemeldet
    fehler("schwerer OpenSSL Fehler aufgetreten, bitte OpenSSL Installation prüfen, Zertifikatgenerierung wird abgebrochen"); # openssl hat Fehler gemeldet
    exit(1);
  }


  $st=undef;
  $st=stat("$path/pubkey.pem");
  if (!defined($st) || $st->size == 0) {
    fehler("konnte public Key  nicht schreiben, Zertifikatgenerierung wird abgebrochen\n");
    exit(1);
  }
  
  $erg->insert('end',"Habe öffentlichen Schlüssel extrahiert\n");
  
  
  $erg->insert('end',"\nBerechne Prüfsumme des öffentlichen Schlüssels\n");
  $hilf=undef;
  $hilf=open MD5,"$openssl asn1parse -in $path/pubkey.pem -offset 24 -length 270 -out $path/pubkey_itsg.der |";
  if (!defined($hilf)) {
    $erg->insert('end',"konnte Prüfsumme nicht berechnen, Zertifikatgenerierung wird abgebrochen");
    exit(1);
  }
  
  while (my $zeile=<MD5>) {
    #    $erg->insert('end',$zeile);
  }
  close AUS;
  $cl = close MD5;
  if (!$cl && $? != 0) {
    $erg->insert('end',"schwerer OpenSSL Fehler aufgetreten, bitte OpenSSL Installation prüfen, Zertifikatgenerierung wird abgebrochen"); # openssl hat Fehler gemeldet
    fehler("schwerer OpenSSL Fehler aufgetreten, bitte OpenSSL Installation prüfen, Zertifikatgenerierung wird abgebrochen"); # openssl hat Fehler gemeldet
    exit(1);
  }

  $st=undef;
  $st=stat("$path/pubkey_itsg.der");
  if (!defined($st) || $st->size == 0) {
    fehler("konnte public Key  nicht schreiben, Zertifikatgenerierung wird abgebrochen\n");
    exit(1);
  }

  $hilf=open MD5,"$openssl dgst -md5 -c $path/pubkey_itsg.der |";
  if (!defined($hilf)) {
    $erg->insert('end',"konnte Prüfsumme nicht berechnen");
    exit(1);
  }
  
  my $pruefsumme='';
  my $help_p='';
  #  $erg->insert('end',"Prüfsumme:\n");
  while (my $zeile=<MD5>) {
    #    $erg->insert('end',$zeile);
    ($help_p,$pruefsumme)=split '=',$zeile;
  }
  close AUS;
  $cl=close MD5;
  if (!$cl && $? != 0) {
    $erg->insert('end',"schwerer OpenSSL Fehler aufgetreten, bitte OpenSSL Installation prüfen, Zertifikatgenerierung wird abgebrochen"); # openssl hat Fehler gemeldet
    fehler("schwerer OpenSSL Fehler aufgetreten, bitte OpenSSL Installation prüfen, Zertifikatgenerierung wird abgebrochen"); # openssl hat Fehler gemeldet
    exit(1);
  }
  $erg->insert('end',"Habe MD5 Signatur (Prüfsumme) berechnet\n");
  $erg->insert('end',"MD5 Signatur (Prüfsumme) des Zertifikates ist:\n");
  $erg->insert('end',"$pruefsumme\n");
  
  
  # SHA1 Prüfsumme
  $hilf=open SHA1,"$openssl dgst -sha1 -c $path/pubkey_itsg.der |";
  if (!defined($hilf)) {
    $erg->insert('end',"konnte Prüfsumme nicht berechnen");
    fehler("konnte Signatur (Prüfsumme) nicht berechnen");
    exit(1);
  }
  
  $pruefsumme='';
  $help_p='';
  #  $erg->insert('end',"Prüfsumme:\n");
  while (my $zeile=<SHA1>) {
    #    $erg->insert('end',$zeile);
    ($help_p,$pruefsumme)=split '=',$zeile;
  }
  close AUS;
  $cl=close MD5;
  if (!$cl && $? != 0) {
    $erg->insert('end',"schwerer OpenSSL Fehler aufgetreten, bitte OpenSSL Installation prüfen, Zertifikatgenerierung wird abgebrochen"); # openssl hat Fehler gemeldet
    fehler("schwerer OpenSSL Fehler aufgetreten, bitte OpenSSL Installation prüfen, Zertifikatgenerierung wird abgebrochen"); # openssl hat Fehler gemeldet
    exit(1);
  }
  $erg->insert('end',"Habe SHA1 Signatur (Prüfsumme) berechnet\n");
  $erg->insert('end',"SHA1 Signatur (Prüfsumme) des Zertifikates ist:\n");
  $erg->insert('end',"$pruefsumme\n");

  fehler("Bitte die Signaturen (Prüfsummen) mit Bezeichnung genau notieren, diese müssen per Brief/Fax unterschrieben an die ITSG geschickt werden");

  $erg->yviewMoveto(1);
  $mw->update;
 
  my $mail_frage=$mw->Dialog(-title => 'Frage',
			     -text => 'Soll das Zertifikat per E-Mail an die ITSG geschickt werden?',
			     -default_button => 'Ja',
			     -buttons => ['Ja', 'Nein'],
			    )->Show();

  if($mail_frage eq 'Ja') {
    fehler("Bitte Verbindung mit dem Internet aufbauen\n");
    if (!defined(gen_mail($out_path))) {
      fehler("Es ist ein Fehler aufgetreten, dass Programm wird beendet\n");
      exit(1);
    }
  }
     
    
    my $copy_frage=$mw->Dialog(-title => 'Frage',
			       -text => "Soll ich die Dateien in die korrekten Verzeichnisse kopieren?\n(alte Zertifikate werden überschrieben)",
			       -default_button => 'Ja',
			       -buttons => ['Ja', 'Nein'],
			      )->Show();
    
    if($copy_frage eq 'Ja') {
      if (!(-d "$path/privkey")) { # Zielverzeichnis anlegen
	mkdir "$path/privkey";
      }
      $erg->insert('end',"Ich kopiere folgende Dateien\n");
      $erg->insert('end',"$path/privkey.pem nach $path/privkey/privkey.pem\n");
      copy("$path/privkey.pem","$path/privkey/privkey.pem");
      
      $erg->insert('end',"$out_path nach ".$path.'/privkey/'.substr($h->parm_unique('HEB_IK'),0,8).".crq\n");
      copy("$out_path",$path.'/privkey/'.substr($h->parm_unique('HEB_IK'),0,8).'.crq');
    }
    
  $erg->insert('end',"\nDie Zertifikatgenerierung ist beendet, bitte die notwendigen Papierunterlagen\nper Brief oder Fax an die ITSG schicken.");
  $erg->yviewMoveto(1);
  $mw->update;

  $z2_frame->packForget;
  $z2_frame->pack(-side => 'bottom',
		-expand => 1,
		-fill => 'both');
  fehler("Bitte die Statusmeldungen aus der Generierung lesen,\ndann das Programm beenden");
    
}


sub check {
#  print "Übergeben:\n";
#  print "Parm 0:",$_[0],"\n";
#  print "Parm 0:",$$_[0],"\n";
#  print "Parm 1:",$_[1],"\n";
#  print "Parm 2:",$_[2],"\n";
#  print "Parm 3:",$_[3],"\n";
#  print "Parm 4:",$_[4],"\n";
  if ($_[4] > -1) {
    return 1 if(!defined($_[1]));
    return 1 if( $_[1] =~ /[a-zA-Z:\-\/() .0-9]/);
    return 0;
  }
  return 1;
}

sub subst_sonder {
  my ($ein) = @_;
  $ein =~ s/ä/ae/g;
  $ein =~ s/ü/ue/g;
  $ein =~ s/ö/oe/g;
  $ein =~ s/Ä/Ae/g;
  $ein =~ s/Ü/Ue/g;
  $ein =~ s/Ö/Oe/g;
  $ein =~ s/ß/ss/g;
  return $ein;
}


sub warnung {
  my ($text) = @_;
  
  return $mw->Dialog(-title => 'Warnung',
		     -text => $text,
		     -default_button => 'Nein',
		     -buttons => ['Ja', 'Nein','Abbruch'],
		     )->Show();
}


sub prov_neu {
#  print "Provider Selektiert: $prov_sel\n";
  $user_sel=$prov{$prov_sel}{user_name};
  $user_from=$prov{$prov_sel}{user_from};
  $user_pass=$prov{$prov_sel}{user_pass};
}


sub gen_mail {

  my ($out_path) = @_;

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
				 debug_level => 2,
				 boundary => 'tinyheb-certreq-1'
				});
  } else {
    $sender = new Mail::Sender ({smtp => $prov_sel,
				 from => $h->parm_unique('HEB_IK').'<'.$user_from.'>',
				 debug => $debug,
				 debug_level => 2,
				 boundary => 'tinyheb-certreq-1'
				});
  }
  
  if ($sender < 0){
    fehler("Fehler bei Mailverschicken der Zertifikatsanfrage $Mail::Sender::Error\nversenden wird abgebrochen.");
    return undef;
  }
  
#  if ($sender->OpenMultipart({to => 'thomas.baum@arcor.de',
  if ($sender->OpenMultipart({to => 'itsg-crq@atosorigin.com',
			      bcc => $user_from,
			      subject => 'Zertifikatsanfrage für '.$h->parm_unique('HEB_IK')}) < 0) {
    fehler("Fehler bei Mailverschicken der Zertifikatsanfrage $Mail::Sender::Error\nversenden wird abgebrochen ");
    return undef;
  }
  

  # leeren Body schicken
  if ($sender->Body({charset => 'iso-8859-1',
		     ctype => 'text/plain',
		     encoding => 'Base64',
		     msg => ''}) < 0) {
    fehler "Konnte den Zertifikatrequest nicht einlesen $!,\n das Verschicken per Mail wird abgebrochen";
    return undef;
    }


  # Requestdatei lesen
  my $req='';
  if (!(open (REQ,"<:raw","$out_path"))) {
    fehler "Konnte den Zertifikatrequest nicht einlesen $!,\n das Verschicken per Mail wird abgebrochen";
  }
 LINE: while (my $zeile=<REQ>) {
    $req .= $zeile;
  }
  close REQ;

  my $dateiname=substr($h->parm_unique('HEB_IK'),0,8).'.crq';
  if ($sender->Part(
		    {ctype => 'application/octet-stream',
		     name => $dateiname,
		     charset => 'iso-8859-1',
		     encoding => 'Base64',
		     disposition => 'attachment; filename="'.$dateiname.'";',
		     msg => $req
		    }) < 0) {
    fehler("Fehler bei Mailverschicken der Zertifikatsanfrage $Mail::Sender::Error\nversenden wird abgebrochen ");
    return undef;
  }
  if ($sender->Close()) {
    $erg->insert('end',"Zertifikat erfolgreich verschickt\n");
  }
  return 1;
}
