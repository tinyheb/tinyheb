# ------------- sonstige Leistungen -------------
#
# sonstige Leistungen
# Leistungsgruppe D
#


# Gebührenordnung vor dem 01.07.2010 für bestimmte Positionsnummern ungültig machen
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2010-06-30' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('2800','2810','2820');


# Gebührenordnung vor dem 01.01.2013 für fast alle Positionsnummern ungültig machen
# Leistungsgruppe D
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-12-31' where GUELT_VON in ('2010-01-01','2010-07-01','2012-07-01') and GUELT_BIS = '9999-12-31' and Leistungstyp='D';


# Verfallsdatum für einige Positionen (ohne Geburtshilfe) die seit dem 1.1.2013 galten 
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2014-06-30' where POSNR = '2700' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31';


# Verfallsdatum für Positionen (ohne Geburtshilfe) die zum 1.7.2015 erhöht wurden
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2015-06-30' where POSNR = '2700' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31';


# Vergütungsverzeichnis ab 25.9.2015 nach Schiedsspruch
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2015-09-24' where GUELT_VON < DATE('2015-09-25') and GUELT_BIS = '9999-12-31' and Leistungstyp='D';




## Neue Gebührenordnung ab 01.01.2010
# PosNr 2600
#
WWWRUN	INSERT	Leistungsart	POSNR='2600' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2600','D','Überwachung',15.00,'Überwachung, je angefangene halbe Stunde','2010-01-01','2012-12-31','30','','2610','2610','2610',0,'');
#
# PosNr 2601
#
WWWRUN	INSERT	Leistungsart	POSNR='2601' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2601','D','Überwachung Beleghebamme',15.00,'Überwachung, je angefangene halbe Stunde durch Beleghebamme','2010-01-01','2012-12-31','30','','2611','2611','2611',0,'');
#
# PosNr 2602
#
WWWRUN	INSERT	Leistungsart	POSNR='2602' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2602','D','Überwachung Beleghebamme 1:1',15.00,'Überwachung, je angefangene halbe Stunde durch Beleghebamme 1::1','2010-01-01','2012-12-31','30','','2612','2612','2612',0,'');
#
#
# PosNr 2610
#
WWWRUN	INSERT	Leistungsart	POSNR='2610' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2610','D','Überwachung Nacht,Sa,So',18.00,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1','2010-01-01','2012-12-31','30','','','','',0,'');
#
# PosNr 2611
#
WWWRUN	INSERT	Leistungsart	POSNR='2611' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2611','D','Überwachung Nacht,Sa,So Belegheb.',18.00,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','2012-12-31','30','','','','',0,'');
#
# PosNr 2612
#
WWWRUN	INSERT	Leistungsart	POSNR='2612' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2612','D','Überwachung Nacht,Sa,So Belegheb. 1:1',18.00,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-01-01','2012-12-31','30','','','','',0,'');
#
#
# PosNr 2700
#
WWWRUN	INSERT	Leistungsart	POSNR='2700' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2700','D','Rückbildungsgymnastik Gruppe',5.71,'Rückbildungsgymnastik bei Unterweisung in der Gruppe, bis zu zehn Teilnehmerinnen je Gruppe und höchstens zehn Stunden, für jede Teilnehmerin je Unterrichtsstunde (60 Minute)','2010-01-01','2012-12-31','E60','','','','',0,'');
#
#
# PosNr 2800
#
WWWRUN	INSERT	Leistungsart	POSNR='2800' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2800','D','Beratung bei Stillschwierigkeiten',26.52,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings','2010-01-01','2010-06-30',0,'','2810','2810','2810',0,'');
#
#
# PosNr 2810
#
WWWRUN	INSERT	Leistungsart	POSNR='2810' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2810','D','Beratung bei Stillschw. Nacht,Sa,So',31.82,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings mit Zuschlag gemäß §5 Abs. 1','2010-01-01','2010-06-30','','','','','',0,'');
#
# PosNr 2820
#
WWWRUN	INSERT	Leistungsart	POSNR='2820' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2820','D','Zuschlag Zwillinge bei Stillschw.',8.87,'Zuschlag für die Beratung der Mutter bei Stillschwierigkeiten oder Ernührungsproblemen bei Zwillingen und mehr Kindern zu den Gebühren nach 2800 und 2810 für das zweite und jedes weitere Kind, je Kind','2010-01-01','2010-06-30','','','','','',0,'');
#
#
# PosNr 2900
#
WWWRUN	INSERT	Leistungsart	POSNR='2900' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2900','D','Beratung bei Stillschw. per Kommunikationsmedium',5.1,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings mittels Kommunikationsmedium','2010-01-01','2012-12-31','','','','','',0,'');
#
#


