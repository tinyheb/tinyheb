# Updates für tinyHeb
#
#
#
# neues Feld Lastupdate in Tabelle Leistungsart einführen
#
#ROOT	ALTER	Leistungsart		alter table Leistungsart add LASTUPDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL AFTER NICHT;
#
# LASTUPDATE soll immer auf den aktuellsten Wert gesetzt werden, quasi
# on update current_timestamp
ROOT	ALTER	Leistungsart		alter table Leistungsart CHANGE COLUMN LASTUPDATE LASTUPDATE TIMESTAMP;
#
# PZN auf alpha ändern
#
ROOT	ALTER	Leistungsart		alter table Leistungsart CHANGE COLUMN PZN PZN VARCHAR(10) DEFAULT '';
#
#
# Gebührenordnung vor dem 01.01.2013 für fast alle Positionsnummern ungültig machen
#
# Leistungsgruppe A
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-12-31' where GUELT_VON in ('2010-01-01','2010-07-01') and GUELT_BIS = '9999-12-31' and Leistungstyp='A';
#
# Leistungsgruppe B
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-12-31' where GUELT_VON in ('2010-01-01','2012-07-01') and GUELT_BIS = '9999-12-31' and Leistungstyp='B';
#
# Leistungsgruppe C
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-12-31' where GUELT_VON in ('2010-01-01','2010-07-01','2012-07-01') and GUELT_BIS = '9999-12-31' and Leistungstyp='C';
#
# Leistungsgruppe D
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-12-31' where GUELT_VON in ('2010-01-01','2010-07-01','2012-07-01') and GUELT_BIS = '9999-12-31' and Leistungstyp='D';
#
# Leistungsgruppe M
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-12-31' where GUELT_VON in ('2010-01-01') and GUELT_BIS = '9999-12-31' and POSNR in ('4000') and Leistungstyp='M';
#
# Leistungsgruppe W
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-12-31' where GUELT_VON in ('2010-01-01') and GUELT_BIS = '9999-12-31' and Leistungstyp='W';
#
#
#
#
# zunächst alte GO ungültig machen
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2007-07-31' where GUELT_VON = '2004-01-01' and GUELT_BIS = '9999-12-31';
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2007-07-31' where GUELT_VON = '2006-01-01' and GUELT_BIS = '9999-12-31';
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2009-12-31' where GUELT_VON = '2008-07-01' and GUELT_BIS = '9999-12-31';
#
#
# Gebührenordnung vor dem 01.07.2010 für bestimmte Positionsnummern ungültig machen
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2010-06-30' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('0800','1100','1110','1200','1210','1800','1801','1802','1810','1811','1812','2100','2110','2200','2201','2202','2800','2810','2820');
#
#
# Gebührenordnung vor dem 01.07.2012 für bestimmte Positionsnummern ungültig machen
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-06-30' where GUELT_VON = '2011-06-27' and GUELT_BIS = '9999-12-31' and POSNR in ('0900','0910','0920','0930','0940','0950');
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-06-30' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('0901','0902','0911','0912','1000','1010');
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-06-30' where GUELT_VON = '2010-07-01' and GUELT_BIS = '9999-12-31' and POSNR in ('1100','1110','1200','1210');
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-06-30' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('1600','1601','1602','1610','1611','1612','1700','1701','1702','1710','1711','1712');
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-06-30' where GUELT_VON = '2010-07-01' and GUELT_BIS = '9999-12-31' and POSNR in ('1800','1801','1802','1810','1811','1812','2100','2110');
#
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-06-30' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('2001','2002','2011','2012');
#
#
#
# Gebührenordnung für Materialpauschalen vom 01.01.2010 für bestimmte Posnr ungültig machen
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-07-31' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('3400','3500','3600','3700','3800','3900');
#
#
#
# alte Materialien ungültig machen
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2009-12-31' where GUELT_VON = '2007-08-01' and GUELT_BIS = '9999-12-31';
#
#
# Verfallsdatum für einige Positionen (mit Geburtshilfe) die seit dem 01.01.2013 galten
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2013-12-31' where GUELT_VON = '2013-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('0901','0902','0911','0912','1000','1010','1100','1110','1200','1210','1600','1601','1602','1610','1611','1612','1700','1701','1702','1710','1711','1712');
#
# Verfallsdatum für einige Positionen (ohne Geburtshilfe) die seit dem 1.1.2013 galten 
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2014-06-30' where POSNR in ('0500', '0501', '0502', '0510', '0511', '0512', '0700', '1800', '1810', '2700') and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31';
#
#
#
## Verfallsdatum für Positionen (ohne Geburtshilfe) die zum 1.7.2015 erhöht wurden
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2015-06-30' where POSNR in ('0700', '1800', '1810', '2700') and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31';
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2015-06-30' where POSNR in ('0300') and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31';
#
#
## Anhebung der Vergütung der Positionen 300, 700, 1800, 1810 sowie 2700 zum 1.7.2015
#
# PosNr 0300
#
WWWRUN	INSERT	Leistungsart	POSNR='0300' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0300','A','Vorsorgeuntersuchung',25.23,'Vorsorgeuntersuchung der Schwangeren nach Maßgabe der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung in der jeweils geltenden Fassung','2015-07-01','9999-12-31',0,'+3400');
#
# Posnr 0700
#
WWWRUN	INSERT	Leistungsart	POSNR='0700' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0700','A','Geburtsvorbereitung in der Gruppe',6.49,'Geburtsvorbereitung bei Unterweisung in der Gruppe, bis zu zehn Schwangere je Gruppe und höchsten 14 Stunden, für jede Schwangere je Unterrichtsstunden (60 Minuten)','2015-07-01','9999-12-31','E60','','','','',0);
#
# PosNr. 1800
#
WWWRUN	INSERT	Leistungsart	POSNR='1800' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1800','C','Wochenbettbetreuung',31.38,'aufsuchende Wochenbettbetreuung nach der Geburt','2015-07-01','9999-12-31',0,'','1810','1810','1810',0,'+1900');
#
# PosNr. 1810
#
WWWRUN	INSERT	Leistungsart	POSNR='1810' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1810','C','Wochenbettbetreuung Nacht,Sa,So',37.61,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2015-07-01','9999-12-31',0,'','','','',0,'+1900');
#
# PosNr 2700
#
WWWRUN	INSERT	Leistungsart	POSNR='2700' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2700','D','Rückbildungsgymnastik Gruppe',6.49,'Rückbildungsgymnastik bei Unterweisung in der Gruppe, bis zu zehn Teilnehmerinnen je Gruppe und höchstens zehn Stunden, für jede Teilnehmerin je Unterrichtsstunde (60 Minute)','2015-07-01','9999-12-31','E60','','','','',0,'');
#
#
## die bis zum 30.6.2015 befristeten Haftpflichtzulagen mit kleineren Werten unbefristet fortführen...
#
# PosNr 0991
#
WWWRUN	INSERT	Leistungsart	POSNR='0991' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'0991','B','Haftpflichtzulage Geburt im Krankenhaus Belegheb.',8.81,'Haftpflichtzulage für eine Geburt ab dem 01.07.2015 im Krankenhaus als Beleghebamme','2015-07-01','9999-12-31',0);
#
# PosNr 0992
#
WWWRUN	INSERT	Leistungsart	POSNR='0992' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'0992','B','Haftpflichtzulage Geburt im Krankenhaus Belegheb. 1:1',20.00,'Haftpflichtzulage für eine Geburt ab dem 01.07.2015 im Krankenhaus als Beleghebamme 1:1','2015-07-01','9999-12-31',0);
#
# PosNr 1090
#
WWWRUN	INSERT	Leistungsart	POSNR='1090' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1090','B','Haftpflichtzulage Geburt außerkl. ärztl. Leitung',10.00,'Haftpflichtzulage für eine außerklinische Geburt ab dem 01.07.2015 in einer Einrichtung unter ärztlicher Leitung','2015-07-01','9999-12-31',0);
#
# PosNr 1190
#
WWWRUN	INSERT	Leistungsart	POSNR='1190' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1190','B','Haftpflichtzulage Geburt außerkl. Leitung Hebammen',32.00,'Haftpflichtzulage für eine außerklinische Geburt ab dem 01.07.2015 in einer von Hebammen geleiteten Einrichtung','2015-07-01','9999-12-31',0);
#
# PosNr 1290
#
WWWRUN	INSERT	Leistungsart	POSNR='1290' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1290','B','Haftpflichtzulage Hausgeburt',100.00,'Haftpflichtzulage für eine Hausgeburt ab dem 01.07.2015','2015-07-01','9999-12-31',0);
#
# PosNr 1690
#
WWWRUN	INSERT	Leistungsart	POSNR='1690' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1690','B','Haftpflichtzulage unvollendete Geburt',10.00,'Haftpflichtzulage für Hilfe bei einer nicht vollendeten Geburt ab dem 01.07.2015 als ambulante Leistung','2015-07-01','9999-12-31',0);
#
# PosNr 1691
#
WWWRUN	INSERT	Leistungsart	POSNR='1691' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1691','B','Haftpflichtzulage unvollendete Geburt Beleghebamme',10.00,'Haftpflichtzulage für Hilfe bei einer nicht vollendeten Geburt ab dem 01.07.2015 als Beleghebamme','2015-07-01','9999-12-31',0);
#
# PosNr 1692
#
WWWRUN	INSERT	Leistungsart	POSNR='1692' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1692','B','Haftpflichtzulage unvollendete Geburt Beleghebamme 1:1',10.00,'Haftpflichtzulage für Hilfe bei einer nicht vollendeten Geburt ab dem 01.07.2015 als Beleghebamme in einer 1:1 Betreuung','2015-07-01','9999-12-31',0);
#
# PosNr 1790
#
WWWRUN	INSERT	Leistungsart	POSNR='1790' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1790','B','Haftpflichtzulage 2. Hebamme',3.00,'Haftpflichtzulage für Hilfe bei einer außerklinischen Geburt oder Fehlgeburt ab dem 01.07.2015 durch eine zweite Hebamme, für jede angefangene halbe Stunde als ambulante Leistung','2015-07-01','9999-12-31',0);
#
# PosNr 1791
#
WWWRUN	INSERT	Leistungsart	POSNR='1791' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1791','B','Haftpflichtzulage 2. Hebamme Beleghebamme',3.00,'Haftpflichtzulage für Hilfe bei einer klinischen Geburt oder Fehlgeburt ab dem 01.07.2015 durch eine zweite Hebamme, für jede angefangene halbe Stunde als Beleghebamme','2015-07-01','9999-12-31',0);
#
# PosNr 1792
#
WWWRUN	INSERT	Leistungsart	POSNR='1792' and GUELT_VON='2015-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1792','B','Haftpflichtzulage 2. Hebamme Belegheb. 1:1',3.00,'Haftpflichtzulage für Hilfe bei einer klinischen Geburt oder Fehlgeburt ab dem 01.07.2015 durch eine zweite Hebamme, für jede angefangene halbe Stunde als Beleghebamme in einer 1:1 Betreuung','2015-07-01','9999-12-31',0);
#
##
#
# Ausgleich der Haftpflichtkostensteigerung (ohne Geburtshilfe) ab 1.7.2014
# Für folgende Positionen erhöht sich die Vergütung auf unbestimmte Zeit:
# - Hilfe bei Beschwerden   (0500-0512)
# - Geburtsvorbereitung     (0700)
# - Wochenbettbetreuung     (1800/1810)
# - Rückbildungsgymnastik   (2700)
#
# Positionsnummern mit neuem Betrag und neuer Gültigkeit einfügen
#
# PosNr 0500
#
WWWRUN	INSERT	Leistungsart	POSNR='0500' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0500','A','Hilfe bei Beschw.',16.89,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten','2014-07-01','9999-12-31',30,'+3500','0510','0510','0510',180);
#
#
# PosNr 0501
#
WWWRUN	INSERT	Leistungsart	POSNR='0501' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0501','A','Hilfe bei Beschw. Belegheb.',16.89,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten Beleghebamme','2014-07-01','9999-12-31',30,'+3500','0511','0511','0511',180);
#
# PosNr 0502
#
WWWRUN	INSERT	Leistungsart	POSNR='0502' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0502','A','Hilfe bei Beschw. Belegheb. 1:1',16.89,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten Beleghebamme 1:1','2014-07-01','9999-12-31',30,'+3500','0512','0512','0512',180);
#
#
# PosNr 0510
#
WWWRUN	INSERT	Leistungsart	POSNR='0510' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0510','A','Hilfe bei Beschw. Sa,So,Nacht',20.26,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1','2014-07-01','9999-12-31',30,'+3500','','','',180);
#
#
# PosNr 0511
#
WWWRUN	INSERT	Leistungsart	POSNR='0511' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0511','A','Hilfe bei Beschw. Sa,So,Nacht Belegheb.',20.26,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-07-01','9999-12-31',30,'+3500','','','',180);
#
# PosNr 0512
#
WWWRUN	INSERT	Leistungsart	POSNR='0512' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0512','A','Hilfe bei Beschw. Sa,So,Nacht Belegheb. 1:1',20.26,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2014-07-01','9999-12-31',30,'+3500','','','',180);
#
# Posnr 0700
#
WWWRUN	INSERT	Leistungsart	POSNR='0700' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0700','A','Geburtsvorbereitung in der Gruppe',6.47,'Geburtsvorbereitung bei Unterweisung in der Gruppe, bis zu zehn Schwangere je Gruppe und höchsten 14 Stunden, für jede Schwangere je Unterrichtsstunden (60 Minuten)','2014-07-01','9999-12-31','E60','','','','',0);
#
# PosNr. 1800
#
WWWRUN	INSERT	Leistungsart	POSNR='1800' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1800','C','Wochenbettbetreuung',31.35,'aufsuchende Wochenbettbetreuung nach der Geburt','2014-07-01','9999-12-31',0,'','1810','1810','1810',0,'+1900');
#
# PosNr. 1810
#
WWWRUN	INSERT	Leistungsart	POSNR='1810' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1810','C','Wochenbettbetreuung Nacht,Sa,So',37.58,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2014-07-01','9999-12-31',0,'','','','',0,'+1900');
#
# PosNr 2700
#
WWWRUN	INSERT	Leistungsart	POSNR='2700' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2700','D','Rückbildungsgymnastik Gruppe',6.47,'Rückbildungsgymnastik bei Unterweisung in der Gruppe, bis zu zehn Teilnehmerinnen je Gruppe und höchstens zehn Stunden, für jede Teilnehmerin je Unterrichtsstunde (60 Minute)','2014-07-01','9999-12-31','E60','','','','',0,'');
#
#
#
# Anhebung der Gebühren für die Zeit vom 1.1.14 bis zum 30.06.14
#
# PosNr 0901
#
WWWRUN	INSERT	Leistungsart	POSNR='0901' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0901','B','Geburt im Krankenhaus Belegheb.',276.22,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme','2014-01-01','2014-06-30',0,'','0911','0911','0911',0);
#
# PosNr 0902
#
WWWRUN	INSERT	Leistungsart	POSNR='0902' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0902','B','Geburt im Krankenhaus Belegheb. 1:1',292.97,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme 1:1','2014-01-01','2014-06-30',0,'','0912','0912','0912',0);
#
# PosNr 0911
#
WWWRUN	INSERT	Leistungsart	POSNR='0911' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0911','B','Geburt im K-Haus, Nacht,Sa,So Belegheb.',329.67,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-01-01','2014-06-30',0,'','','','',0);
#
# PosNr 0912
#
WWWRUN	INSERT	Leistungsart	POSNR='0912' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0912','B','Geburt im K-Haus, Nacht,Sa,So Belegheb. 1:1',346.42,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2014-01-01','2014-06-30',0,'','','','',0);
#
# PosNr 1000
#
WWWRUN	INSERT	Leistungsart	POSNR='1000' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1000','B','Geburt außerkl. ärztl. Leitung',276.22,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung','2014-01-01','2014-06-30',0,'+3600','1010','1010','1010',0);
#
# PosNr 1010
#
WWWRUN	INSERT	Leistungsart	POSNR='1010' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1010','B','Geburt außerkl. ärztl. Leitung, Nacht,Sa,So',329.67,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2014-01-01','2014-06-30',0,'+3600','','','',0);
#
# PosNr 1100
#
WWWRUN	INSERT	Leistungsart	POSNR='1100' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1100','B','Geburt außerkl. Leitung Hebammen',563.25,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung','2014-01-01','2014-06-30',0,'+3600','1110','1110','1110',0);
#
# PosNr 1110
#
WWWRUN	INSERT	Leistungsart	POSNR='1110' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1110','B','Geburt außerkl. Leitung Hebammen Nacht,Sa,So',668.23,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung mit Zuschlag gemäß §5 Abs. 1','2014-01-01','2014-06-30',0,'+3600','','','',0);
#
# PosNr 1200
#
WWWRUN	INSERT	Leistungsart	POSNR='1200' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1200','B','Hilfe bei Hausgeburt',707.33,'Hilfe bei Hausgeburt','2014-01-01','2014-06-30',0,'+3600','1210','1210','1210',0);
#
# PosNr 1210
#
WWWRUN	INSERT	Leistungsart	POSNR='1210' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1210','B','Hilfe bei Hausgeburt Nacht,Sa,So',830.64,'Hilfe bei Hausgeburt mit Zuschlag gemäß §5 Abs. 1','2014-01-01','2014-06-30',0,'+3600','','','',0);
#
# PosNr 1600
#
WWWRUN	INSERT	Leistungsart	POSNR='1600' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1600','B','Hilfe bei nicht vollendeter Geburt',209.14,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung','2014-01-01','2014-06-30',0,'+3600','1610','1610','1610',0);
#
# PosNr 1601
#
WWWRUN	INSERT	Leistungsart	POSNR='1601' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1601','B','Hilfe bei nicht vollendeter Geb. Belegheb.',209.14,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2014-01-01','2014-06-30',0,'','1611','1611','1611',0);
#
# PosNr 1602
#
WWWRUN	INSERT	Leistungsart	POSNR='1602' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1602','B','Hilfe bei nicht vollendeter Geb. Belegheb. 1:1',209.14,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2014-01-01','2014-06-30',0,'','1612','1612','1612',0);
#
# PosNr 1610
#
WWWRUN	INSERT	Leistungsart	POSNR='1610' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1610','B','Hilfe bei nicht vollendeter Geburt Nacht,Sa,So',247.97,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2014-01-01','2014-06-30',0,'+3600','','','',0);
#
# PosNr 1611
#
WWWRUN	INSERT	Leistungsart	POSNR='1611' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1611','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb.',247.97,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-01-01','2014-06-30',0,'','','','',0);
#
# PosNr 1612
#
WWWRUN	INSERT	Leistungsart	POSNR='1612' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1612','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb. 1:1',247.97,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2014-01-01','2014-06-30',0,'','','','',0);
#
# PosNr. 1700
#
WWWRUN	INSERT	Leistungsart	POSNR='1700' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1700','B','2. Hebamme',29.64,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2014-01-01','2014-06-30','30','','1710','1710','1710',240);
#
# PosNr. 1701
#
WWWRUN	INSERT	Leistungsart	POSNR='1701' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1701','B','2. Hebamme Beleghebamme',29.64,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2014-01-01','2014-06-30','30','','1711','1711','1711',240);
#
# PosNr. 1702
#
WWWRUN	INSERT	Leistungsart	POSNR='1702' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1702','B','2. Hebamme Beleghebamme 1:1',29.64,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2014-01-01','2014-06-30','30','','1712','1712','1712',240);
#
# PosNr. 1710
#
WWWRUN	INSERT	Leistungsart	POSNR='1710' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1710','B','2. Hebamme Nacht,Sa,So',34.27,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1','2014-01-01','2014-06-30','30','','','','',240);
#
# PosNr. 1711
#
WWWRUN	INSERT	Leistungsart	POSNR='1711' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1711','B','2. Hebamme Nacht,Sa,So Belegheb.',34.27,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-01-01','2014-06-30','30','','','','',240);
#
# PosNr. 1712
#
WWWRUN	INSERT	Leistungsart	POSNR='1712' and GUELT_VON='2014-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1712','B','2. Hebamme Nacht,Sa,So Belegheb. 1:1',34.27,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-01-01','2014-06-30','30','','','','',240);
#
#
# Neue Positionsnummern "Haftpflichtzulagen" für Geburtshilfe von 1.7.2014-30.06.2015
#
# PosNr 0991
#
WWWRUN	INSERT	Leistungsart	POSNR='0991' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'0991','B','Haftpflichtzulage Geburt im Krankenhaus Belegheb.',8.81,'Haftpflichtzulage für eine Geburt zwischen dem 01.07.2014 und dem 30.06.2015 im Krankenhaus als Beleghebamme','2014-07-01','2015-06-30',0);
#
# PosNr 0992
#
WWWRUN	INSERT	Leistungsart	POSNR='0992' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'0992','B','Haftpflichtzulage Geburt im Krankenhaus Belegheb. 1:1',30.00,'Haftpflichtzulage für eine Geburt zwischen dem 01.07.2014 und dem 30.06.2015 im Krankenhaus als Beleghebamme 1:1','2014-07-01','2015-06-30',0);
#
# PosNr 1090
#
WWWRUN	INSERT	Leistungsart	POSNR='1090' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1090','B','Haftpflichtzulage Geburt außerkl. ärztl. Leitung',11.00,'Haftpflichtzulage für eine außerklinische Geburt zwischen dem 01.07.2014 und dem 30.06.2015 in einer Einrichtung unter ärztlicher Leitung','2014-07-01','2015-06-30',0);
#
# PosNr 1190
#
WWWRUN	INSERT	Leistungsart	POSNR='1190' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1190','B','Haftpflichtzulage Geburt außerkl. Leitung Hebammen',68.00,'Haftpflichtzulage für eine außerklinische Geburt zwischen dem 01.07.2014 und dem 30.06.2015 in einer von Hebammen geleiteten Einrichtung','2014-07-01','2015-06-30',0);
#
# PosNr 1290
#
WWWRUN	INSERT	Leistungsart	POSNR='1290' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1290','B','Haftpflichtzulage Hausgeburt',132.00,'Haftpflichtzulage für eine Hausgeburt zwischen dem 01.07.2014 und dem 30.06.2015','2014-07-01','2015-06-30',0);
#
# PosNr 1690
#
WWWRUN	INSERT	Leistungsart	POSNR='1690' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1690','B','Haftpflichtzulage unvollendete Geburt',17.00,'Haftpflichtzulage für Hilfe bei einer nicht vollendeten Geburt zwischen dem 01.07.2014 und dem 30.06.2015 als ambulante Leistung','2014-07-01','2015-06-30',0);
#
# PosNr 1691
#
WWWRUN	INSERT	Leistungsart	POSNR='1691' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1691','B','Haftpflichtzulage unvollendete Geburt Beleghebamme',10.00,'Haftpflichtzulage für Hilfe bei einer nicht vollendeten Geburt zwischen dem 01.07.2014 und dem 30.06.2015 als Beleghebamme','2014-07-01','2015-06-30',0);
#
# PosNr 1692
#
WWWRUN	INSERT	Leistungsart	POSNR='1692' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1692','B','Haftpflichtzulage unvollendete Geburt Beleghebamme 1:1',17.00,'Haftpflichtzulage für Hilfe bei einer nicht vollendeten Geburt zwischen dem 01.07.2014 und dem 30.06.2015 als Beleghebamme in einer 1:1 Betreuung','2014-07-01','2015-06-30',0);
#
# PosNr 1790
#
WWWRUN	INSERT	Leistungsart	POSNR='1790' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1790','B','Haftpflichtzulage 2. Hebamme',5.00,'Haftpflichtzulage für Hilfe bei einer außerklinischen Geburt oder Fehlgeburt zwischen dem 01.07.2014 und dem 30.06.2015 durch eine zweite Hebamme, für jede angefangene halbe Stunde als ambulante Leistung','2014-07-01','2015-06-30',0);
#
# PosNr 1791
#
WWWRUN	INSERT	Leistungsart	POSNR='1791' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1791','B','Haftpflichtzulage 2. Hebamme Beleghebamme',3.00,'Haftpflichtzulage für Hilfe bei einer klinischen Geburt oder Fehlgeburt zwischen dem 01.07.2014 und dem 30.06.2015 durch eine zweite Hebamme, für jede angefangene halbe Stunde als Beleghebamme','2014-07-01','2015-06-30',0);
#
# PosNr 1792
#
WWWRUN	INSERT	Leistungsart	POSNR='1792' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1792','B','Haftpflichtzulage 2. Hebamme Belegheb. 1:1',5.00,'Haftpflichtzulage für Hilfe bei einer klinischen Geburt oder Fehlgeburt zwischen dem 01.07.2014 und dem 30.06.2015 durch eine zweite Hebamme, für jede angefangene halbe Stunde als Beleghebamme in einer 1:1 Betreuung','2014-07-01','2015-06-30',0);
#
#
# Anpassung mit Haftpflichtzulagen für Geburtshilfe ab 1.7.2014
#
# PosNr 0901
#
WWWRUN	INSERT	Leistungsart	POSNR='0901' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0901','B','Geburt im Krankenhaus Belegheb.',275.22,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme','2014-07-01','9999-12-31',0,'+0991','0911','0911','0911',0);
#
# PosNr 0902
#
WWWRUN	INSERT	Leistungsart	POSNR='0902' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0902','B','Geburt im Krankenhaus Belegheb. 1:1',288.72,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme 1:1','2014-07-01','9999-12-31',0,'+0992','0912','0912','0912',0);
#
# PosNr 0911
#
WWWRUN	INSERT	Leistungsart	POSNR='0911' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0911','B','Geburt im K-Haus, Nacht,Sa,So Belegheb.',328.67,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-07-01','9999-12-31',0,'+0991','','','',0);
#
# PosNr 0912
#
WWWRUN	INSERT	Leistungsart	POSNR='0912' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0912','B','Geburt im K-Haus, Nacht,Sa,So Belegheb. 1:1',342.17,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2014-07-01','9999-12-31',0,'+0992','','','',0);
#
# PosNr 1000
#
WWWRUN	INSERT	Leistungsart	POSNR='1000' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1000','B','Geburt außerkl. ärztl. Leitung',275.22,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung','2014-07-01','9999-12-31',0,'+3600','+1090','1010','1010','1010',0);
#
# PosNr 1010
#
WWWRUN	INSERT	Leistungsart	POSNR='1010' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1010','B','Geburt außerkl. ärztl. Leitung, Nacht,Sa,So',328.67,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2014-07-01','9999-12-31',0,'+3600','+1090','','','',0);
#
# PosNr 1100
#
WWWRUN	INSERT	Leistungsart	POSNR='1100' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1100','B','Geburt außerkl. Leitung Hebammen',559.00,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung','2014-07-01','9999-12-31',0,'+3600','+1190','1110','1110','1110',0);
#
# PosNr 1110
#
WWWRUN	INSERT	Leistungsart	POSNR='1110' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1110','B','Geburt außerkl. Leitung Hebammen Nacht,Sa,So',663.98,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung mit Zuschlag gemäß §5 Abs. 1','2014-07-01','9999-12-31',0,'+3600','+1190','','','',0);
#
# PosNr 1200
#
WWWRUN	INSERT	Leistungsart	POSNR='1200' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1200','B','Hilfe bei Hausgeburt',703.08,'Hilfe bei Hausgeburt','2014-07-01','9999-12-31',0,'+3600','+1290','1210','1210','1210',0);
#
# PosNr 1210
#
WWWRUN	INSERT	Leistungsart	POSNR='1210' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1210','B','Hilfe bei Hausgeburt Nacht,Sa,So',826.39,'Hilfe bei Hausgeburt mit Zuschlag gemäß §5 Abs. 1','2014-07-01','9999-12-31',0,'+3600','+1290','','','',0);
#
# PosNr 1600
#
WWWRUN	INSERT	Leistungsart	POSNR='1600' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1600','B','Hilfe bei nicht vollendeter Geburt',208.14,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung','2014-07-01','9999-12-31',0,'+3600','+1690','1610','1610','1610',0);
#
# PosNr 1601
#
WWWRUN	INSERT	Leistungsart	POSNR='1601' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1601','B','Hilfe bei nicht vollendeter Geb. Belegheb.',208.14,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2014-07-01','9999-12-31',0,'+1691','1611','1611','1611',0);
#
# PosNr 1602
#
WWWRUN	INSERT	Leistungsart	POSNR='1602' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1602','B','Hilfe bei nicht vollendeter Geb. Belegheb. 1:1',208.14,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2014-07-01','9999-12-31',0,'+1692','1612','1612','1612',0);
#
# PosNr 1610
#
WWWRUN	INSERT	Leistungsart	POSNR='1610' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1610','B','Hilfe bei nicht vollendeter Geburt Nacht,Sa,So',246.97,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2014-07-01','9999-12-31',0,'+3600','+1690','','','',0);
#
# PosNr 1611
#
WWWRUN	INSERT	Leistungsart	POSNR='1611' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1611','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb.',246.97,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-07-01','9999-12-31',0,'+1691','','','',0);
#
# PosNr 1612
#
WWWRUN	INSERT	Leistungsart	POSNR='1612' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1612','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb. 1:1',246.97,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2014-07-01','9999-12-31',0,'+1692','','','',0);
#
# PosNr. 1700
#
WWWRUN	INSERT	Leistungsart	POSNR='1700' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1700','B','2. Hebamme',29.14,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2014-07-01','9999-12-31','30','','+1790','1710','1710','1710',240);
#
# PosNr. 1701
#
WWWRUN	INSERT	Leistungsart	POSNR='1701' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1701','B','2. Hebamme Beleghebamme',29.14,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2014-07-01','9999-12-31','30','','+1791','1711','1711','1711',240);
#
# PosNr. 1702
#
WWWRUN	INSERT	Leistungsart	POSNR='1702' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1702','B','2. Hebamme Beleghebamme 1:1',29.14,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2014-07-01','9999-12-31','30','','+1792','1712','1712','1712',240);
#
# PosNr. 1710
#
WWWRUN	INSERT	Leistungsart	POSNR='1710' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1710','B','2. Hebamme Nacht,Sa,So',33.77,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1','2014-07-01','9999-12-31','30','','+1790','','','',240);
#
# PosNr. 1711
#
WWWRUN	INSERT	Leistungsart	POSNR='1711' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1711','B','2. Hebamme Nacht,Sa,So Belegheb.',33.77,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-07-01','9999-12-31','30','','+1791','','','',240);
#
# PosNr. 1712
#
WWWRUN	INSERT	Leistungsart	POSNR='1712' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1712','B','2. Hebamme Nacht,Sa,So Belegheb. 1:1',33.77,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-07-01','9999-12-31','30','','+1792','','','',240);
#
#
#
# Neue Gebührenordnung ab 01.01.2013
#
# Leistungen der Mutterschaftsvorsorge und Schwangerenbetreuung
# Leistungsgruppe A
#
# PosNr 0100
#
WWWRUN	INSERT	Leistungsart	POSNR='0100' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0100','A','Beratung',6.53,'Beratung der Schwangeren, auch mittels Kommunikationsmedium','2013-01-01','9999-12-31');
#
#
# PosNr 0101
#
WWWRUN	INSERT	Leistungsart	POSNR='0101' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0101','A','Beratung Beleghebamme',6.53,'Beratung der Schwangeren, auch mittels Kommunikationsmedium durch Beleghebamme','2013-01-01','9999-12-31');
#
#
# PosNr 0102
#
WWWRUN	INSERT	Leistungsart	POSNR='0102' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0102','A','Beratung Beleghebamme 1:1',6.53,'Beratung der Schwangeren, auch mittels Kommunikationsmedium durch Beleghebamme bei 1:1 Betreuung','2013-01-01','9999-12-31');
#
#
#
#
# PosNr 0200
#
WWWRUN	INSERT	Leistungsart	POSNR='0200' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'0200','A','Vorgespräch',8.43,'Vorgespräch über Fragen der Schwangerschaft und Geburt,mindestens 30 Minuten, je angefangene 15 Minuten','2013-01-01','9999-12-31',15);
#
#
#
# PosNr 0300
#
WWWRUN	INSERT	Leistungsart	POSNR='0300' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0300','A','Vorsorgeuntersuchung',25.21,'Vorsorgeuntersuchung der Schwangeren nach Maßgabe der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung in der jeweils geltenden Fassung','2013-01-01','9999-12-31',0,'+3400');
#
#
# PosNr 0400
#
WWWRUN	INSERT	Leistungsart	POSNR='0400' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0400','A','Entnahme von Körpermaterial',6.42,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung','2013-01-01','9999-12-31',0,'');
#
#
# PosNr 0401
#
WWWRUN	INSERT	Leistungsart	POSNR='0401' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0401','A','Entnahme von Körpermaterial Belegheb.',6.42,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung durch Beleghebamme','2013-01-01','9999-12-31',0,'');
#
# PosNr 402
#
WWWRUN	INSERT	Leistungsart	POSNR='0402' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0402','A','Entnahme von Körpermaterial Belegheb. 1:1',6.42,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung durch Beleghebamme 1:1','2013-01-01','9999-12-31',0,'');
#
#
# PosNr 0500
#
WWWRUN	INSERT	Leistungsart	POSNR='0500' and GUELT_VON='2013-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0500','A','Hilfe bei Beschw.',16.85,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten','2013-01-01','2014-06-30',30,'+3500','0510','0510','0510',180);
#
#
# PosNr 0501
#
WWWRUN	INSERT	Leistungsart	POSNR='0501' and GUELT_VON='2013-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0501','A','Hilfe bei Beschw. Belegheb.',16.85,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten Beleghebamme','2013-01-01','2014-06-30',30,'+3500','0511','0511','0511',180);
#
# PosNr 0502
#
WWWRUN	INSERT	Leistungsart	POSNR='0502' and GUELT_VON='2013-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0502','A','Hilfe bei Beschw. Belegheb. 1:1',16.85,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten Beleghebamme 1:1','2013-01-01','2014-06-30',30,'+3500','0512','0512','0512',180);
#
#
# PosNr 0510
#
WWWRUN	INSERT	Leistungsart	POSNR='0510' and GUELT_VON='2013-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0510','A','Hilfe bei Beschw. Sa,So,Nacht',20.22,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1','2013-01-01','2014-06-30',30,'+3500','','','',180);
#
#
# PosNr 0511
#
WWWRUN	INSERT	Leistungsart	POSNR='0511' and GUELT_VON='2013-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0511','A','Hilfe bei Beschw. Sa,So,Nacht Belegheb.',20.22,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2013-01-01','2014-06-30',30,'+3500','','','',180);
#
# PosNr 0512
#
WWWRUN	INSERT	Leistungsart	POSNR='0512' and GUELT_VON='2013-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0512','A','Hilfe bei Beschw. Sa,So,Nacht Belegheb. 1:1',20.22,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2013-01-01','2014-06-30',30,'+3500','','','',180);
#
#
# PosNr 0600
#
WWWRUN	INSERT	Leistungsart	POSNR='0600' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0600','A','CTG Überwachung',7.22,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung.','2013-01-01','9999-12-31',0,'','','','',0);
#
#
# PosNr 0601
#
WWWRUN	INSERT	Leistungsart	POSNR='0601' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0601','A','CTG Überwachung Belegheb.',7.22,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung. Beleghebamme','2013-01-01','9999-12-31',0,'','','','',0);
#
#
# PosNr 0602
#
WWWRUN	INSERT	Leistungsart	POSNR='0602' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0602','A','CTG Überwachung Belegheb. 1:1',7.22,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung. Beleghebamme 1:1','2013-01-01','9999-12-31',0,'','','','',0);
#
#
# Posnr 0700
#
WWWRUN	INSERT	Leistungsart	POSNR='0700' and GUELT_VON='2013-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0700','A','Geburtsvorbereitung in der Gruppe',6.42,'Geburtsvorbereitung bei Unterweisung in der Gruppe, bis zu zehn Schwangere je Gruppe und höchsten 14 Stunden, für jede Schwangere je Unterrichtsstunden (60 Minuten)','2013-01-01','2014-06-30','E60','','','','',0);
#
#
# Posnr 0800
WWWRUN	INSERT	Leistungsart	POSNR='0800' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,BEGRUENDUNGSPFLICHT) values (9999,'0800','A','Einzelgeburtsvorbereitung',8.43,'Geburtsvorbereitung bei Einzelunterweisung auf ärztliche Anordnung höchstens 28 Unterrichtseinheiten a 15 Minuten, für jede angefangenen 15 Minuten','2013-01-01','9999-12-31','15','','','','',0,'J');
#
#
# -------------Geburtshilfe ---------------------
#
# Leistungen Geburtshilfe
# Leistungsgruppe B
#
# PosNr 0901
#
WWWRUN	INSERT	Leistungsart	POSNR='0901' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0901','B','Geburt im Krankenhaus Belegheb.',273.22,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme','2013-01-01','2013-12-31',0,'','0911','0911','0911',0);
#
# PosNr 0902
#
WWWRUN	INSERT	Leistungsart	POSNR='0902' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0902','B','Geburt im Krankenhaus Belegheb. 1:1',280.22,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme 1:1','2013-01-01','2013-12-31',0,'','0912','0912','0912',0);
#
#
#
# PosNr 0911
#
WWWRUN	INSERT	Leistungsart	POSNR='0911' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0911','B','Geburt im K-Haus, Nacht,Sa,So Belegheb.',326.67,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2013-01-01','2013-12-31',0,'','','','',0);
#
#
# PosNr 0912
#
WWWRUN	INSERT	Leistungsart	POSNR='0912' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0912','B','Geburt im K-Haus, Nacht,Sa,So Belegheb. 1:1',333.67,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2013-01-01','2013-12-31',0,'','','','',0);
#
#
# PosNr 1000
#
WWWRUN	INSERT	Leistungsart	POSNR='1000' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1000','B','Geburt außerkl. ärztl. Leitung',273.22,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung','2013-01-01','2013-12-31',0,'+3600','1010','1010','1010',0);
#
# PosNr 1010
#
WWWRUN	INSERT	Leistungsart	POSNR='1010' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1010','B','Geburt außerkl. ärztl. Leitung, Nacht,Sa,So',326.67,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2013-01-01','2013-12-31',0,'+3600','','','',0);
#
# PosNr 1100
#
WWWRUN	INSERT	Leistungsart	POSNR='1100' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1100','B','Geburt außerkl. Leitung Hebammen',550.50,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung','2013-01-01','2013-12-31',0,'+3600','1110','1110','1110',0);
#
# PosNr 1110
#
WWWRUN	INSERT	Leistungsart	POSNR='1110' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1110','B','Geburt außerkl. Leitung Hebammen Nacht,Sa,So',655.48,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung mit Zuschlag gemäß §5 Abs. 1','2013-01-01','2013-12-31',0,'+3600','','','',0);
#
# PosNr 1200
#
WWWRUN	INSERT	Leistungsart	POSNR='1200' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1200','B','Hilfe bei Hausgeburt',694.58,'Hilfe bei Hausgeburt','2013-01-01','2013-12-31',0,'+3600','1210','1210','1210',0);
#
# PosNr 1210
#
WWWRUN	INSERT	Leistungsart	POSNR='1210' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1210','B','Hilfe bei Hausgeburt Nacht,Sa,So',817.89,'Hilfe bei Hausgeburt mit Zuschlag gemäß §5 Abs. 1','2013-01-01','2013-12-31',0,'+3600','','','',0);
#
# PosNr 1300
#
WWWRUN	INSERT	Leistungsart	POSNR='1300' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1300','B','Hilfe bei Fehlgeburt',179.76,'Hilfe bei einer Fehlgeburt','2013-01-01','9999-12-31',0,'+3600','1310','1310','1310',0);
#
# PosNr 1301
#
WWWRUN	INSERT	Leistungsart	POSNR='1301' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1301','B','Hilfe bei Fehlgeburt Belegheb.',179.76,'Hilfe bei einer Fehlgeburt Beleghebamme','2013-1-01','9999-12-31',0,'+3600','1311','1311','1311',0);
#
#
# PosNr 1302
#
WWWRUN	INSERT	Leistungsart	POSNR='1302' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1302','B','Hilfe bei Fehlgeburt Belegheb. 1:1',179.76,'Hilfe bei einer Fehlgeburt Beleghebamme 1:1','2013-01-01','9999-12-31',0,'+3600','1312','1312','1312',0);
#
#
# PosNr 1310
#
WWWRUN	INSERT	Leistungsart	POSNR='1310' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1310','B','Hilfe bei Fehlgeburt Nacht,Sa,So',215.71,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1','2013-01-01','9999-12-31',0,'+3600','','','',0);
#
# PosNr 1311
#
WWWRUN	INSERT	Leistungsart	POSNR='1311' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1311','B','Hilfe bei Fehlgeb. Nacht,Sa,So Belegheb.',215.71,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2013-01-01','9999-12-31',0,'+3600','','','',0);
#
# PosNr 1312
#
WWWRUN	INSERT	Leistungsart	POSNR='1312' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1312','B','Hilfe bei Fehlgeb. Nacht,Sa,So Belegheb. 1:1',215.71,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2013-01-01','9999-12-31',0,'+3600','','','',0);
#
#
# PosNr 1400
#
WWWRUN	INSERT	Leistungsart	POSNR='1400' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1400','B','Vers. Schnitt-/ Rissverletzung ohne DR III/IV',33.71,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV','2013-01-01','9999-12-31',0,'+3700','','','',0);
#
#
# PosNr 1401
#
WWWRUN	INSERT	Leistungsart	POSNR='1401' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1401','B','Vers. Schnitt-/ Rissv. ohne DR III/IV Belegheb.',33.71,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV durch Beleghebamme','2013-01-01','9999-12-31',0,'+3700','','','',0);
#
#
# PosNr 1402
#
WWWRUN	INSERT	Leistungsart	POSNR='1402' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1402','B','Vers. Schnitt-/ Rissv. ohne DR III/IV Belegheb. 1:1',33.71,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV durch Beleghebamme 1:1','2013-01-01','9999-12-31',0,'+3700','','','',0);
#
#
# PosNr 1500
#
WWWRUN	INSERT	Leistungsart	POSNR='1500' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1500','B','Zuschlag Zwillinge',78.65,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind','2013-01-01','9999-12-31','','','','','',0);
#
# PosNr 1501
#
WWWRUN	INSERT	Leistungsart	POSNR='1501' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1501','B','Zuschlag Zwillinge Belegheb.',78.65,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind Beleghebamme','2013-01-01','9999-12-31','','','','','',0);
#
# PosNr 1502
#
WWWRUN	INSERT	Leistungsart	POSNR='1502' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1502','B','Zuschlag Zwillinge Belegheb. 1:1',78.65,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind Beleghebamme 1:1','2013-01-01','9999-12-31','','','','','',0);
#
#
# PosNr 1600
#
WWWRUN	INSERT	Leistungsart	POSNR='1600' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1600','B','Hilfe bei nicht vollendeter Geburt',206.14,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung','2013-01-01','2013-12-31',0,'','1610','1610','1610',0);
#
# PosNr 1601
#
WWWRUN	INSERT	Leistungsart	POSNR='1601' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1601','B','Hilfe bei nicht vollendeter Geb. Belegheb.',206.14,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2013-01-01','2013-12-31',0,'','1611','1611','1611',0);
#
# PosNr 1602
#
WWWRUN	INSERT	Leistungsart	POSNR='1602' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1602','B','Hilfe bei nicht vollendeter Geb. Belegheb. 1:1',206.14,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2013-01-01','2013-12-31',0,'','1612','1612','1612',0);
#
#
# PosNr 1610
#
WWWRUN	INSERT	Leistungsart	POSNR='1610' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1610','B','Hilfe bei nicht vollendeter Geburt Nacht,Sa,So',244.97,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2013-01-01','2013-12-31',0,'','','','',0);
#
# PosNr 1611
#
WWWRUN	INSERT	Leistungsart	POSNR='1611' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1611','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb.',244.97,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2013-01-01','2013-12-31',0,'','','','',0);
#
# PosNr 1612
#
WWWRUN	INSERT	Leistungsart	POSNR='1612' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1612','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb. 1:1',244.97,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2013-01-01','2013-12-31',0,'','','','',0);
#
#
# PosNr. 1700
#
WWWRUN	INSERT	Leistungsart	POSNR='1700' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1700','B','2. Hebamme',28.14,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2013-01-01','2013-12-31','30','+3600','1710','1710','1710',240);
#
# PosNr. 1701
#
WWWRUN	INSERT	Leistungsart	POSNR='1701' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1701','B','2. Hebamme Beleghebamme',28.14,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2013-01-01','2013-12-31','30','+3600','1711','1711','1711',240);
#
# PosNr. 1702
#
WWWRUN	INSERT	Leistungsart	POSNR='1702' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1702','B','2. Hebamme Beleghebamme 1:1',28.14,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2013-01-01','2013-12-31','30','+3600','1712','1712','1712',240);
#
#
# PosNr. 1710
#
WWWRUN	INSERT	Leistungsart	POSNR='1710' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1710','B','2. Hebamme Nacht,Sa,So',32.77,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1','2013-01-01','2013-12-31','30','+3600','','','',240);
#
# PosNr. 1711
#
WWWRUN	INSERT	Leistungsart	POSNR='1711' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1711','B','2. Hebamme Nacht,Sa,So Belegheb.',32.77,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2013-01-01','2013-12-31','30','+3600','','','',240);
#
# PosNr. 1712
#
WWWRUN	INSERT	Leistungsart	POSNR='1712' and GUELT_VON='2013-01-01' and GUELT_BIS='2013-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1712','B','2. Hebamme Nacht,Sa,So Belegheb. 1:1',32.77,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2013-01-01','2013-12-31','30','+3600','','','',240);
#
# ------------- Wochenbett ----------------------
#
# Leistungen während des Wochenbetts
# Leistungsgruppe C
#
# PosNr. 1800
#
WWWRUN	INSERT	Leistungsart	POSNR='1800' and GUELT_VON='2013-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1800','C','Wochenbettbetreuung',31.28,'aufsuchende Wochenbettbetreuung nach der Geburt','2013-01-01','2014-06-30',0,'','1810','1810','1810',0,'+1900');
#
# PosNr. 1810
#
WWWRUN	INSERT	Leistungsart	POSNR='1810' and GUELT_VON='2013-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1810','C','Wochenbettbetreuung Nacht,Sa,So',37.51,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2013-01-01','2014-06-30',0,'','','','',0,'+1900');
#
# PosNr 1900
#
WWWRUN	INSERT	Leistungsart	POSNR='1900' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,ZUSATZGEBUEHREN2,ZUSATZGEBUEHREN3,ZUSATZGEBUEHREN4,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1900','C','Zuschlag 1. Wochenbettbetreuung nach der Geburt',6.42,'Zuschlag zu der Gebühr nach Nr. 1800 für die erste aufsuchende Wochenbettbetreuung nach der Geburt','2013-01-01','9999-12-31','','+3800','<5GK','+3900','>4GK','','','',0,'');
#
#
# PosNr 2001
#
WWWRUN	INSERT	Leistungsart	POSNR='2001' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2001','C','Wochenbettbetreuung in K-Haus Belegheb.',15.29,'aufsuchende Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2013-01-01','9999-12-31',0,'','2011','2011','2011',0,'');
#
# PosNr 2002
#
WWWRUN	INSERT	Leistungsart	POSNR='2002' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2002','C','Wochenbettbetreuung in K-Haus Belegheb. 1:1',15.29,'aufsuchende Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme 1:1','2013-01-01','9999-12-31',0,'','2012','2012','2012',0,'');
#
#
# PosNr 2011
#
WWWRUN	INSERT	Leistungsart	POSNR='2011' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2011','C','Wochenbettbetr. in K-Haus Nacht,Sa,So Belegheb.',18.33,'Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2013-01-01','9999-12-31',0,'','','','',0,'');
#
# PosNr 2012
#
WWWRUN	INSERT	Leistungsart	POSNR='2012' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2012','C','Wochenbettbetr. in K-Haus Nacht,Sa,So Belegheb. 1:1',18.33,'Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2013-01-01','9999-12-31',0,'','','','',0,'');
#
#
# PosNr. 2100
#
WWWRUN	INSERT	Leistungsart	POSNR='2100' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2100','C','Wochenbettbetreuung in Einr. Leitung Heb.',25.50,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt','2013-01-01','9999-12-31',0,'','2110','2110','2110',0,'');
#
#
# PosNr. 2110
#
WWWRUN	INSERT	Leistungsart	POSNR='2110' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2110','C','Wochenbettbetr. in Einr. Leitung Heb. Nacht,Sa,So',30.58,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2013-01-01','9999-12-31',0,'','','','',0,'');
#
#
# PosNr 2200
#
WWWRUN	INSERT	Leistungsart	POSNR='2200' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2200','C','Zuschlag Zwillinge',10.45,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind','2013-01-01','9999-12-31','','','','','',0,'');
#
# PosNr 2201
#
WWWRUN	INSERT	Leistungsart	POSNR='2201' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2201','C','Zuschlag Zwillinge Beleghebamme',10.45,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind Beleghebamme','2013-01-01','9999-12-31','','','','','',0,'');
#
# PosNr 2202
#
WWWRUN	INSERT	Leistungsart	POSNR='2202' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2202','C','Zuschlag Zwillinge Beleghebamme 1:1',10.45,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind Beleghebamme 1:1','2013-01-01','9999-12-31','','','','','',0,'');
#
#
# PosNr 2300
#
WWWRUN	INSERT	Leistungsart	POSNR='2300' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2300','C','Beratung mittels Kommunikationsmedium',5.73,'Beratung der Wöchnerin mittels Kommunikationsmedium','2013-01-01','9999-12-31','','','','','',0,'');
#
# PosNr 2301
#
WWWRUN	INSERT	Leistungsart	POSNR='2301' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2301','C','Beratung mittels Kommunikationsmedium Belegheb.',5.73,'Beratung der Wöchnerin mittels Kommunikationsmedium durch Beleghebamme','2013-01-01','9999-12-31','','','','','',0,'');
#
# PosNr 2302
#
WWWRUN	INSERT	Leistungsart	POSNR='2302' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2302','C','Beratung mittels Kommunikationsmed. Belegheb. 1:1',5.73,'Beratung der Wöchnerin mittels Kommunikationsmedium durch Beleghebamme 1:1','2013-01-01','9999-12-31','','','','','',0,'');
#
#
# PosNr. 2400
#
WWWRUN	INSERT	Leistungsart	POSNR='2400' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2400','C','Erstuntersuchung (U1)',8.59,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung.','2013-01-01','9999-12-31','','','','','',0,'');
#
# PosNr. 2401
#
WWWRUN	INSERT	Leistungsart	POSNR='2401' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2401','C','Erstuntersuchung (U1) Beleghebamme',8.59,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung Beleghebamme.','2013-01-01','9999-12-31','','','','','',0,'');
#
# PosNr. 2402
#
WWWRUN	INSERT	Leistungsart	POSNR='2402' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2402','C','Erstuntersuchung (U1) Beleghebamme 1:1',8.59,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung Beleghebamme 1:1.','2013-01-01','9999-12-31','','','','','',0,'');
#
#
# PosNr. 2500
#
WWWRUN	INSERT	Leistungsart	POSNR='2500' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2500','C','Entnahme von Körpermaterial',6.42,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung','2013-01-01','9999-12-31','','','','','',0,'');
#
# PosNr. 2501
#
WWWRUN	INSERT	Leistungsart	POSNR='2501' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2501','C','Entnahme von Körpermaterial Belegheb.',6.42,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung Beleghebamme','2013-01-01','9999-12-31','','','','','',0,'');
#
# PosNr. 2502
#
WWWRUN	INSERT	Leistungsart	POSNR='2502' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2502','C','Entnahme von Körpermaterial Belegheb. 1:1',6.42,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung Beleghebamme','2013-01-01','9999-12-31','','','','','',0,'');
#
# ------------- sonstige Leisrungen -------------
#
# sonstige Leistungen
# Leistungsgruppe D
#
# PosNr 2600
#
WWWRUN	INSERT	Leistungsart	POSNR='2600' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2600','D','Überwachung',16.85,'Überwachung, je angefangene halbe Stunde','2013-01-01','9999-12-31','30','','2610','2610','2610',0,'');
#
# PosNr 2601
#
WWWRUN	INSERT	Leistungsart	POSNR='2601' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2601','D','Überwachung Beleghebamme',16.85,'Überwachung, je angefangene halbe Stunde durch Beleghebamme','2013-01-01','9999-12-31','30','','2611','2611','2611',0,'');
#
# PosNr 2602
#
WWWRUN	INSERT	Leistungsart	POSNR='2602' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2602','D','Überwachung Beleghebamme 1:1',16.85,'Überwachung, je angefangene halbe Stunde durch Beleghebamme 1::1','2013-01-01','9999-12-31','30','','2612','2612','2612',0,'');
#
#
# PosNr 2610
#
WWWRUN	INSERT	Leistungsart	POSNR='2610' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2610','D','Überwachung Nacht,Sa,So',20.22,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1','2013-01-01','9999-12-31','30','','','','',0,'');
#
# PosNr 2611
#
WWWRUN	INSERT	Leistungsart	POSNR='2611' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2611','D','Überwachung Nacht,Sa,So Belegheb.',20.22,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2013-01-01','9999-12-31','30','','','','',0,'');
#
# PosNr 2612
#
WWWRUN	INSERT	Leistungsart	POSNR='2612' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2612','D','Überwachung Nacht,Sa,So Belegheb. 1:1',20.22,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2013-01-01','9999-12-31','30','','','','',0,'');
#
#
# PosNr 2700
#
WWWRUN	INSERT	Leistungsart	POSNR='2700' and GUELT_VON='2013-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2700','D','Rückbildungsgymnastik Gruppe',6.42,'Rückbildungsgymnastik bei Unterweisung in der Gruppe, bis zu zehn Teilnehmerinnen je Gruppe und höchstens zehn Stunden, für jede Teilnehmerin je Unterrichtsstunde (60 Minute)','2013-01-01','2014-06-30','E60','','','','',0,'');
#
#
# PosNr 2800
#
WWWRUN	INSERT	Leistungsart	POSNR='2800' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2800','D','Beratung bei Stillschwierigkeiten',30.33,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings','2013-01-01','9999-12-31',0,'','2810','2810','2810',0,'');
#
#
# PosNr 2810
#
WWWRUN	INSERT	Leistungsart	POSNR='2810' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2810','D','Beratung bei Stillschw. Nacht,Sa,So',36.40,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings mit Zuschlag gemäß §5 Abs. 1','2013-01-01','9999-12-31','','','','','',0,'');
#
# PosNr 2820
#
WWWRUN	INSERT	Leistungsart	POSNR='2820' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2820','D','Zuschlag Zwillinge bei Stillschw.',10.45,'Zuschlag für die Beratung der Mutter bei Stillschwierigkeiten oder Ernührungsproblemen bei Zwillingen und mehr Kindern zu den Gebühren nach 2800 und 2810 für das zweite und jedes weitere Kind, je Kind','2013-01-01','9999-12-31','','','','','',0,'');
#
#
# PosNr 2900
#
WWWRUN	INSERT	Leistungsart	POSNR='2900' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2900','D','Beratung bei Stillschw. per Kommunikationsmedium',5.73,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings mittels Kommunikationsmedium','2013-01-01','9999-12-31','','','','','',0,'');
#
##
# ------------ Wegegeld -------------------------
#
# In GO Leistungsgruppe E in tinyHeb Leistungsgruppe W
#
# PosNr 3000 Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3000' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3000','W','Wegegeld nicht mehr als 2 KM bei Tag',1.89,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2013-01-01','9999-12-31',0);
#
# PosNr 3010 anteiliges Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3010' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3010','W','ant. Wegegeld nicht mehr als 2 KM bei Tag',1.89,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2013-01-01','9999-12-31',0);
#
# PosNr 3100 Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3100' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3100','W','Wegegeld nicht mehr als 2 KM bei Nacht',2.67,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2013-01-01','9999-12-31',0);
#
# PosNr 3110 anteiliges Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3110' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3110','W','ant. Wegegeld nicht mehr als 2 KM bei Nacht',2.67,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2013-01-01','9999-12-31',0);
#
# PosNr 3200 Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3200' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3200','W','Wegegeld von mehr als 2 KM bei Tag',0.66,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2013-01-01','9999-12-31',0);
#
# PosNr 3210 anteiliges Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3210' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3210','W','ant. Wegegeld von mehr als 2 KM bei Tag',0.66,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2013-01-01','9999-12-31',0);
#
# PosNr 3300 Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3300' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3300','W','Wegegeld von mehr als 2 KM bei Nacht',0.91,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2013-01-01','9999-12-31',0);
#
#
# PosNr 3310 anteiliges Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3310' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3310','W','ant. Wegegeld von mehr als 2 KM bei Nacht',0.91,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2013-01-01','9999-12-31',0);
#
# ------- Auslagenersatz --------
#
# PosNr. 4000
#
WWWRUN	INSERT	Leistungsart	POSNR='4000' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'4000','M','Perinatalerhebung',8.43,'Perinatalerhebung bei einer außerklinischen Geburt nach vorgeschriebenem Formblatt einschließlich Versand- und Portokosten','2013-01-01','9999-12-31',0);
#
# --------------------------------------------------------------------------------
#
# Neue Gebührenordnung ab 01.01.2010
#
# Leistungen der Mutterschaftsvorsorge und Schwangerenbetreuung
# Leistungsgruppe A
#
# PosNr 0100
#
WWWRUN	INSERT	Leistungsart	POSNR='0100' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0100','A','Beratung',5.81,'Beratung der Schwangeren, auch mittels Kommunikationsmedium','2010-01-01','2012-12-31');
#
#
# PosNr 0101
#
WWWRUN	INSERT	Leistungsart	POSNR='0101' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0101','A','Beratung Beleghebamme',5.81,'Beratung der Schwangeren, auch mittels Kommunikationsmedium durch Beleghebamme','2010-01-01','2012-12-31');
#
#
# PosNr 0102
#
WWWRUN	INSERT	Leistungsart	POSNR='0102' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0102','A','Beratung Beleghebamme 1:1',5.81,'Beratung der Schwangeren, auch mittels Kommunikationsmedium durch Beleghebamme bei 1:1 Betreuung','2010-01-01','2012-12-31');
#
#
#
#
# PosNr 0200
#
WWWRUN	INSERT	Leistungsart	POSNR='0200' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'0200','A','Vorgespräch',7.50,'Vorgespräch über Fragen der Schwangerschaft und Geburt,mindestens 30 Minuten, je angefangene 15 Minuten','2010-01-01','2012-12-31',15);
#
#
#
# PosNr 0300
#
WWWRUN	INSERT	Leistungsart	POSNR='0300' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0300','A','Vorsorgeuntersuchung',22.44,'Vorsorgeuntersuchung der Schwangeren nach Maßgabe der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung in der jeweils geltenden Fassung','2010-01-01','2012-12-31',0,'+3400');
#
#
# PosNr 0400
#
WWWRUN	INSERT	Leistungsart	POSNR='0400' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0400','A','Entnahme von Körpermaterial',5.71,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung','2010-01-01','2012-12-31',0,'');
#
#
# PosNr 0401
#
WWWRUN	INSERT	Leistungsart	POSNR='0401' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0401','A','Entnahme von Körpermaterial Belegheb.',5.71,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung durch Beleghebamme','2010-01-01','2012-12-31',0,'');
#
# PosNr 402
#
WWWRUN	INSERT	Leistungsart	POSNR='0402' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0402','A','Entnahme von Körpermaterial Belegheb. 1:1',5.71,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung durch Beleghebamme 1:1','2010-01-01','2012-12-31',0,'');
#
#
# PosNr 0500
#
WWWRUN	INSERT	Leistungsart	POSNR='0500' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0500','A','Hilfe bei Beschw.',15.00,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten','2010-01-01','2012-12-31',30,'+3500','0510','0510','0510',180);
#
#
# PosNr 0501
#
WWWRUN	INSERT	Leistungsart	POSNR='0501' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0501','A','Hilfe bei Beschw. Belegheb.',15.00,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten Beleghebamme','2010-01-01','2012-12-31',30,'+3500','0511','0511','0511',180);
#
# PosNr 0502
#
WWWRUN	INSERT	Leistungsart	POSNR='0502' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0502','A','Hilfe bei Beschw. Belegheb. 1:1',15.00,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten Beleghebamme 1:1','2010-01-01','2012-12-31',30,'+3500','0512','0512','0512',180);
#
#
# PosNr 0510
#
WWWRUN	INSERT	Leistungsart	POSNR='0510' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0510','A','Hilfe bei Beschw. Sa,So,Nacht',18.00,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1','2010-01-01','2012-12-31',30,'+3500','','','',180);
#
#
# PosNr 0511
#
WWWRUN	INSERT	Leistungsart	POSNR='0511' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0511','A','Hilfe bei Beschw. Sa,So,Nacht Belegheb.',18.00,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','2012-12-31',30,'+3500','','','',180);
#
# PosNr 0512
#
WWWRUN	INSERT	Leistungsart	POSNR='0512' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0512','A','Hilfe bei Beschw. Sa,So,Nacht Belegheb. 1:1',18.00,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-01-01','2012-12-31',30,'+3500','','','',180);
#
#
# PosNr 0600
#
WWWRUN	INSERT	Leistungsart	POSNR='0600' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0600','A','CTG Überwachung',6.43,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung.','2010-01-01','2012-12-31',0,'','','','',0);
#
#
# PosNr 0601
#
WWWRUN	INSERT	Leistungsart	POSNR='0601' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0601','A','CTG Überwachung Belegheb.',6.43,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung. Beleghebamme','2010-01-01','2012-12-31',0,'','','','',0);
#
#
# PosNr 0602
#
WWWRUN	INSERT	Leistungsart	POSNR='0602' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0602','A','CTG Überwachung Belegheb. 1:1',6.43,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung. Beleghebamme 1:1','2010-01-01','2012-12-31',0,'','','','',0);
#
#
# Posnr 0700
#
WWWRUN	INSERT	Leistungsart	POSNR='0700' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0700','A','Geburtsvorbereitung in der Gruppe',5.71,'Geburtsvorbereitung bei Unterweisung in der Gruppe, bis zu zehn Schwangere je Gruppe und höchsten 14 Stunden, für jede Schwangere je Unterrichtsstunden (60 Minuten)','2010-01-01','2012-12-31','E60','','','','',0);
#
#
# Posnr 0800
WWWRUN	INSERT	Leistungsart	POSNR='0800' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,BEGRUENDUNGSPFLICHT) values (9999,'0800','A','Einzelgeburtsvorbereitung',15.00,'Geburtsvorbereitung bei Einzelunterweisung auf ärztliche Anordnung höchstens 14 Unterrichtseinheiten a 30 Minuten, für jede angefangenen 30 Minuten','2010-01-01','2010-06-30','30','','','','',0,'J');
#
# -------------Geburtshilfe ---------------------
#
# Leistungen Geburtshilfe
# Leistungsgruppe B
#
# PosNr 0901
#
WWWRUN	INSERT	Leistungsart	POSNR='0901' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0901','B','Geburt im Krankenhaus Belegheb.',237.85,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme','2010-01-01','2012-06-30',0,'','0911','0911','0911',0);
#
# PosNr 0902
#
WWWRUN	INSERT	Leistungsart	POSNR='0902' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0902','B','Geburt im Krankenhaus Belegheb. 1:1',237.85,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme 1:1','2010-01-01','2012-06-30',0,'','0912','0912','0912',0);
#
#
#
# PosNr 0911
#
WWWRUN	INSERT	Leistungsart	POSNR='0911' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0911','B','Geburt im K-Haus, Nacht,Sa,So Belegheb.',285.42,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','2012-06-30',0,'','','','',0);
#
#
# PosNr 0912
#
WWWRUN	INSERT	Leistungsart	POSNR='0912' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0912','B','Geburt im K-Haus, Nacht,Sa,So Belegheb. 1:1',285.42,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-01-01','2012-06-30',0,'','','','',0);
#
#
# PosNr 1000
#
WWWRUN	INSERT	Leistungsart	POSNR='1000' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1000','B','Geburt außerkl. ärztl. Leitung',237.85,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung','2010-01-01','2012-06-30',0,'+3600','1010','1010','1010',0);
#
# PosNr 1010
#
WWWRUN	INSERT	Leistungsart	POSNR='1010' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1010','B','Geburt außerkl. ärztl. Leitung, Nacht,Sa,So',285.42,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2010-01-01','2012-06-30',0,'+3600','','','',0);
#
# PosNr 1100
#
WWWRUN	INSERT	Leistungsart	POSNR='1100' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1100','B','Geburt außerkl. Leitung Hebammen',445,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung','2010-01-01','2010-06-30',0,'+3600','1110','1110','1110',0);
#
# PosNr 1110
#
WWWRUN	INSERT	Leistungsart	POSNR='1110' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1110','B','Geburt außerkl. Leitung Hebammen Nacht,Sa,So',534.00,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung mit Zuschlag gemäß §5 Abs. 1','2010-01-01','2010-06-30',0,'+3600','','','',0);
#
# PosNr 1200
#
WWWRUN	INSERT	Leistungsart	POSNR='1200' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1200','B','Hilfe bei Hausgeburt',537.00,'Hilfe bei Hausgeburt','2010-01-01','2010-06-30',0,'+3600','1210','1210','1210',0);
#
# PosNr 1210
#
WWWRUN	INSERT	Leistungsart	POSNR='1210' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1210','B','Hilfe bei Hausgeburt Nacht,Sa,So',644.40,'Hilfe bei Hausgeburt mit Zuschlag gemäß §5 Abs. 1','2010-01-01','2010-06-30',0,'+3600','','','',0);
#
# PosNr 1300
#
WWWRUN	INSERT	Leistungsart	POSNR='1300' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1300','B','Hilfe bei Fehlgeburt',160.0,'Hilfe bei einer Fehlgeburt','2010-1-01','2012-12-31',0,'+3600','1310','1310','1310',0);
#
# PosNr 1301
#
WWWRUN	INSERT	Leistungsart	POSNR='1301' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1301','B','Hilfe bei Fehlgeburt Belegheb.',160.0,'Hilfe bei einer Fehlgeburt Beleghebamme','2010-1-01','2012-12-31',0,'+3600','1311','1311','1311',0);
#
#
# PosNr 1302
#
WWWRUN	INSERT	Leistungsart	POSNR='1302' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1302','B','Hilfe bei Fehlgeburt Belegheb. 1:1',160.0,'Hilfe bei einer Fehlgeburt Beleghebamme 1:1','2010-1-01','2012-12-31',0,'+3600','1312','1312','1312',0);
#
#
# PosNr 1310
#
WWWRUN	INSERT	Leistungsart	POSNR='1310' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1310','B','Hilfe bei Fehlgeburt Nacht,Sa,So',192.00,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1','2010-01-01','2012-12-31',0,'+3600','','','',0);
#
# PosNr 1311
#
WWWRUN	INSERT	Leistungsart	POSNR='1311' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1311','B','Hilfe bei Fehlgeb. Nacht,Sa,So Belegheb.',192.00,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','2012-12-31',0,'+3600','','','',0);
#
# PosNr 1312
#
WWWRUN	INSERT	Leistungsart	POSNR='1312' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1312','B','Hilfe bei Fehlgeb. Nacht,Sa,So Belegheb. 1:1',192.00,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-01-01','2012-12-31',0,'+3600','','','',0);
#
#
# PosNr 1400
#
WWWRUN	INSERT	Leistungsart	POSNR='1400' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1400','B','Vers. Schnitt-/ Rissverletzung ohne DR III/IV',30.0,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV','2010-01-01','2012-12-31',0,'+3700','','','',0);
#
#
# PosNr 1401
#
WWWRUN	INSERT	Leistungsart	POSNR='1401' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1401','B','Vers. Schnitt-/ Rissv. ohne DR III/IV Belegheb.',30.0,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV durch Beleghebamme','2010-01-01','2012-12-31',0,'+3700','','','',0);
#
#
# PosNr 1402
#
WWWRUN	INSERT	Leistungsart	POSNR='1402' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1402','B','Vers. Schnitt-/ Rissv. ohne DR III/IV Belegheb. 1:1',30.0,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV durch Beleghebamme 1:1','2010-01-01','2012-12-31',0,'+3700','','','',0);
#
#
# PosNr 1500
#
WWWRUN	INSERT	Leistungsart	POSNR='1500' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1500','B','Zuschlag Zwillinge',70.00,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind','2010-01-01','2012-12-31','','','','','',0);
#
# PosNr 1501
#
WWWRUN	INSERT	Leistungsart	POSNR='1501' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1501','B','Zuschlag Zwillinge Belegheb.',70.00,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind Beleghebamme','2010-01-01','2012-12-31','','','','','',0);
#
# PosNr 1502
#
WWWRUN	INSERT	Leistungsart	POSNR='1502' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1502','B','Zuschlag Zwillinge Belegheb. 1:1',70.00,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind Beleghebamme 1:1','2010-01-01','2012-12-31','','','','','',0);
#
#
# PosNr 1600
#
WWWRUN	INSERT	Leistungsart	POSNR='1600' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1600','B','Hilfe bei nicht vollendeter Geburt',172.8,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung','2010-01-01','2012-06-30',0,'','1610','1610','1610',0);
#
# PosNr 1601
#
WWWRUN	INSERT	Leistungsart	POSNR='1601' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1601','B','Hilfe bei nicht vollendeter Geb. Belegheb.',172.8,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2010-01-01','2012-06-30',0,'','1611','1611','1611',0);
#
# PosNr 1602
#
WWWRUN	INSERT	Leistungsart	POSNR='1602' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1602','B','Hilfe bei nicht vollendeter Geb. Belegheb. 1:1',172.8,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2010-01-01','2012-06-30',0,'','1612','1612','1612',0);
#
#
# PosNr 1610
#
WWWRUN	INSERT	Leistungsart	POSNR='1610' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1610','B','Hilfe bei nicht vollendeter Geburt Nacht,Sa,So',207.36,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2010-01-01','2012-06-30',0,'','','','',0);
#
# PosNr 1611
#
WWWRUN	INSERT	Leistungsart	POSNR='1611' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1611','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb.',207.36,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','2012-06-30',0,'','','','',0);
#
# PosNr 1612
#
WWWRUN	INSERT	Leistungsart	POSNR='1612' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1612','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb. 1:1',207.36,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-01-01','2012-06-30',0,'','','','',0);
#
#
# PosNr. 1700
#
WWWRUN	INSERT	Leistungsart	POSNR='1700' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1700','B','2. Hebamme',20.60,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2010-01-01','2012-06-30','30','+3600','1710','1710','1710',240);
#
# PosNr. 1701
#
WWWRUN	INSERT	Leistungsart	POSNR='1701' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1701','B','2. Hebamme Beleghebamme',20.60,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2010-01-01','2012-06-30','30','+3600','1711','1711','1711',240);
#
# PosNr. 1702
#
WWWRUN	INSERT	Leistungsart	POSNR='1702' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1702','B','2. Hebamme Beleghebamme 1:1',20.60,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2010-01-01','2012-06-30','30','+3600','1712','1712','1712',240);
#
#
# PosNr. 1710
#
WWWRUN	INSERT	Leistungsart	POSNR='1710' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1710','B','2. Hebamme Nacht,Sa,So',24.72,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1','2010-01-01','2012-06-30','30','+3600','','','',240);
#
# PosNr. 1711
#
WWWRUN	INSERT	Leistungsart	POSNR='1711' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1711','B','2. Hebamme Nacht,Sa,So Belegheb.',24.72,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','2012-06-30','30','+3600','','','',240);
#
# PosNr. 1712
#
WWWRUN	INSERT	Leistungsart	POSNR='1712' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1712','B','2. Hebamme Nacht,Sa,So Belegheb. 1:1',24.72,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','2012-06-30','30','+3600','','','',240);
#
# ------------- Wochenbett ----------------------
#
# Leistungen während des Wochenbetts
# Leistungsgruppe C
#
# PosNr. 1800
#
WWWRUN	INSERT	Leistungsart	POSNR='1800' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1800','C','Wochenbettbetreuung',26.52,'aufsuchende Wochenbettbetreuung nach der Geburt','2010-01-01','2010-06-30',0,'','1810','1810','1810',0,'+1900');
#
# PosNr. 1801
#
WWWRUN	INSERT	Leistungsart	POSNR='1801' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1801','C','Wochenbettbetreuung Beleghebamme',26.52,'aufsuchende Wochenbettbetreuung nach der Geburt Beleghebamme','2010-01-01','2010-06-30',0,'','1811','1811','1811',0,'+1900');
#
# PosNr. 1802
#
WWWRUN	INSERT	Leistungsart	POSNR='1802' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1802','C','Wochenbettbetreuung Beleghebamme 1:1',26.52,'aufsuchende Wochenbettbetreuung nach der Geburt Beleghebamme 1:1','2010-01-01','2010-06-30',0,'','1812','1812','1812',0,'+1900');
#
#
# PosNr. 1810
#
WWWRUN	INSERT	Leistungsart	POSNR='1810' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1810','C','Wochenbettbetreuung Nacht,Sa,So',31.82,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2010-01-01','2010-06-30',0,'','','','',0,'+1900');
#
# PosNr. 1811
#
WWWRUN	INSERT	Leistungsart	POSNR='1811' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1811','C','Wochenbettbetreuung Nacht,Sa,So Beleghebamme',31.82,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','2010-06-30',0,'','','','',0,'+1900');
#
# PosNr. 1812
#
WWWRUN	INSERT	Leistungsart	POSNR='1812' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1812','C','Wochenbettbetreuung Nacht,Sa,So Beleghebamme 1:1',31.82,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-01-01','2010-06-30',0,'','','','',0,'+1900');
#
#
# PosNr 1900
#
WWWRUN	INSERT	Leistungsart	POSNR='1900' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,ZUSATZGEBUEHREN2,ZUSATZGEBUEHREN3,ZUSATZGEBUEHREN4,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1900','C','Zuschlag 1. Wochenbettbetreuung nach der Geburt',5.71,'Zuschlag zu der Gebühr nach Nr. 1800 für die erste aufsuchende Wochenbettbetreuung nach der Geburt','2010-01-01','2012-12-31','','+3800','<5GK','+3900','>4GK','','','',0,'');
#
#
# PosNr 2001
#
WWWRUN	INSERT	Leistungsart	POSNR='2001' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2001','C','Wochenbettbetreuung in K-Haus Belegheb.',13.16,'aufsuchende Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2010-01-01','2012-06-30',0,'','2011','2011','2011',0,'');
#
# PosNr 2002
#
WWWRUN	INSERT	Leistungsart	POSNR='2002' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2002','C','Wochenbettbetreuung in K-Haus Belegheb. 1:1',13.16,'aufsuchende Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme 1:1','2010-01-01','2012-06-30',0,'','2012','2012','2012',0,'');
#
#
# PosNr 2011
#
WWWRUN	INSERT	Leistungsart	POSNR='2011' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2011','C','Wochenbettbetr. in K-Haus Nacht,Sa,So Belegheb.',15.79,'Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','2012-06-30',0,'','','','',0,'');
#
# PosNr 2012
#
WWWRUN	INSERT	Leistungsart	POSNR='2012' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2012','C','Wochenbettbetr. in K-Haus Nacht,Sa,So Belegheb. 1:1',15.79,'Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-01-01','2012-06-30',0,'','','','',0,'');
#
#
# PosNr. 2100
#
WWWRUN	INSERT	Leistungsart	POSNR='2100' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2100','C','Wochenbettbetreuung in Einr. Leitung Heb.',21.42,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt','2010-01-01','2010-06-30',0,'','2110','2110','2110',0,'');
#
#
# PosNr. 2110
#
WWWRUN	INSERT	Leistungsart	POSNR='2110' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2110','C','Wochenbettbetr. in Einr. Leitung Heb. Nacht,Sa,So',25.7,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2010-01-01','2010-06-30',0,'','','','',0,'');
#
#
# PosNr 2200
#
WWWRUN	INSERT	Leistungsart	POSNR='2200' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2200','C','Zuschlag Zwillinge',8.87,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind','2010-01-01','2010-06-30','','','','','',0,'');
#
# PosNr 2201
#
WWWRUN	INSERT	Leistungsart	POSNR='2201' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2201','C','Zuschlag Zwillinge Beleghebamme',8.87,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind Beleghebamme','2010-01-01','2010-06-30','','','','','',0,'');
#
# PosNr 2202
#
WWWRUN	INSERT	Leistungsart	POSNR='2202' and GUELT_VON='2010-01-01' and GUELT_BIS='2010-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2202','C','Zuschlag Zwillinge Beleghebamme 1:1',8.87,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind Beleghebamme 1:1','2010-01-01','2010-06-30','','','','','',0,'');
#
#
# PosNr 2300
#
WWWRUN	INSERT	Leistungsart	POSNR='2300' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2300','C','Beratung mittels Kommunikationsmedium',5.1,'Beratung der Wöchnerin mittels Kommunikationsmedium','2010-01-01','2012-12-31','','','','','',0,'');
#
# PosNr 2301
#
WWWRUN	INSERT	Leistungsart	POSNR='2301' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2301','C','Beratung mittels Kommunikationsmedium Belegheb.',5.1,'Beratung der Wöchnerin mittels Kommunikationsmedium durch Beleghebamme','2010-01-01','2012-12-31','','','','','',0,'');
#
# PosNr 2302
#
WWWRUN	INSERT	Leistungsart	POSNR='2302' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2302','C','Beratung mittels Kommunikationsmed. Belegheb. 1:1',5.1,'Beratung der Wöchnerin mittels Kommunikationsmedium durch Beleghebamme 1:1','2010-01-01','2012-12-31','','','','','',0,'');
#
#
# PosNr. 2400
#
WWWRUN	INSERT	Leistungsart	POSNR='2400' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2400','C','Erstuntersuchung (U1)',7.65,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung.','2010-01-01','2012-12-31','','','','','',0,'');
#
# PosNr. 2401
#
WWWRUN	INSERT	Leistungsart	POSNR='2401' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2401','C','Erstuntersuchung (U1) Beleghebamme',7.65,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung Beleghebamme.','2010-01-01','2012-12-31','','','','','',0,'');
#
# PosNr. 2402
#
WWWRUN	INSERT	Leistungsart	POSNR='2402' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2402','C','Erstuntersuchung (U1) Beleghebamme 1:1',7.65,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung Beleghebamme 1:1.','2010-01-01','2012-12-31','','','','','',0,'');
#
#
# PosNr. 2500
#
WWWRUN	INSERT	Leistungsart	POSNR='2500' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2500','C','Entnahme von Körpermaterial',5.71,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung','2010-01-01','2012-12-31','','','','','',0,'');
#
# PosNr. 2501
#
WWWRUN	INSERT	Leistungsart	POSNR='2501' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2501','C','Entnahme von Körpermaterial Belegheb.',5.71,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung Beleghebamme','2010-01-01','2012-12-31','','','','','',0,'');
#
# PosNr. 2502
#
WWWRUN	INSERT	Leistungsart	POSNR='2502' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2502','C','Entnahme von Körpermaterial Belegheb. 1:1',5.71,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung Beleghebamme','2010-01-01','2012-12-31','','','','','',0,'');
#
# ------------- sonstige Leisrungen -------------
#
# sonstige Leistungen
# Leistungsgruppe D
#
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
##
# ------------ Wegegeld -------------------------
#
# In GO Leistungsgruppe E in tinyHeb Leistungsgruppe W
#
# PosNr 3000 Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3000' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3000','W','Wegegeld nicht mehr als 2 KM bei Tag',1.68,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2010-01-01','2012-12-31',0);
#
# PosNr 3010 anteiliges Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3010' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3010','W','ant. Wegegeld nicht mehr als 2 KM bei Tag',1.68,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2010-01-01','2012-12-31',0);
#
# PosNr 3100 Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3100' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3100','W','Wegegeld nicht mehr als 2 KM bei Nacht',2.38,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2010-01-01','2012-12-31',0);
#
# PosNr 3110 anteiliges Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3110' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3110','W','ant. Wegegeld nicht mehr als 2 KM bei Nacht',2.38,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2010-01-01','2012-12-31',0);
#
# PosNr 3200 Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3200' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3200','W','Wegegeld von mehr als 2 KM bei Tag',0.59,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2010-01-01','2012-12-31',0);
#
# PosNr 3210 anteiliges Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3210' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3210','W','ant. Wegegeld von mehr als 2 KM bei Tag',0.59,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2010-01-01','2012-12-31',0);
#
# PosNr 3300 Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3300' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3300','W','Wegegeld von mehr als 2 KM bei Nacht',0.81,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2010-01-01','2012-12-31',0);
#
#
# PosNr 3310 anteiliges Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3310' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3310','W','ant. Wegegeld von mehr als 2 KM bei Nacht',0.81,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2010-01-01','2012-12-31',0);
#
# ------------- Auslagenersatz -------------
#
# sonstige Leistungen
# Leistungsgruppe E in tinyHeb Leistungsgruppe M
#
# PosNr 3400
#
WWWRUN	INSERT	Leistungsart	POSNR='3400' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-07-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,NICHT) values (9999,'3400','M','Pauschale Vorsorgeuntersuchung',2.58,'Materialpauschale Vorsorgeuntersuchung','2010-01-01','2012-07-31',0,'3500');
#
# PosNr 3500
#
WWWRUN	INSERT	Leistungsart	POSNR='3500' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-07-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,NICHT) values (9999,'3500','M','Pauschale Schwangerschaftsbeschw.',2.58,'Materialpauschale bei Schwangerschaftsbeschwerden oder bei Wehen','2010-01-01','2012-07-31',0,'3400,3600');
#
# PosNr. 3600
#
WWWRUN	INSERT	Leistungsart	POSNR='3600' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-07-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,NICHT) values (9999,'3600','M','Pauschale Geburtshilfe',35.02,'Materialpauschale Geburtshilfe','2010-01-01','2012-07-31',0,'3500');
#
# PosNr. 3700
#
WWWRUN	INSERT	Leistungsart	POSNR='3700' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-07-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3700','M','Pauschale Naht bei Geburtsverletzung',28.33,'Materialpauschale, zusätzlich zu Nr. 3600, bei Versorgung einer Naht bei Geburtsverletzungen','2010-01-01','2012-07-31',0);
#
# PosNr. 3800
#
WWWRUN	INSERT	Leistungsart	POSNR='3800' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-07-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3800','M','Pauschale Wochenbettbetreuung',25.24,'Materialpauschale Wochenbettbetreuung','2010-01-01','2012-07-31',0);
#
# PosNr. 3900
#
WWWRUN	INSERT	Leistungsart	POSNR='3900' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-07-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3900','M','Pauschale Wochenbettbetreuung nach 4 Tag p.p.',13.7,'Materialpauschale bei Beginn der Betreuung später als vier Tage nach der Geburt','2010-01-01','2012-07-31',0);
#
# PosNr. 4000
#
WWWRUN	INSERT	Leistungsart	POSNR='4000' and GUELT_VON='2010-01-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'4000','M','Perinatalerhebung',7.5,'Perinatalerhebung bei einer außerklinischen Geburt nach vorgeschriebenem Formblatt einschließlich Versand- und Portokosten','2010-01-01','2012-12-31',0);
#
#
#
# ------------- sonstige Auslagen -------------
#
# sonstige Leistungen
# Leistungsgruppe F in tinyHeb Leistungsgruppe M
#
# PosNr 5000
#
WWWRUN	INSERT	Leistungsart	POSNR='5000' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'5000','M','Arzneimittel Wirkstoffgruppe Antidiarrhoika',0,'Arzneimittel aus der Wirkstoffgruppe Antidiarrhoika','2010-01-01','9999-12-31',0);
#
# PosNr 5100
#
WWWRUN	INSERT	Leistungsart	POSNR='5100' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'5100','M','Arzneimittel Wirkstoffgruppe Antiemetika',0,'Arzneimittel aus der Wirkstoffgruppe Antiemetika','2010-01-01','9999-12-31',0);
#
#
# PosNr 5200
#
WWWRUN	INSERT	Leistungsart	POSNR='5200' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'5200','M','Arzneimittel Wirkstoffgruppe Antihypotonika',0,'Arzneimittel aus der Wirkstoffgruppe Antihypotonika','2010-01-01','9999-12-31',0);
#
#
# PosNr 5300
#
WWWRUN	INSERT	Leistungsart	POSNR='5300' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'5300','M','Arzneimittel Wirkstoffgruppe Dermatika',0,'Arzneimittel aus der Wirkstoffgruppe Dermatika','2010-01-01','9999-12-31',0);
#
#
# PosNr 5400
#
WWWRUN	INSERT	Leistungsart	POSNR='5400' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'5400','M','Arzneimittel Wirkstoffgruppe Ophtalmika',0,'Arzneimittel aus der Wirkstoffgruppe Ophtalmika','2010-01-01','9999-12-31',0);
#
#
# PosNr 5500
#
WWWRUN	INSERT	Leistungsart	POSNR='5500' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'5500','M','Arzneimittel Wirkstoffgruppe Vitamin D',0,'Arzneimittel aus der Wirkstoffgruppe Vitamin D - auch in Kombination mit Fluorsalzen','2010-01-01','9999-12-31',0);
#
#
# PosNr 5600
#
WWWRUN	INSERT	Leistungsart	POSNR='5600' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'5600','M','Arzneimittel Wirkstoffgruppe Vitamin K',0,'Arzneimittel aus der Wirkstoffgruppe Vitamin K','2010-01-01','9999-12-31',0);
#
#
# PosNr 5700
#
WWWRUN	INSERT	Leistungsart	POSNR='5700' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'5700','M','Arzneimittel Wirkstoffgruppe Antimykotika',0,'Arzneimittel aus der Wirkstoffgruppe Antimykotika','2010-01-01','9999-12-31',0);
#
#
# PosNr 5800
#
WWWRUN	INSERT	Leistungsart	POSNR='5800' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'5800','M','Arzneimittel Wirkstoffgruppe Carminativa',0,'Arzneimittel aus der Wirkstoffgruppe Carminativa','2010-01-01','9999-12-31',0);
#
# PosNr 5900
#
WWWRUN	INSERT	Leistungsart	POSNR='5900' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'5900','M','Arz. Wirkstoffgr. Galle- und Lebertherapeutika ',0,'Arzneimittel aus der Wirkstoffgruppe Galle- u. Lebertherapeutika','2010-01-01','9999-12-31',0);
#
# PosNr 6000
#
WWWRUN	INSERT	Leistungsart	POSNR='6000' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'6000','M','Arzneimittel Wirkstoffgruppe Phytotherapie',0,'Arzneimittel aus der Wirkstoffgruppe Phytotherapie','2010-01-01','9999-12-31',0);
#
# PosNr 6100
#
WWWRUN	INSERT	Leistungsart	POSNR='6100' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'6100','M','Arzneimittel Wirkstoffgruppe Homöopathie',0,'Arzneimittel aus der Wirkstoffgruppe Homöopathie','2010-01-01','9999-12-31',0);
#
# PosNr 6200
#
WWWRUN	INSERT	Leistungsart	POSNR='6200' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'6200','M','Arz. Wirkstoffgr. anthroposophische Medizin ',0,'Arzneimittel aus der Wirkstoffgruppe anthroposophische Medizin','2010-01-01','9999-12-31',0);
#
#
# PosNr 8000
#
WWWRUN	INSERT	Leistungsart	POSNR='8000' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'8000','M','sonstige Auslagen',0,'sonstige Auslagen','2010-01-01','9999-12-31',0);
#
#
#
#
#
# -------- geänderte Posistionsnummern ab 01.07.2010 ---------------------
#
#
# Posnr 0800
WWWRUN	INSERT	Leistungsart	POSNR='0800' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,BEGRUENDUNGSPFLICHT) values (9999,'0800','A','Einzelgeburtsvorbereitung',7.50,'Geburtsvorbereitung bei Einzelunterweisung auf ärztliche Anordnung höchstens 28 Unterrichtseinheiten a 15 Minuten, für jede angefangenen 15 Minuten','2010-07-01','2012-12-31','15','','','','',0,'J');
#
# PosNr 1100
#
WWWRUN	INSERT	Leistungsart	POSNR='1100' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1100','B','Geburt außerkl. Leitung Hebammen',467.2,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung','2010-07-01','2012-06-30',0,'+3600','1110','1110','1110',0);
#
# PosNr 1110
#
WWWRUN	INSERT	Leistungsart	POSNR='1110' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1110','B','Geburt außerkl. Leitung Hebammen Nacht,Sa,So',560.65,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung mit Zuschlag gemäß §5 Abs. 1','2010-07-01','9999-12-31',0,'+3600','','','',0);
#
# PosNr 1200
#
WWWRUN	INSERT	Leistungsart	POSNR='1200' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1200','B','Hilfe bei Hausgeburt',548.80,'Hilfe bei Hausgeburt','2010-07-01','2012-06-30',0,'+3600','1210','1210','1210',0);
#
# PosNr 1210
#
WWWRUN	INSERT	Leistungsart	POSNR='1210' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1210','B','Hilfe bei Hausgeburt Nacht,Sa,So',658.56,'Hilfe bei Hausgeburt mit Zuschlag gemäß §5 Abs. 1','2010-07-01','2012-06-30',0,'+3600','','','',0);
#
#
#
# PosNr. 1800
#
WWWRUN	INSERT	Leistungsart	POSNR='1800' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1800','C','Wochenbettbetreuung',27.00,'aufsuchende Wochenbettbetreuung nach der Geburt','2010-07-01','2012-06-30',0,'','1810','1810','1810',0,'+1900');
#
# PosNr. 1801
#
WWWRUN	INSERT	Leistungsart	POSNR='1801' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1801','C','Wochenbettbetreuung Beleghebamme',27.00,'aufsuchende Wochenbettbetreuung nach der Geburt Beleghebamme','2010-07-01','2012-06-30',0,'','1811','1811','1811',0,'+1900');
#
# PosNr. 1802
#
WWWRUN	INSERT	Leistungsart	POSNR='1802' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1802','C','Wochenbettbetreuung Beleghebamme 1:1',27.00,'aufsuchende Wochenbettbetreuung nach der Geburt Beleghebamme 1:1','2010-07-01','2012-06-30',0,'','1812','1812','1812',0,'+1900');
#
#
# PosNr. 1810
#
WWWRUN	INSERT	Leistungsart	POSNR='1810' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1810','C','Wochenbettbetreuung Nacht,Sa,So',32.40,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2010-07-01','2012-06-30',0,'','','','',0,'+1900');
#
# PosNr. 1811
#
WWWRUN	INSERT	Leistungsart	POSNR='1811' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1811','C','Wochenbettbetreuung Nacht,Sa,So Beleghebamme',32.40,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-07-01','2012-06-30',0,'','','','',0,'+1900');
#
# PosNr. 1812
#
WWWRUN	INSERT	Leistungsart	POSNR='1812' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1812','C','Wochenbettbetreuung Nacht,Sa,So Beleghebamme 1:1',32.40,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-07-01','2012-06-30',0,'','','','',0,'+1900');
#
#
# PosNr. 2100
#
WWWRUN	INSERT	Leistungsart	POSNR='2100' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2100','C','Wochenbettbetreuung in Einr. Leitung Heb.',22.00,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt','2010-07-01','2012-06-30',0,'','2110','2110','2110',0,'');
#
#
# PosNr. 2110
#
WWWRUN	INSERT	Leistungsart	POSNR='2110' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2110','C','Wochenbettbetr. in Einr. Leitung Heb. Nacht,Sa,So',26.4,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2010-07-01','2012-06-30',0,'','','','',0,'');
#
#
# PosNr 2200
#
WWWRUN	INSERT	Leistungsart	POSNR='2200' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2200','C','Zuschlag Zwillinge',9.30,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind','2010-07-01','2012-12-31','','','','','',0,'');
#
# PosNr 2201
#
WWWRUN	INSERT	Leistungsart	POSNR='2201' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2201','C','Zuschlag Zwillinge Beleghebamme',9.30,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind Beleghebamme','2010-07-01','2012-12-31','','','','','',0,'');
#
# PosNr 2202
#
WWWRUN	INSERT	Leistungsart	POSNR='2202' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2202','C','Zuschlag Zwillinge Beleghebamme 1:1',9.30,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind Beleghebamme 1:1','2010-07-01','2012-12-31','','','','','',0,'');
#
#
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
#
#
#
#
# -------- geänderte Positionsnummern ab 01.07.2012
#
# PosNr 0901
#
WWWRUN	INSERT	Leistungsart	POSNR='0901' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0901','B','Geburt im Krankenhaus Belegheb.',243.85,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme','2012-07-01','2012-12-31',0,'','0911','0911','0911',0);
#
# PosNr 0902
#
WWWRUN	INSERT	Leistungsart	POSNR='0902' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0902','B','Geburt im Krankenhaus Belegheb. 1:1',250.85,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme 1:1','2012-07-01','2012-12-31',0,'','0912','0912','0912',0);
#
#
#
# PosNr 0911
#
WWWRUN	INSERT	Leistungsart	POSNR='0911' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0911','B','Geburt im K-Haus, Nacht,Sa,So Belegheb.',291.42,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2012-07-01','2012-12-31',0,'','','','',0);
#
#
# PosNr 0912
#
WWWRUN	INSERT	Leistungsart	POSNR='0912' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0912','B','Geburt im K-Haus, Nacht,Sa,So Belegheb. 1:1',298.42,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2012-07-01','2012-12-31',0,'','','','',0);
#
#
# PosNr 1000
#
WWWRUN	INSERT	Leistungsart	POSNR='1000' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1000','B','Geburt außerkl. ärztl. Leitung',243.85,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung','2012-07-01','2012-12-31',0,'+3600','1010','1010','1010',0);
#
# PosNr 1010
#
WWWRUN	INSERT	Leistungsart	POSNR='1010' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1010','B','Geburt außerkl. ärztl. Leitung, Nacht,Sa,So',291.42,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2012-07-01','2012-12-31',0,'+3600','','','',0);
#
# PosNr 1100
#
WWWRUN	INSERT	Leistungsart	POSNR='1100' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1100','B','Geburt außerkl. Leitung Hebammen',492.80,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung','2012-07-01','2012-12-31',0,'+3600','1110','1110','1110',0);
#
# PosNr 1110
#
WWWRUN	INSERT	Leistungsart	POSNR='1110' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1110','B','Geburt außerkl. Leitung Hebammen Nacht,Sa,So',586.24,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung mit Zuschlag gemäß §5 Abs. 1','2012-07-01','2012-12-31',0,'+3600','','','',0);
#
# PosNr 1200
#
WWWRUN	INSERT	Leistungsart	POSNR='1200' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1200','B','Hilfe bei Hausgeburt',626.80,'Hilfe bei Hausgeburt','2012-07-01','2012-12-31',0,'+3600','1210','1210','1210',0);
#
# PosNr 1210
#
WWWRUN	INSERT	Leistungsart	POSNR='1210' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1210','B','Hilfe bei Hausgeburt Nacht,Sa,So',736.56,'Hilfe bei Hausgeburt mit Zuschlag gemäß §5 Abs. 1','2012-07-01','2012-12-31',0,'+3600','','','',0);
#
#
# PosNr 1600
#
WWWRUN	INSERT	Leistungsart	POSNR='1600' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1600','B','Hilfe bei nicht vollendeter Geburt',184.8,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung','2012-07-01','2012-12-31',0,'','1610','1610','1610',0);
#
# PosNr 1601
#
WWWRUN	INSERT	Leistungsart	POSNR='1601' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1601','B','Hilfe bei nicht vollendeter Geb. Belegheb.',184.8,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2012-07-01','2012-12-31',0,'','1611','1611','1611',0);
#
# PosNr 1602
#
WWWRUN	INSERT	Leistungsart	POSNR='1602' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1602','B','Hilfe bei nicht vollendeter Geb. Belegheb. 1:1',184.8,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2012-07-01','2012-12-31',0,'','1612','1612','1612',0);
#
#
# PosNr 1610
#
WWWRUN	INSERT	Leistungsart	POSNR='1610' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1610','B','Hilfe bei nicht vollendeter Geburt Nacht,Sa,So',219.36,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2012-07-01','2012-12-31',0,'','','','',0);
#
# PosNr 1611
#
WWWRUN	INSERT	Leistungsart	POSNR='1611' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1611','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb.',219.36,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2012-07-01','2012-12-31',0,'','','','',0);
#
# PosNr 1612
#
WWWRUN	INSERT	Leistungsart	POSNR='1612' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1612','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb. 1:1',219.36,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2012-07-01','2012-12-31',0,'','','','',0);
#
#
# PosNr. 1700
#
WWWRUN	INSERT	Leistungsart	POSNR='1700' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1700','B','2. Hebamme',25.60,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2012-07-01','2012-12-31','30','+3600','1710','1710','1710',240);
#
# PosNr. 1701
#
WWWRUN	INSERT	Leistungsart	POSNR='1701' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1701','B','2. Hebamme Beleghebamme',25.60,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2012-07-01','2012-12-31','30','+3600','1711','1711','1711',240);
#
# PosNr. 1702
#
WWWRUN	INSERT	Leistungsart	POSNR='1702' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1702','B','2. Hebamme Beleghebamme 1:1',25.60,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2012-07-01','2012-12-31','30','+3600','1712','1712','1712',240);
#
#
# PosNr. 1710
#
WWWRUN	INSERT	Leistungsart	POSNR='1710' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1710','B','2. Hebamme Nacht,Sa,So',29.72,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1','2012-07-01','2012-12-31','30','+3600','','','',240);
#
# PosNr. 1711
#
WWWRUN	INSERT	Leistungsart	POSNR='1711' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1711','B','2. Hebamme Nacht,Sa,So Belegheb.',29.72,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2012-07-01','2012-12-31','30','+3600','','','',240);
#
# PosNr. 1712
#
WWWRUN	INSERT	Leistungsart	POSNR='1712' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1712','B','2. Hebamme Nacht,Sa,So Belegheb. 1:1',29.72,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2012-07-01','2012-12-31','30','+3600','','','',240);
#
# PosNr. 1800
#
WWWRUN	INSERT	Leistungsart	POSNR='1800' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1800','C','Wochenbettbetreuung',27.08,'aufsuchende Wochenbettbetreuung nach der Geburt','2012-07-01','2012-12-31',0,'','1810','1810','1810',0,'+1900');
#
# PosNr. 1801
#
WWWRUN	INSERT	Leistungsart	POSNR='1801' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1801','C','Wochenbettbetreuung Beleghebamme',27.08,'aufsuchende Wochenbettbetreuung nach der Geburt Beleghebamme','2012-07-01','2012-12-31',0,'','1811','1811','1811',0,'+1900');
#
# PosNr. 1802
#
WWWRUN	INSERT	Leistungsart	POSNR='1802' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1802','C','Wochenbettbetreuung Beleghebamme 1:1',27.08,'aufsuchende Wochenbettbetreuung nach der Geburt Beleghebamme 1:1','2012-07-01','2012-12-31',0,'','1812','1812','1812',0,'+1900');
#
#
# PosNr. 1810
#
WWWRUN	INSERT	Leistungsart	POSNR='1810' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1810','C','Wochenbettbetreuung Nacht,Sa,So',32.48,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2012-07-01','2012-12-31',0,'','','','',0,'+1900');
#
# PosNr. 1811
#
WWWRUN	INSERT	Leistungsart	POSNR='1811' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1811','C','Wochenbettbetreuung Nacht,Sa,So Beleghebamme',32.48,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2012-07-01','2012-12-31',0,'','','','',0,'+1900');
#
# PosNr. 1812
#
WWWRUN	INSERT	Leistungsart	POSNR='1812' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1812','C','Wochenbettbetreuung Nacht,Sa,So Beleghebamme 1:1',32.48,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2012-07-01','2012-12-31',0,'','','','',0,'+1900');
#
#
#
# PosNr 2001
#
WWWRUN	INSERT	Leistungsart	POSNR='2001' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2001','C','Wochenbettbetreuung in K-Haus Belegheb.',13.24,'aufsuchende Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2012-07-01','2012-12-31',0,'','2011','2011','2011',0,'');
#
# PosNr 2002
#
WWWRUN	INSERT	Leistungsart	POSNR='2002' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2002','C','Wochenbettbetreuung in K-Haus Belegheb. 1:1',13.24,'aufsuchende Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme 1:1','2012-07-01','2012-12-31',0,'','2012','2012','2012',0,'');
#
#
# PosNr 2011
#
WWWRUN	INSERT	Leistungsart	POSNR='2011' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2011','C','Wochenbettbetr. in K-Haus Nacht,Sa,So Belegheb.',15.87,'Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2012-07-01','2012-12-31',0,'','','','',0,'');
#
# PosNr 2012
#
WWWRUN	INSERT	Leistungsart	POSNR='2012' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2012','C','Wochenbettbetr. in K-Haus Nacht,Sa,So Belegheb. 1:1',15.87,'Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2012-07-01','2012-12-31',0,'','','','',0,'');
#
#
# PosNr. 2100
#
WWWRUN	INSERT	Leistungsart	POSNR='2100' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2100','C','Wochenbettbetreuung in Einr. Leitung Heb.',22.08,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt','2012-07-01','2012-12-31',0,'','2110','2110','2110',0,'');
#
#
# PosNr. 2110
#
WWWRUN	INSERT	Leistungsart	POSNR='2110' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2110','C','Wochenbettbetr. in Einr. Leitung Heb. Nacht,Sa,So',26.48,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2012-07-01','2012-12-31',0,'','','','',0,'');
#
#
#
# -------- Positionsnummern w/ Betriebskostenpauschale vom 27.06.2011 bis 30.06.2012
#
# Posnr 0900
WWWRUN	INSERT	Leistungsart	POSNR='0900' and GUELT_VON='2011-06-27' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'0900','B','Betriebskostenpausch. vollendete Geb. nach QM',550.00,'Betriebskostenpauschale für eine vollendete Geburt in einer von Hebammen geleiteten Einrichtung, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2011-06-27','2012-06-30','','','','','',0,'');
#
#
# Posnr 0910
#
WWWRUN	INSERT	Leistungsart	POSNR='0910' and GUELT_VON='2011-06-27' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'0910','B','Betriebskostenpauschale vollendete Geb. vor QM',500.50,'Betriebskostenpauschale für eine vollendete Geburt in einer von Hebammen geleiteten Einrichtung bis zum Zeitpunkt der Einführung eines QM-Systems','2011-06-27','2012-06-30','','','','','',0,'');
#
#
# Posnr 0920
#
WWWRUN	INSERT	Leistungsart	POSNR='0920' and GUELT_VON='2011-06-27' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'0920','B','Betriebskostenpauschale nicht-vollendete Geb. nach QM',412.50,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach weniger als 4 Stunden, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2011-06-27','2012-06-30','','','','','',0,'');
#
#
# Posnr 0930
#
WWWRUN	INSERT	Leistungsart	POSNR='0930' and GUELT_VON='2011-06-27' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'0930','B','Betriebskostenpauschale nicht-vollendete Geb. vor QM',375.38,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach weniger als 4 Stunden bis zum Zeitpunkt der Einführung eines QM-Systems','2011-06-27','2012-06-30','','','','','',0,'');
#
#
# Posnr 0940
#
WWWRUN	INSERT	Leistungsart	POSNR='0940' and GUELT_VON='2011-06-27' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'0940','B','Betriebskostenpauschale nicht-vollendete Geb. nach QM',550.00,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach mehr als 4 Stunden, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2011-06-27','2012-06-30','','','','','',0,'');
#
#
# Posnr 0950
#
WWWRUN	INSERT	Leistungsart	POSNR='0950' and GUELT_VON='2011-06-27' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'0950','B','Betriebskostenpauschale nicht-vollendete Geb. vor QM',500.50,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach mehr als 4 Stunden bis zum Zeitpunkt der Einführung eines QM-Systems','2011-06-27','2012-06-30','','','','','',0,'');
#
#
#
# -------- neue Positionsnummern w/ Betriebskostenpauschale ab 01.07.2012
#
# Posnr 9000
WWWRUN	INSERT	Leistungsart	POSNR='9000' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9000','B','Betriebskostenpausch. vollendete Geb. nach QM',700.00,'Betriebskostenpauschale für eine vollendete Geburt in einer von Hebammen geleiteten Einrichtung, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2012-07-01','2012-12-31','','','','','',0,'');
#
#
# Posnr 9100
#
WWWRUN	INSERT	Leistungsart	POSNR='9100' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9100','B','Betriebskostenpauschale vollendete Geb. vor QM',637.00,'Betriebskostenpauschale für eine vollendete Geburt in einer von Hebammen geleiteten Einrichtung bis zum Zeitpunkt der Einführung eines QM-Systems','2012-07-01','2012-12-31','','','','','',0,'');
#
#
# Posnr 9200
#
WWWRUN	INSERT	Leistungsart	POSNR='9200' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9200','B','Betriebskostenpauschale nicht-vollendete Geb. nach QM',525.00,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach weniger als 4 Stunden, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2012-07-01','2012-12-31','','','','','',0,'');
#
#
# Posnr 9300
#
WWWRUN	INSERT	Leistungsart	POSNR='9300' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9300','B','Betriebskostenpauschale nicht-vollendete Geb. vor QM',477.75,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach weniger als 4 Stunden bis zum Zeitpunkt der Einführung eines QM-Systems','2012-07-01','2012-12-31','','','','','',0,'');
#
#
# Posnr 9400
#
WWWRUN	INSERT	Leistungsart	POSNR='9400' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9400','B','Betriebskostenpauschale nicht-vollendete Geb. nach QM',700.00,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach mehr als 4 Stunden, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2012-07-01','2012-12-31','','','','','',0,'');
#
#
# Posnr 9500
#
WWWRUN	INSERT	Leistungsart	POSNR='9500' and GUELT_VON='2012-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9500','B','Betriebskostenpauschale nicht-vollendete Geb. vor QM',637.00,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach mehr als 4 Stunden bis zum Zeitpunkt der Einführung eines QM-Systems','2012-07-01','2012-12-31','','','','','',0,'');
#
#
#
# -------- geänderte Positionsnummern w/ Betriebskostenpauschale ab 01.01.2013
#
# Posnr 9000
WWWRUN	INSERT	Leistungsart	POSNR='9000' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9000','B','Betriebskostenpausch. vollendete Geb. nach QM',707.00,'Betriebskostenpauschale für eine vollendete Geburt in einer von Hebammen geleiteten Einrichtung, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2013-01-01','9999-12-31','','','','','',0,'');
#
#
# Posnr 9100
#
WWWRUN	INSERT	Leistungsart	POSNR='9100' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9100','B','Betriebskostenpauschale vollendete Geb. vor QM',637.00,'Betriebskostenpauschale für eine vollendete Geburt in einer von Hebammen geleiteten Einrichtung bis zum Zeitpunkt der Einführung eines QM-Systems','2013-01-01','9999-12-31','','','','','',0,'');
#
#
# Posnr 9200
#
WWWRUN	INSERT	Leistungsart	POSNR='9200' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9200','B','Betriebskostenpauschale nicht-vollendete Geb. nach QM',675.00,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach weniger als 4 Stunden, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2013-01-01','9999-12-31','','','','','',0,'');
#
#
# Posnr 9300
#
WWWRUN	INSERT	Leistungsart	POSNR='9300' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9300','B','Betriebskostenpauschale nicht-vollendete Geb. vor QM',580.00,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach weniger als 4 Stunden bis zum Zeitpunkt der Einführung eines QM-Systems','2013-01-01','9999-12-31','','','','','',0,'');
#
#
# Posnr 9400
#
WWWRUN	INSERT	Leistungsart	POSNR='9400' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9400','B','Betriebskostenpauschale nicht-vollendete Geb. nach QM',707.00,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach mehr als 4 Stunden, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2013-01-01','9999-12-31','','','','','',0,'');
#
#
# Posnr 9500
#
WWWRUN	INSERT	Leistungsart	POSNR='9500' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9500','B','Betriebskostenpauschale nicht-vollendete Geb. vor QM',637.00,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach mehr als 4 Stunden bis zum Zeitpunkt der Einführung eines QM-Systems','2013-01-01','9999-12-31','','','','','',0,'');
#
#
# -------- update w/ neuer Felder
#
# Kilometer j/n
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where LEISTUNGSTYP = 'M';
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where POSNR in('0400','0401','0402');
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where POSNR in('0600','0601','0602');
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where POSNR = '0700';
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where POSNR in('1400','1401','1402');
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where POSNR in('1500','1501','1502');
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where POSNR = '1900';
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where POSNR in('2200','2201','2202');
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where POSNR in('2300','2301','2302');
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where POSNR in('2400','2401','2402');
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where POSNR in('2500','2501','2502');
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where POSNR = '2700';
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where POSNR = '2820';
WWWRUN	UPDATE	Leistungsart		update Leistungsart set KILOMETER='N' where POSNR = '2900';
#
#
#
# Begründungspflicht POSNR 2600,2610
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set BEGRUENDUNGSPFLICHT='j' where POSNR in ('2600','2601','2602','2610','2611','2612');
#
#
#
# ----- update Position 160* ist nicht neben Gebühr 0901 bis 1210 abrechnungsfähig
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set NICHT='0901,0902,0911,0912,1000,1010,1100,1110,1200,1210' where POSNR in ('1600','1601','1602','1610','1611','1612');
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set NICHT='1600,1601,1602,1610,1611,1612' where POSNR in ('0901','0902','0911','0912','1000','1010','1100','1110','1200','1210');
#
#
#
# Fehlerkorrektur Positionsnummer 1110
# 560,64 statt 560,65
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set EINZELPREIS=560.64 where POSNR = '1110' AND GUELT_VON = '2010-07-01';
#
#
#
# sonstige Leistungen
# Leistungsgruppe E in tinyHeb Leistungsgruppe M
# ----- geändert ab 01.08.2012
#
# PosNr 3400
#
WWWRUN	INSERT	Leistungsart	POSNR='3400' and GUELT_VON='2012-08-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,NICHT) values (9999,'3400','M','Pauschale Vorsorgeuntersuchung',2.83,'Materialpauschale Vorsorgeuntersuchung als ambulante hebammenhilfliche Leistung','2012-08-01','9999-12-31',0,'3500');
#
# PosNr 3500
#
WWWRUN	INSERT	Leistungsart	POSNR='3500' and GUELT_VON='2012-08-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,NICHT) values (9999,'3500','M','Pauschale Schwangerschaftsbeschw.',2.08,'Materialpauschale bei Schwangerschaftsbeschwerden oder bei Wehen als ambulante hebammenhilfliche Leistung','2012-08-01','9999-12-31',0,'3400,3600');
#
# PosNr. 3600
#
WWWRUN	INSERT	Leistungsart	POSNR='3600' and GUELT_VON='2012-08-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,NICHT) values (9999,'3600','M','Pauschale Geburtshilfe',52.36,'Materialpauschale Geburtshilfe','2012-08-01','9999-12-31',0,'3500');
#
# PosNr. 3700
#
WWWRUN	INSERT	Leistungsart	POSNR='3700' and GUELT_VON='2012-08-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3700','M','Pauschale Naht bei Geburtsverletzung',39.00,'Materialpauschale, zusätzlich zu Nr. 3600, bei Versorgung einer Naht bei Geburtsverletzungen als ambulante hebammenhilfliche Leistung','2012-08-01','9999-12-31',0);
#
# PosNr. 3800
#
WWWRUN	INSERT	Leistungsart	POSNR='3800' and GUELT_VON='2012-08-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3800','M','Pauschale Wochenbettbetreuung',25.76,'Materialpauschale Wochenbettbetreuung','2012-08-01','9999-12-31',0);
#
#
# PosNr. 3810
# ----- neu ab 01.08.2012 -----
#
WWWRUN	INSERT	Leistungsart	POSNR='3810' and GUELT_VON='2012-08-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3810','M','Pauschale Neugeborenen-Screening',2.97,'Materialpauschale Neugeborenen-Screening als ambulante hebammenhilfliche Leistung','2012-08-01','9999-12-31',0);
#
#
# PosNr. 3900
#
WWWRUN	INSERT	Leistungsart	POSNR='3900' and GUELT_VON='2012-08-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3900','M','Pauschale Wochenbettbetreuung nach 4 Tag p.p.',15.96,'Materialpauschale bei Beginn der Betreuung später als vier Tage nach der Geburt','2012-08-01','9999-12-31',0);
#
# PosNr. 3910
# ----- neu ab 01.08.2012 -----
#
WWWRUN	INSERT	Leistungsart	POSNR='3910' and GUELT_VON='2012-08-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3910','M','Pauschale Fäden ziehen Dammnaht',7.09,'Materialpauschale Fäden ziehen Dammnaht als ambulante hebammenhilfliche Leistung','2012-08-01','9999-12-31',0);
#
# PosNr. 3920
# ----- neu ab 01.08.2012 -----
#
WWWRUN	INSERT	Leistungsart	POSNR='3920' and GUELT_VON='2012-08-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3920','M','Pauschale Fäden entfernen Sectionaht',5.54,'Materialpauschale Fäden/Klammern entfernen Sectionaht als ambulante hebammenhilfliche Leistung','2012-08-01','9999-12-31',0);
#
