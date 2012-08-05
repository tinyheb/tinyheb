# Updates für tinyHeb
#
# $Id: update.sql,v 1.24 2012-08-05 07:55:47 thomas_baum Exp $
# Tag $Name: not supported by cvs2svn $
#
#
# neues Feld Lastupdate in Tabelle Leistungsart einführen
#
ROOT	ALTER	Leistungsart		alter table Leistungsart add LASTUPDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL AFTER NICHT;
#
#
# Kurzbezeichnung erweitern
#
ROOT	ALTER	Leistungsart		alter table Leistungsart MODIFY COLUMN KBEZ VARCHAR(60);
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
# Gebührenordnung für Materialpauschalen vom 01.01.2010 für bestimmte Posnr ungültig machen
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-07-31' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('3400','3500','3600','3700','3800','3900');
#
#
# alte Matrialien ungültig machen
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2009-12-31' where GUELT_VON = '2007-08-01' and GUELT_BIS = '9999-12-31';
#
#
# Neue Gebührenordnung ab 01.01.2010
#
# Leistungen der Mutterschaftsvorsorge und Schwangerenbetreuung
# Leistungsgruppe A
# 
# PosNr 0100
#
WWWRUN	INSERT	Leistungsart	POSNR='0100' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0100','A','Beratung',5.81,'Beratung der Schwangeren, auch mittels Kommunikationsmedium','2010-01-01','9999-12-31');
#
#
# PosNr 0101
#
WWWRUN	INSERT	Leistungsart	POSNR='0101' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0101','A','Beratung Beleghebamme',5.81,'Beratung der Schwangeren, auch mittels Kommunikationsmedium durch Beleghebamme','2010-01-01','9999-12-31');
#
#
# PosNr 0102
#
WWWRUN	INSERT	Leistungsart	POSNR='0102' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0102','A','Beratung Beleghebamme 1:1',5.81,'Beratung der Schwangeren, auch mittels Kommunikationsmedium durch Beleghebamme bei 1:1 Betreuung','2010-01-01','9999-12-31');
#
#
#
#
# PosNr 0200
#
WWWRUN	INSERT	Leistungsart	POSNR='0200' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'0200','A','Vorgespräch',7.50,'Vorgespräch über Fragen der Schwangerschaft und Geburt,mindestens 30 Minuten, je angefangene 15 Minuten','2010-01-01','9999-12-31',15);
#
#
#
# PosNr 0300
#
WWWRUN	INSERT	Leistungsart	POSNR='0300' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0300','A','Vorsorgeuntersuchung',22.44,'Vorsorgeuntersuchung der Schwangeren nach Maßgabe der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung in der jeweils geltenden Fassung','2010-01-01','9999-12-31',0,'+3400');
#
#
# PosNr 0400
#
WWWRUN	INSERT	Leistungsart	POSNR='0400' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0400','A','Entnahme von Körpermaterial',5.71,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung','2010-01-01','9999-12-31',0,'');
#
#
# PosNr 0401
#
WWWRUN	INSERT	Leistungsart	POSNR='0401' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0401','A','Entnahme von Körpermaterial Belegheb.',5.71,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung durch Beleghebamme','2010-01-01','9999-12-31',0,'');
#
# PosNr 402
#
WWWRUN	INSERT	Leistungsart	POSNR='0402' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0402','A','Entnahme von Körpermaterial Belegheb. 1:1',5.71,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung durch Beleghebamme 1:1','2010-01-01','9999-12-31',0,'');
#
#
# PosNr 0500
#
WWWRUN	INSERT	Leistungsart	POSNR='0500' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0500','A','Hilfe bei Beschw.',15.00,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten','2010-01-01','9999-12-31',30,'+3500','0510','0510','0510',180);
#
#
# PosNr 0501
#
WWWRUN	INSERT	Leistungsart	POSNR='0501' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0501','A','Hilfe bei Beschw. Belegheb.',15.00,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten Beleghebamme','2010-01-01','9999-12-31',30,'+3500','0511','0511','0511',180);
#
# PosNr 0502
# 
WWWRUN	INSERT	Leistungsart	POSNR='0502' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0502','A','Hilfe bei Beschw. Belegheb. 1:1',15.00,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten Beleghebamme 1:1','2010-01-01','9999-12-31',30,'+3500','0512','0512','0512',180);
#
#
# PosNr 0510
#
WWWRUN	INSERT	Leistungsart	POSNR='0510' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0510','A','Hilfe bei Beschw. Sa,So,Nacht',18.00,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1','2010-01-01','9999-12-31',30,'+3500','','','',180);
#
#
# PosNr 0511
#
WWWRUN	INSERT	Leistungsart	POSNR='0511' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0511','A','Hilfe bei Beschw. Sa,So,Nacht Belegheb.',18.00,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','9999-12-31',30,'+3500','','','',180);
#
# PosNr 0512
#
WWWRUN	INSERT	Leistungsart	POSNR='0512' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0512','A','Hilfe bei Beschw. Sa,So,Nacht Belegheb. 1:1',18.00,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-01-01','9999-12-31',30,'+3500','','','',180);
#
#
# PosNr 0600
#
WWWRUN	INSERT	Leistungsart	POSNR='0600' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0600','A','CTG Überwachung',6.43,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung.','2010-01-01','9999-12-31',0,'','','','',0);
#
#
# PosNr 0601
#
WWWRUN	INSERT	Leistungsart	POSNR='0601' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0601','A','CTG Überwachung Belegheb.',6.43,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung. Beleghebamme','2010-01-01','9999-12-31',0,'','','','',0);
#
#
# PosNr 0602
#
WWWRUN	INSERT	Leistungsart	POSNR='0602' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0602','A','CTG Überwachung Belegheb. 1:1',6.43,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung. Beleghebamme 1:1','2010-01-01','9999-12-31',0,'','','','',0);
#
#
# Posnr 0700
#
WWWRUN	INSERT	Leistungsart	POSNR='0700' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0700','A','Geburtsvorbereitung in der Gruppe',5.71,'Geburtsvorbereitung bei Unterweisung in der Gruppe, bis zu zehn Schwangere je Gruppe und höchsten 14 Stunden, für jede Schwangere je Unterrichtsstunden (60 Minuten)','2010-01-01','9999-12-31','E60','','','','',0);
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
WWWRUN	INSERT	Leistungsart	POSNR='0901' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0901','B','Geburt im Krankenhaus Belegheb.',237.85,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme','2010-01-01','9999-12-31',0,'','0911','0911','0911',0);
#
# PosNr 0902
#
WWWRUN	INSERT	Leistungsart	POSNR='0902' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0902','B','Geburt im Krankenhaus Belegheb. 1:1',237.85,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme 1:1','2010-01-01','9999-12-31',0,'','0912','0912','0912',0);
#
#
#
# PosNr 0911
#
WWWRUN	INSERT	Leistungsart	POSNR='0911' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0911','B','Geburt im K-Haus, Nacht,Sa,So Belegheb.',285.42,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','9999-12-31',0,'','','','',0);
#
#
# PosNr 0912
#
WWWRUN	INSERT	Leistungsart	POSNR='0912' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0912','B','Geburt im K-Haus, Nacht,Sa,So Belegheb. 1:1',285.42,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-01-01','9999-12-31',0,'','','','',0);
#
#
# PosNr 1000
#
WWWRUN	INSERT	Leistungsart	POSNR='1000' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1000','B','Geburt außerkl. ärztl. Leitung',237.85,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung','2010-01-01','9999-12-31',0,'+3600','1010','1010','1010',0);
#
# PosNr 1010
#
WWWRUN	INSERT	Leistungsart	POSNR='1010' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1010','B','Geburt außerkl. ärztl. Leitung, Nacht,Sa,So',285.42,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2010-01-01','9999-12-31',0,'+3600','','','',0);
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
WWWRUN	INSERT	Leistungsart	POSNR='1300' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1300','B','Hilfe bei Fehlgeburt',160.0,'Hilfe bei einer Fehlgeburt','2010-1-01','9999-12-31',0,'+3600','1310','1310','1310',0);
#
# PosNr 1301
#
WWWRUN	INSERT	Leistungsart	POSNR='1301' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1301','B','Hilfe bei Fehlgeburt Belegheb.',160.0,'Hilfe bei einer Fehlgeburt Beleghebamme','2010-1-01','9999-12-31',0,'+3600','1311','1311','1311',0);
#
#
# PosNr 1302
#
WWWRUN	INSERT	Leistungsart	POSNR='1302' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1302','B','Hilfe bei Fehlgeburt Belegheb. 1:1',160.0,'Hilfe bei einer Fehlgeburt Beleghebamme 1:1','2010-1-01','9999-12-31',0,'+3600','1312','1312','1312',0);
#
#
# PosNr 1310
#
WWWRUN	INSERT	Leistungsart	POSNR='1310' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1310','B','Hilfe bei Fehlgeburt Nacht,Sa,So',192.00,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1','2010-01-01','9999-12-31',0,'+3600','','','',0);
#
# PosNr 1311
#
WWWRUN	INSERT	Leistungsart	POSNR='1311' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1311','B','Hilfe bei Fehlgeb. Nacht,Sa,So Belegheb.',192.00,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','9999-12-31',0,'+3600','','','',0);
#
# PosNr 1312
#
WWWRUN	INSERT	Leistungsart	POSNR='1312' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1312','B','Hilfe bei Fehlgeb. Nacht,Sa,So Belegheb. 1:1',192.00,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-01-01','9999-12-31',0,'+3600','','','',0);
#
#
# PosNr 1400
#
WWWRUN	INSERT	Leistungsart	POSNR='1400' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1400','B','Vers. Schnitt-/ Rissverletzung ohne DR III/IV',30.0,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV','2010-01-01','9999-12-31',0,'+3700','','','',0);
#
#
# PosNr 1401
#
WWWRUN	INSERT	Leistungsart	POSNR='1401' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1401','B','Vers. Schnitt-/ Rissv. ohne DR III/IV Belegheb.',30.0,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV durch Beleghebamme','2010-01-01','9999-12-31',0,'+3700','','','',0);
#
#
# PosNr 1402
#
WWWRUN	INSERT	Leistungsart	POSNR='1402' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1402','B','Vers. Schnitt-/ Rissv. ohne DR III/IV Belegheb. 1:1',30.0,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV durch Beleghebamme 1:1','2010-01-01','9999-12-31',0,'+3700','','','',0);
#
#
# PosNr 1500
#
WWWRUN	INSERT	Leistungsart	POSNR='1500' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1500','B','Zuschlag Zwillinge',70.00,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind','2010-01-01','9999-12-31','','','','','',0);
#
# PosNr 1501
#
WWWRUN	INSERT	Leistungsart	POSNR='1501' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1501','B','Zuschlag Zwillinge Belegheb.',70.00,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind Beleghebamme','2010-01-01','9999-12-31','','','','','',0);
#
# PosNr 1502
#
WWWRUN	INSERT	Leistungsart	POSNR='1502' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1502','B','Zuschlag Zwillinge Belegheb. 1:1',70.00,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind Beleghebamme 1:1','2010-01-01','9999-12-31','','','','','',0);
# 
#
# PosNr 1600
#
WWWRUN	INSERT	Leistungsart	POSNR='1600' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1600','B','Hilfe bei nicht vollendeter Geburt',172.8,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung','2010-01-01','9999-12-31',0,'','1610','1610','1610',0);
#
# PosNr 1601
#
WWWRUN	INSERT	Leistungsart	POSNR='1601' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1601','B','Hilfe bei nicht vollendeter Geb. Belegheb.',172.8,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2010-01-01','9999-12-31',0,'','1611','1611','1611',0);
#
# PosNr 1602
#
WWWRUN	INSERT	Leistungsart	POSNR='1602' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1602','B','Hilfe bei nicht vollendeter Geb. Belegheb. 1:1',172.8,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2010-01-01','9999-12-31',0,'','1612','1612','1612',0);
#
#
# PosNr 1610
#
WWWRUN	INSERT	Leistungsart	POSNR='1610' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1610','B','Hilfe bei nicht vollendeter Geburt Nacht,Sa,So',207.36,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2010-01-01','9999-12-31',0,'','','','',0);
#
# PosNr 1611
#
WWWRUN	INSERT	Leistungsart	POSNR='1611' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1611','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb.',207.36,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','9999-12-31',0,'','','','',0);
#
# PosNr 1612
#
WWWRUN	INSERT	Leistungsart	POSNR='1612' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1612','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb. 1:1',207.36,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-01-01','9999-12-31',0,'','','','',0);
#
#
# PosNr. 1700
#
WWWRUN	INSERT	Leistungsart	POSNR='1700' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1700','B','2. Hebamme',20.60,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2010-01-01','9999-12-31','30','+3600','1710','1710','1710',240);
#
# PosNr. 1701
#
WWWRUN	INSERT	Leistungsart	POSNR='1701' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1701','B','2. Hebamme Beleghebamme',20.60,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2010-01-01','9999-12-31','30','+3600','1711','1711','1711',240);
#
# PosNr. 1702
#
WWWRUN	INSERT	Leistungsart	POSNR='1702' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1702','B','2. Hebamme Beleghebamme 1:1',20.60,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2010-01-01','9999-12-31','30','+3600','1712','1712','1712',240);
#
#
# PosNr. 1710
#
WWWRUN	INSERT	Leistungsart	POSNR='1710' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1710','B','2. Hebamme Nacht,Sa,So',24.72,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1','2010-01-01','9999-12-31','30','+3600','','','',240);
#
# PosNr. 1711
#
WWWRUN	INSERT	Leistungsart	POSNR='1711' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1711','B','2. Hebamme Nacht,Sa,So Belegheb.',24.72,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','9999-12-31','30','+3600','','','',240);
#
# PosNr. 1712
#
WWWRUN	INSERT	Leistungsart	POSNR='1712' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1712','B','2. Hebamme Nacht,Sa,So Belegheb. 1:1',24.72,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','9999-12-31','30','+3600','','','',240);
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
WWWRUN	INSERT	Leistungsart	POSNR='1900' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,ZUSATZGEBUEHREN2,ZUSATZGEBUEHREN3,ZUSATZGEBUEHREN4,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1900','C','Zuschlag 1. Wochenbettbetreuung nach der Geburt',5.71,'Zuschlag zu der Gebühr nach Nr. 1800 für die erste aufsuchende Wochenbettbetreuung nach der Geburt','2010-01-01','9999-12-31','','+3800','<5GK','+3900','>4GK','','','',0,'');
#
#
# PosNr 2001
#
WWWRUN	INSERT	Leistungsart	POSNR='2001' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2001','C','Wochenbettbetreuung in K-Haus Belegheb.',13.16,'aufsuchende Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2010-01-01','9999-12-31',0,'','2011','2011','2011',0,'');
#
# PosNr 2002
#
WWWRUN	INSERT	Leistungsart	POSNR='2002' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2002','C','Wochenbettbetreuung in K-Haus Belegheb. 1:1',13.16,'aufsuchende Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme 1:1','2010-01-01','9999-12-31',0,'','2012','2012','2012',0,'');
#
#
# PosNr 2011
#
WWWRUN	INSERT	Leistungsart	POSNR='2011' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2011','C','Wochenbettbetr. in K-Haus Nacht,Sa,So Belegheb.',15.79,'Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','9999-12-31',0,'','','','',0,'');
#
# PosNr 2012
#
WWWRUN	INSERT	Leistungsart	POSNR='2012' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2012','C','Wochenbettbetr. in K-Haus Nacht,Sa,So Belegheb. 1:1',15.79,'Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-01-01','9999-12-31',0,'','','','',0,'');
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
WWWRUN	INSERT	Leistungsart	POSNR='2300' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2300','C','Beratung mittels Kommunikationsmedium',5.1,'Beratung der Wöchnerin mittels Kommunikationsmedium','2010-01-01','9999-12-31','','','','','',0,'');
#
# PosNr 2301
#
WWWRUN	INSERT	Leistungsart	POSNR='2301' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2301','C','Beratung mittels Kommunikationsmedium Belegheb.',5.1,'Beratung der Wöchnerin mittels Kommunikationsmedium durch Beleghebamme','2010-01-01','9999-12-31','','','','','',0,'');
#
# PosNr 2302
#
WWWRUN	INSERT	Leistungsart	POSNR='2302' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2302','C','Beratung mittels Kommunikationsmed. Belegheb. 1:1',5.1,'Beratung der Wöchnerin mittels Kommunikationsmedium durch Beleghebamme 1:1','2010-01-01','9999-12-31','','','','','',0,'');
#
#
# PosNr. 2400
#
WWWRUN	INSERT	Leistungsart	POSNR='2400' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2400','C','Erstuntersuchung (U1)',7.65,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung.','2010-01-01','9999-12-31','','','','','',0,'');
#
# PosNr. 2401
#
WWWRUN	INSERT	Leistungsart	POSNR='2401' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2401','C','Erstuntersuchung (U1) Beleghebamme',7.65,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung Beleghebamme.','2010-01-01','9999-12-31','','','','','',0,'');
#
# PosNr. 2402
#
WWWRUN	INSERT	Leistungsart	POSNR='2402' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2402','C','Erstuntersuchung (U1) Beleghebamme 1:1',7.65,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung Beleghebamme 1:1.','2010-01-01','9999-12-31','','','','','',0,'');
#
#
# PosNr. 2500
#
WWWRUN	INSERT	Leistungsart	POSNR='2500' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2500','C','Entnahme von Körpermaterial',5.71,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung','2010-01-01','9999-12-31','','','','','',0,'');
#
# PosNr. 2501
#
WWWRUN	INSERT	Leistungsart	POSNR='2501' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2501','C','Entnahme von Körpermaterial Belegheb.',5.71,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung Beleghebamme','2010-01-01','9999-12-31','','','','','',0,'');
#
# PosNr. 2502
#
WWWRUN	INSERT	Leistungsart	POSNR='2502' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2502','C','Entnahme von Körpermaterial Belegheb. 1:1',5.71,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung Beleghebamme','2010-01-01','9999-12-31','','','','','',0,'');
#
# ------------- sonstige Leisrungen -------------
#
# sonstige Leistungen
# Leistungsgruppe D
# 
# PosNr 2600
#
WWWRUN	INSERT	Leistungsart	POSNR='2600' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2600','D','Überwachung',15.00,'Überwachung, je angefangene halbe Stunde','2010-01-01','9999-12-31','30','','2610','2610','2610',0,'');
#
# PosNr 2601
#
WWWRUN	INSERT	Leistungsart	POSNR='2601' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2601','D','Überwachung Beleghebamme',15.00,'Überwachung, je angefangene halbe Stunde durch Beleghebamme','2010-01-01','9999-12-31','30','','2611','2611','2611',0,'');
#
# PosNr 2602
#
WWWRUN	INSERT	Leistungsart	POSNR='2602' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2602','D','Überwachung Beleghebamme 1:1',15.00,'Überwachung, je angefangene halbe Stunde durch Beleghebamme 1::1','2010-01-01','9999-12-31','30','','2612','2612','2612',0,'');
#
#
# PosNr 2610
#
WWWRUN	INSERT	Leistungsart	POSNR='2610' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2610','D','Überwachung Nacht,Sa,So',18.00,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1','2010-01-01','9999-12-31','30','','','','',0,'');
#
# PosNr 2611
#
WWWRUN	INSERT	Leistungsart	POSNR='2611' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2611','D','Überwachung Nacht,Sa,So Belegheb.',18.00,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-01-01','9999-12-31','30','','','','',0,'');
#
# PosNr 2612
#
WWWRUN	INSERT	Leistungsart	POSNR='2612' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2612','D','Überwachung Nacht,Sa,So Belegheb. 1:1',18.00,'Überwachung, je angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-01-01','9999-12-31','30','','','','',0,'');
#
#
# PosNr 2700
#
WWWRUN	INSERT	Leistungsart	POSNR='2700' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2700','D','Rückbildungsgymnastik Gruppe',5.71,'Rückbildungsgymnastik bei Unterweisung in der Gruppe, bis zu zehn Teilnehmerinnen je Gruppe und höchstens zehn Stunden, für jede Teilnehmerin je Unterrichtsstunde (60 Minute)','2010-01-01','9999-12-31','E60','','','','',0,'');
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
WWWRUN	INSERT	Leistungsart	POSNR='2900' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2900','D','Beratung bei Stillschw. per Kommunikationsmedium',5.1,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings mittels Kommunikationsmedium','2010-01-01','9999-12-31','','','','','',0,'');
#
##
# ------------ Wegegeld -------------------------
#
# In GO Leistungsgruppe E in tinyHeb Leistungsgruppe W
#
# PosNr 3000 Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3000' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3000','W','Wegegeld nicht mehr als 2 KM bei Tag',1.68,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2010-01-01','9999-12-31',0);
#
# PosNr 3010 anteiliges Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3010' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3010','W','ant. Wegegeld nicht mehr als 2 KM bei Tag',1.68,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2010-01-01','9999-12-31',0);
#
# PosNr 3100 Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3100' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3100','W','Wegegeld nicht mehr als 2 KM bei Nacht',2.38,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2010-01-01','9999-12-31',0);
#
# PosNr 3110 anteiliges Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3110' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3110','W','ant. Wegegeld nicht mehr als 2 KM bei Nacht',2.38,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2010-01-01','9999-12-31',0);
#
# PosNr 3200 Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3200' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3200','W','Wegegeld von mehr als 2 KM bei Tag',0.59,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2010-01-01','9999-12-31',0);
#
# PosNr 3210 anteiliges Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3210' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3210','W','ant. Wegegeld von mehr als 2 KM bei Tag',0.59,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2010-01-01','9999-12-31',0);
#
# PosNr 3300 Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3300' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3300','W','Wegegeld von mehr als 2 KM bei Nacht',0.81,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2010-01-01','9999-12-31',0);
#
#
# PosNr 3310 anteiliges Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3310' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3310','W','ant. Wegegeld von mehr als 2 KM bei Nacht',0.81,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2010-01-01','9999-12-31',0);
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
WWWRUN	INSERT	Leistungsart	POSNR='4000' and GUELT_VON='2010-01-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'4000','M','Perinatalerhebung',7.5,'Perinatalerhebung bei einer außerklinischen Geburt nach vorgeschriebenem Formblatt einschließlich Versand- und Portokosten','2010-01-01','9999-12-31',0);
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
WWWRUN	INSERT	Leistungsart	POSNR='0800' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,BEGRUENDUNGSPFLICHT) values (9999,'0800','A','Einzelgeburtsvorbereitung',7.50,'Geburtsvorbereitung bei Einzelunterweisung auf ärztliche Anordnung höchstens 28 Unterrichtseinheiten a 15 Minuten, für jede angefangenen 15 Minuten','2010-07-01','9999-12-31','15','','','','',0,'J');
#
# PosNr 1100
#
WWWRUN	INSERT	Leistungsart	POSNR='1100' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1100','B','Geburt außerkl. Leitung Hebammen',467.2,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung','2010-07-01','9999-12-31',0,'+3600','1110','1110','1110',0);
#
# PosNr 1110
#
WWWRUN	INSERT	Leistungsart	POSNR='1110' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1110','B','Geburt außerkl. Leitung Hebammen Nacht,Sa,So',560.65,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung mit Zuschlag gemäß §5 Abs. 1','2010-07-01','9999-12-31',0,'+3600','','','',0);
#
# PosNr 1200
#
WWWRUN	INSERT	Leistungsart	POSNR='1200' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1200','B','Hilfe bei Hausgeburt',548.80,'Hilfe bei Hausgeburt','2010-07-01','9999-12-31',0,'+3600','1210','1210','1210',0);
#
# PosNr 1210
#
WWWRUN	INSERT	Leistungsart	POSNR='1210' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1210','B','Hilfe bei Hausgeburt Nacht,Sa,So',658.56,'Hilfe bei Hausgeburt mit Zuschlag gemäß §5 Abs. 1','2010-07-01','9999-12-31',0,'+3600','','','',0);
#
#
#
# PosNr. 1800
#
WWWRUN	INSERT	Leistungsart	POSNR='1800' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1800','C','Wochenbettbetreuung',27.00,'aufsuchende Wochenbettbetreuung nach der Geburt','2010-07-01','9999-12-31',0,'','1810','1810','1810',0,'+1900');
#
# PosNr. 1801
#
WWWRUN	INSERT	Leistungsart	POSNR='1801' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1801','C','Wochenbettbetreuung Beleghebamme',27.00,'aufsuchende Wochenbettbetreuung nach der Geburt Beleghebamme','2010-07-01','9999-12-31',0,'','1811','1811','1811',0,'+1900');
#
# PosNr. 1802
#
WWWRUN	INSERT	Leistungsart	POSNR='1802' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1802','C','Wochenbettbetreuung Beleghebamme 1:1',27.00,'aufsuchende Wochenbettbetreuung nach der Geburt Beleghebamme 1:1','2010-07-01','9999-12-31',0,'','1812','1812','1812',0,'+1900');
#
#
# PosNr. 1810
#
WWWRUN	INSERT	Leistungsart	POSNR='1810' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1810','C','Wochenbettbetreuung Nacht,Sa,So',32.40,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2010-07-01','9999-12-31',0,'','','','',0,'+1900');
#
# PosNr. 1811
#
WWWRUN	INSERT	Leistungsart	POSNR='1811' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1811','C','Wochenbettbetreuung Nacht,Sa,So Beleghebamme',32.40,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2010-07-01','9999-12-31',0,'','','','',0,'+1900');
#
# PosNr. 1812
#
WWWRUN	INSERT	Leistungsart	POSNR='1812' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1812','C','Wochenbettbetreuung Nacht,Sa,So Beleghebamme 1:1',32.40,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2010-07-01','9999-12-31',0,'','','','',0,'+1900');
#
#
# PosNr. 2100
#
WWWRUN	INSERT	Leistungsart	POSNR='2100' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2100','C','Wochenbettbetreuung in Einr. Leitung Heb.',22.00,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt','2010-07-01','9999-12-31',0,'','2110','2110','2110',0,'');
#
#
# PosNr. 2110
#
WWWRUN	INSERT	Leistungsart	POSNR='2110' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2110','C','Wochenbettbetr. in Einr. Leitung Heb. Nacht,Sa,So',26.4,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2010-07-01','9999-12-31',0,'','','','',0,'');
#
#
# PosNr 2200
#
WWWRUN	INSERT	Leistungsart	POSNR='2200' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2200','C','Zuschlag Zwillinge',9.30,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind','2010-07-01','9999-12-31','','','','','',0,'');
#
# PosNr 2201
#
WWWRUN	INSERT	Leistungsart	POSNR='2201' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2201','C','Zuschlag Zwillinge Beleghebamme',9.30,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind Beleghebamme','2010-07-01','9999-12-31','','','','','',0,'');
#
# PosNr 2202
#
WWWRUN	INSERT	Leistungsart	POSNR='2202' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2202','C','Zuschlag Zwillinge Beleghebamme 1:1',9.30,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind Beleghebamme 1:1','2010-07-01','9999-12-31','','','','','',0,'');
#
#
#
# PosNr 2800
#
WWWRUN	INSERT	Leistungsart	POSNR='2800' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2800','D','Beratung bei Stillschwierigkeiten',27.00,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings','2010-07-01','9999-12-31',0,'','2810','2810','2810',0,'');
#
#
# PosNr 2810
#
WWWRUN	INSERT	Leistungsart	POSNR='2810' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2810','D','Beratung bei Stillschw. Nacht,Sa,So',32.40,'Beratung der Mutter bei Stillschwierigkeiten oder Ernährungsproblemen des Säuglings mit Zuschlag gemäß §5 Abs. 1','2010-07-01','9999-12-31','','','','','',0,'');
#
# PosNr 2820
#
WWWRUN	INSERT	Leistungsart	POSNR='2820' and GUELT_VON='2010-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2820','D','Zuschlag Zwillinge bei Stillschw.',9.30,'Zuschlag für die Beratung der Mutter bei Stillschwierigkeiten oder Ernührungsproblemen bei Zwillingen und mehr Kindern zu den Gebühren nach 2800 und 2810 für das zweite und jedes weitere Kind, je Kind','2010-07-01','9999-12-31','','','','','',0,'');
#
#
# -------- neue Positionsnummern w/ Betriebskostenpauschale ab 27.06.2011
#
# Posnr 0900
WWWRUN	INSERT	Leistungsart	POSNR='0900' and GUELT_VON='2011-06-27' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'0900','B','Betriebskostenpausch. vollendete Geb. nach QM',550.00,'Betriebskostenpauschale für eine vollendete Geburt in einer von Hebammen geleiteten Einrichtung, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2011-06-27','9999-12-31','','','','','',0,'');
#
#
# Posnr 0910
#
WWWRUN	INSERT	Leistungsart	POSNR='0910' and GUELT_VON='2011-06-27' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'0910','B','Betriebskostenpauschale vollendete Geb. vor QM',500.50,'Betriebskostenpauschale für eine vollendete Geburt in einer von Hebammen geleiteten Einrichtung bis zum Zeitpunkt der Einführung eines QM-Systems','2011-06-27','9999-12-31','','','','','',0,'');
#
# 
# Posnr 0920
#
WWWRUN	INSERT	Leistungsart	POSNR='0920' and GUELT_VON='2011-06-27' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'0920','B','Betriebskostenpauschale nicht-vollendete Geb. nach QM',412.50,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach weniger als 4 Stunden, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2011-06-27','9999-12-31','','','','','',0,'');
#
#
# Posnr 0930
#
WWWRUN	INSERT	Leistungsart	POSNR='0930' and GUELT_VON='2011-06-27' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'0930','B','Betriebskostenpauschale nicht-vollendete Geb. vor QM',375.38,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach weniger als 4 Stunden bis zum Zeitpunkt der Einführung eines QM-Systems','2011-06-27','9999-12-31','','','','','',0,'');
#
#
# Posnr 0940
#
WWWRUN	INSERT	Leistungsart	POSNR='0940' and GUELT_VON='2011-06-27' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'0940','B','Betriebskostenpauschale nicht-vollendete Geb. nach QM',550.00,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach mehr als 4 Stunden, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2011-06-27','9999-12-31','','','','','',0,'');
#
#
# Posnr 0950
#
WWWRUN	INSERT	Leistungsart	POSNR='0950' and GUELT_VON='2011-06-27' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'0950','B','Betriebskostenpauschale nicht-vollendete Geb. vor QM',500.50,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach mehr als 4 Stunden bis zum Zeitpunkt der Einführung eines QM-Systems','2011-06-27','9999-12-31','','','','','',0,'');
#
#
#
# -------- eigene Positionsnummern w/ Materialien
#
# PosNr M006
#
#WWWRUN	INSERT	Leistungsart	POSNR='M006' and GUELT_VON='2008-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'M006','M','Betaisodona Salbe',5.2,'Betaisodona Salbe','2008-07-01','9999-12-31',0,'');
#
# PosNr M007
#
#WWWRUN	INSERT	Leistungsart	POSNR='M007' and GUELT_VON='2008-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'M007','M','Wecesinpuder zur Nabelpflege (50 g)',6.62,'Wecesinpuder zur Nabelpflege 50 Gramm','2008-07-01','9999-12-31',0,'');
#
#
# PosNr M008
#
#WWWRUN	INSERT	Leistungsart	POSNR='M008' and GUELT_VON='2008-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'M008','M','Moronal Suspension (30 ml)',7.89,'Moronal Suspension (30 ml)','2008-07-01','9999-12-31',0,'570');
#
#
# PosNr M009
#
#WWWRUN	INSERT	Leistungsart	POSNR='M009' and GUELT_VON='2008-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'M009','M','Paracetamol (30 Stück)',2.0,'Paracetamol (30 Stück)','2008-07-01','9999-12-31',0,'580');
#
#
# PosNr M010
#
#WWWRUN	INSERT	Leistungsart	POSNR='M010' and GUELT_VON='2008-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'M010','M','Retterspitz äußerlich (350 ml)',7.77,'Retterspitz äußerlich (350 ml)','2008-07-01','9999-12-31',0,'600');
#
#
# PosNr M011
#
#WWWRUN	INSERT	Leistungsart	POSNR='M011' and GUELT_VON='2008-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'M011','M','Calendula Urtinktur (20 ml)',10.36,'Calendula Urtinktur (20 ml)','2008-07-01','9999-12-31',0,'610');
#
#
# PosNr M012
#
#WWWRUN	INSERT	Leistungsart	POSNR='M012' and GUELT_VON='2008-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'M012','M','Phytolacca D4 Globuli 10g',5.44,'Phytolacca D4 Globuli 10g','2008-07-01','9999-12-31',0,'610');
#
#
# PosNr M013
#
#WWWRUN	INSERT	Leistungsart	POSNR='M013' and GUELT_VON='2008-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'M013','M','Phytolacca C30 Globuli 10g',6.97,'Phytolacca C30 Globuli 10g','2008-07-01','9999-12-31',0,'610');
#
#
# PosNr M014
#
#WWWRUN	INSERT	Leistungsart	POSNR='M014' and GUELT_VON='2008-07-01' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'M014','M','Lanolin 10g',0.95,'Lanolin 10g','2008-07-01','9999-12-31',0,'530');
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