## -------- geänderte Posistionsnummern ab 01.07.2010 ---------------------
#
# PosNr 2800
#
WWWRUN	INSERT	Leistungsart	POSNR='2800' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2800','D','Beratung bei Stillschwierigkeiten',27.00,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings','2010-07-01','2012-12-31',0,'','2810','2810','2810',0,'');
#
#
# PosNr 2810
#
WWWRUN	INSERT	Leistungsart	POSNR='2810' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2810','D','Beratung bei Stillschw. Nacht,Sa,So',32.40,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings mit Zuschlag gemäß §5 Abs. 1','2010-07-01','2012-12-31','','','','','',0,'');
#
# PosNr 2820
#
WWWRUN	INSERT	Leistungsart	POSNR='2820' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2820','D','Zuschlag Zwillinge bei Stillschw.',9.30,'Zuschlag für die Beratung der Mutter bei Stillschwierigkeiten oder Ernührungsproblemen bei Zwillingen und mehr Kindern zu den Gebühren nach 2800 und 2810 für das zweite und jedes weitere Kind, je Kind','2010-07-01','2012-12-31','','','','','',0,'');


## Neue Gebührenordnung ab dem 1.1.2013
#
# PosNr 2600
#
WWWRUN	INSERT	Leistungsart	POSNR='2600' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2600','D','Überwachung',16.85,'Überwachung, je angefangene halbe Stunde','2013-01-01','2015-09-24','30','','2610','2610','2610',0,'');
#
# PosNr 2601
#
WWWRUN	INSERT	Leistungsart	POSNR='2601' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2601','D','Überwachung Beleghebamme',16.85,'Überwachung, je angefangene halbe Stunde durch Beleghebamme','2013-01-01','2015-09-24','30','','2611','2611','2611',0,'');
#
# PosNr 2602
#
WWWRUN	INSERT	Leistungsart	POSNR='2602' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2602','D','Überwachung Beleghebamme 1:1',16.85,'Überwachung, je angefangene halbe Stunde durch Beleghebamme 1::1','2013-01-01','2015-09-24','30','','2612','2612','2612',0,'');
#
#
# PosNr 2610
#
WWWRUN	INSERT	Leistungsart	POSNR='2610' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2610','D','Überwachung Nacht,Sa,So',20.22,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1','2013-01-01','2015-09-24','30','','','','',0,'');
#
# PosNr 2611
#
WWWRUN	INSERT	Leistungsart	POSNR='2611' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2611','D','Überwachung Nacht,Sa,So Belegheb.',20.22,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2013-01-01','2015-09-24','30','','','','',0,'');
#
# PosNr 2612
#
WWWRUN	INSERT	Leistungsart	POSNR='2612' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2612','D','Überwachung Nacht,Sa,So Belegheb. 1:1',20.22,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2013-01-01','2015-09-24','30','','','','',0,'');
#
#
# PosNr 2700
#
WWWRUN	INSERT	Leistungsart	POSNR='2700' and GUELT_VON='2013-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2700','D','Rückbildungsgymnastik Gruppe',6.42,'Rückbildungsgymnastik bei Unterweisung in der Gruppe, bis zu zehn Teilnehmerinnen je Gruppe und höchstens zehn Stunden, für jede Teilnehmerin je Unterrichtsstunde (60 Minute)','2013-01-01','2014-06-30','E60','','','','',0,'');
#
#
# PosNr 2800
#
WWWRUN	INSERT	Leistungsart	POSNR='2800' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2800','D','Beratung bei Stillschwierigkeiten',30.33,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings','2013-01-01','2015-09-24',0,'','2810','2810','2810',0,'');
#
#
# PosNr 2810
#
WWWRUN	INSERT	Leistungsart	POSNR='2810' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2810','D','Beratung bei Stillschw. Nacht,Sa,So',36.40,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings mit Zuschlag gemäß §5 Abs. 1','2013-01-01','2015-09-24','','','','','',0,'');
#
# PosNr 2820
#
WWWRUN	INSERT	Leistungsart	POSNR='2820' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2820','D','Zuschlag Zwillinge bei Stillschw.',10.45,'Zuschlag für die Beratung der Mutter bei Stillschwierigkeiten oder Ernührungsproblemen bei Zwillingen und mehr Kindern zu den Gebühren nach 2800 und 2810 für das zweite und jedes weitere Kind, je Kind','2013-01-01','2015-09-24','','','','','',0,'');
#
#
# PosNr 2900
#
WWWRUN	INSERT	Leistungsart	POSNR='2900' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2900','D','Beratung bei Stillschw. per Kommunikationsmedium',5.73,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings mittels Kommunikationsmedium','2013-01-01','2015-09-24','','','','','',0,'');


# Ausgleich der Haftpflichtkostensteigerung (ohne Geburtshilfe) ab 1.7.2014
# Für folgende Positionen erhöht sich die Vergütung auf unbestimmte Zeit:
# - Hilfe bei Beschwerden   (0500-0512)
# - Geburtsvorbereitung     (0700)
# - Wochenbettbetreuung     (1800/1810)
# - Rückbildungsgymnastik   (2700)
#
# Positionsnummern mit neuem Betrag und neuer Gültigkeit einfügen

# PosNr 2700
#
WWWRUN	INSERT	Leistungsart	POSNR='2700' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2700','D','Rückbildungsgymnastik Gruppe',6.47,'Rückbildungsgymnastik bei Unterweisung in der Gruppe, bis zu zehn Teilnehmerinnen je Gruppe und höchstens zehn Stunden, für jede Teilnehmerin je Unterrichtsstunde (60 Minute)','2014-07-01','2015-06-30','E60','','','','',0,'');
#
#


## Anhebung der Vergütung der Positionen 300, 700, 1800, 1810 sowie 2700 zum 1.7.2015
#
# PosNr 2700
#
WWWRUN	INSERT	Leistungsart	POSNR='2700' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2700','D','Rückbildungsgymnastik Gruppe',6.49,'Rückbildungsgymnastik bei Unterweisung in der Gruppe, bis zu zehn Teilnehmerinnen je Gruppe und höchstens zehn Stunden, für jede Teilnehmerin je Unterrichtsstunde (60 Minute)','2015-07-01','2015-09-24','E60','','','','',0,'');
#


## Vergütungsverzeichnis ab 25.9.2015 nach Schiedsspruch
#
# PosNr 2600
#
WWWRUN	INSERT	Leistungsart	POSNR='2600' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2600','D','Überwachung',17.65,'Überwachung, je angefangene halbe Stunde','2015-09-25','9999-12-31','30','','2610','2610','2610',0,'');
#
# PosNr 2601
#
WWWRUN	INSERT	Leistungsart	POSNR='2601' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2601','D','Überwachung Beleghebamme',17.65,'Überwachung, je angefangene halbe Stunde durch Beleghebamme','2015-09-25','9999-12-31','30','','2611','2611','2611',0,'');
#
# PosNr 2602
#
WWWRUN	INSERT	Leistungsart	POSNR='2602' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2602','D','Überwachung Beleghebamme 1:1',17.65,'Überwachung, je angefangene halbe Stunde durch Beleghebamme 1::1','2015-09-25','9999-12-31','30','','2612','2612','2612',0,'');
#
#
# PosNr 2610
#
WWWRUN	INSERT	Leistungsart	POSNR='2610' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2610','D','Überwachung Nacht,Sa,So',21.18,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1','2015-09-25','9999-12-31','30','','','','',0,'');
#
# PosNr 2611
#
WWWRUN	INSERT	Leistungsart	POSNR='2611' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2611','D','Überwachung Nacht,Sa,So Belegheb.',21.18,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2015-09-25','9999-12-31','30','','','','',0,'');
#
# PosNr 2612
#
WWWRUN	INSERT	Leistungsart	POSNR='2612' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2612','D','Überwachung Nacht,Sa,So Belegheb. 1:1',21.18,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2015-09-25','9999-12-31','30','','','','',0,'');
#
#
# PosNr 2700
#
WWWRUN	INSERT	Leistungsart	POSNR='2700' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2700','D','Rückbildungsgymnastik Gruppe',6.80,'Rückbildungsgymnastik bei Unterweisung in der Gruppe, bis zu zehn Teilnehmerinnen je Gruppe und höchstens zehn Stunden, für jede Teilnehmerin je Unterrichtsstunde (60 Minute)','2015-09-25','9999-12-31','E60','','','','',0,'');
#
#
# PosNr 2800
#
WWWRUN	INSERT	Leistungsart	POSNR='2800' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2800','D','Beratung bei Stillschwierigkeiten',31.77,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings','2015-09-25','9999-12-31',0,'','2810','2810','2810',0,'');
#
#
# PosNr 2810
#
WWWRUN	INSERT	Leistungsart	POSNR='2810' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2810','D','Beratung bei Stillschw. Nacht,Sa,So',38.13,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings mit Zuschlag gemäß §5 Abs. 1','2015-09-25','9999-12-31','','','','','',0,'');
#
# PosNr 2820
#
WWWRUN	INSERT	Leistungsart	POSNR='2820' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2820','D','Zuschlag Zwillinge bei Stillschw.',10.95,'Zuschlag für die Beratung der Mutter bei Stillschwierigkeiten oder Ernührungsproblemen bei Zwillingen und mehr Kindern zu den Gebühren nach 2800 und 2810 für das zweite und jedes weitere Kind, je Kind','2015-09-25','9999-12-31','','','','','',0,'');
#
#
# PosNr 2900
#
WWWRUN	INSERT	Leistungsart	POSNR='2900' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2900','D','Beratung bei Stillschw. per Kommunikationsmedium',6.00,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings mittels Kommunikationsmedium','2015-09-25','9999-12-31','','','','','',0,'');



