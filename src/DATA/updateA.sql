# ------------- Leistungen in der Schwangerschaft -------------
#
# Leistungen der Mutterschaftsvorsorge und Schwangerenbetreuung
# Leistungsgruppe A


# Gebührenordnung vor dem 01.07.2010 für bestimmte Positionsnummern ungültig machen
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2010-06-30' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR = '0800';


# Gebührenordnung vor dem 01.01.2013 für fast alle Positionsnummern ungültig machen
# Leistungsgruppe A
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-12-31' where GUELT_VON in ('2010-01-01','2010-07-01') and GUELT_BIS = '9999-12-31' and Leistungstyp='A';


# Verfallsdatum für einige Positionen (ohne Geburtshilfe) die seit dem 1.1.2013 galten 
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2014-06-30' where POSNR in ('0500', '0501', '0502', '0510', '0511', '0512', '0700') and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31';


# Verfallsdatum für Positionen (ohne Geburtshilfe) die zum 1.7.2015 erhöht wurden
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2015-06-30' where POSNR = '0700' and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31';
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2015-06-30' where POSNR = '0300' and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31';


# Vergütungsverzeichnis ab 25.9.2015 nach Schiedsspruch
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2015-09-24' where GUELT_VON < '2015-09-25' and GUELT_BIS = '9999-12-31' and Leistungstyp='A';



## Neue Gebührenordnung ab 01.01.2010
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


## -------- geänderte Posistionsnummern ab 01.07.2010 ---------------------
#
# Posnr 0800
WWWRUN	INSERT	Leistungsart	POSNR='0800' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,BEGRUENDUNGSPFLICHT) values (9999,'0800','A','Einzelgeburtsvorbereitung',7.50,'Geburtsvorbereitung bei Einzelunterweisung auf ärztliche Anordnung höchstens 28 Unterrichtseinheiten a 15 Minuten, für jede angefangenen 15 Minuten','2010-07-01','2012-12-31','15','','','','',0,'J');


## Neue Gebührenordnung ab 01.01.2013
#
# Leistungen der Mutterschaftsvorsorge und Schwangerenbetreuung
# Leistungsgruppe A
#
# PosNr 0100
#
WWWRUN	INSERT	Leistungsart	POSNR='0100' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0100','A','Beratung',6.53,'Beratung der Schwangeren, auch mittels Kommunikationsmedium','2013-01-01','2015-09-24');
#
#
# PosNr 0101
#
WWWRUN	INSERT	Leistungsart	POSNR='0101' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0101','A','Beratung Beleghebamme',6.53,'Beratung der Schwangeren, auch mittels Kommunikationsmedium durch Beleghebamme','2013-01-01','2015-09-24');
#
#
# PosNr 0102
#
WWWRUN	INSERT	Leistungsart	POSNR='0102' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0102','A','Beratung Beleghebamme 1:1',6.53,'Beratung der Schwangeren, auch mittels Kommunikationsmedium durch Beleghebamme bei 1:1 Betreuung','2013-01-01','2015-09-24');
#
#
#
#
# PosNr 0200
#
WWWRUN	INSERT	Leistungsart	POSNR='0200' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'0200','A','Vorgespräch',8.43,'Vorgespräch über Fragen der Schwangerschaft und Geburt,mindestens 30 Minuten, je angefangene 15 Minuten','2013-01-01','2015-09-24',15);
#
#
#
# PosNr 0300
#
WWWRUN	INSERT	Leistungsart	POSNR='0300' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0300','A','Vorsorgeuntersuchung',25.21,'Vorsorgeuntersuchung der Schwangeren nach Maßgabe der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung in der jeweils geltenden Fassung','2013-01-01','2015-06-30',0,'+3400');
#
#
# PosNr 0400
#
WWWRUN	INSERT	Leistungsart	POSNR='0400' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0400','A','Entnahme von Körpermaterial',6.42,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung','2013-01-01','2015-09-24',0,'');
#
#
# PosNr 0401
#
WWWRUN	INSERT	Leistungsart	POSNR='0401' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0401','A','Entnahme von Körpermaterial Belegheb.',6.42,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung durch Beleghebamme','2013-01-01','2015-09-24',0,'');
#
# PosNr 402
#
WWWRUN	INSERT	Leistungsart	POSNR='0402' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0402','A','Entnahme von Körpermaterial Belegheb. 1:1',6.42,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung durch Beleghebamme 1:1','2013-01-01','2015-09-24',0,'');
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
WWWRUN	INSERT	Leistungsart	POSNR='0600' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0600','A','CTG Überwachung',7.22,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung.','2013-01-01','2015-09-24',0,'','','','',0);
#
#
# PosNr 0601
#
WWWRUN	INSERT	Leistungsart	POSNR='0601' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0601','A','CTG Überwachung Belegheb.',7.22,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung. Beleghebamme','2013-01-01','2015-09-24',0,'','','','',0);
#
#
# PosNr 0602
#
WWWRUN	INSERT	Leistungsart	POSNR='0602' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0602','A','CTG Überwachung Belegheb. 1:1',7.22,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung. Beleghebamme 1:1','2013-01-01','2015-09-24',0,'','','','',0);
#
#
# Posnr 0700
#
WWWRUN	INSERT	Leistungsart	POSNR='0700' and GUELT_VON='2013-01-01' and GUELT_BIS='2014-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0700','A','Geburtsvorbereitung in der Gruppe',6.42,'Geburtsvorbereitung bei Unterweisung in der Gruppe, bis zu zehn Schwangere je Gruppe und höchsten 14 Stunden, für jede Schwangere je Unterrichtsstunden (60 Minuten)','2013-01-01','2014-06-30','E60','','','','',0);
#
#
# Posnr 0800
WWWRUN	INSERT	Leistungsart	POSNR='0800' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,BEGRUENDUNGSPFLICHT) values (9999,'0800','A','Einzelgeburtsvorbereitung',8.43,'Geburtsvorbereitung bei Einzelunterweisung auf ärztliche Anordnung höchstens 28 Unterrichtseinheiten a 15 Minuten, für jede angefangenen 15 Minuten','2013-01-01','2015-09-24','15','','','','',0,'J');
#


## Ausgleich der Haftpflichtkostensteigerung (ohne Geburtshilfe) ab 1.7.2014
# Für folgende Positionen erhöht sich die Vergütung auf unbestimmte Zeit:
# - Hilfe bei Beschwerden   (0500-0512)
# - Geburtsvorbereitung     (0700)
# - Wochenbettbetreuung     (1800/1810)
# - Rückbildungsgymnastik   (2700)
#
# PosNr 0500
#
WWWRUN	INSERT	Leistungsart	POSNR='0500' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0500','A','Hilfe bei Beschw.',16.89,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten','2014-07-01','2015-09-24',30,'+3500','0510','0510','0510',180);
#
#
# PosNr 0501
#
WWWRUN	INSERT	Leistungsart	POSNR='0501' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0501','A','Hilfe bei Beschw. Belegheb.',16.89,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten Beleghebamme','2014-07-01','2015-09-24',30,'+3500','0511','0511','0511',180);
#
# PosNr 0502
#
WWWRUN	INSERT	Leistungsart	POSNR='0502' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0502','A','Hilfe bei Beschw. Belegheb. 1:1',16.89,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten Beleghebamme 1:1','2014-07-01','2015-09-24',30,'+3500','0512','0512','0512',180);
#
#
# PosNr 0510
#
WWWRUN	INSERT	Leistungsart	POSNR='0510' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0510','A','Hilfe bei Beschw. Sa,So,Nacht',20.26,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1','2014-07-01','2015-09-24',30,'+3500','','','',180);
#
#
# PosNr 0511
#
WWWRUN	INSERT	Leistungsart	POSNR='0511' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0511','A','Hilfe bei Beschw. Sa,So,Nacht Belegheb.',20.26,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-07-01','2015-09-24',30,'+3500','','','',180);
#
# PosNr 0512
#
WWWRUN	INSERT	Leistungsart	POSNR='0512' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0512','A','Hilfe bei Beschw. Sa,So,Nacht Belegheb. 1:1',20.26,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2014-07-01','2015-09-24',30,'+3500','','','',180);
#
# Posnr 0700
#
WWWRUN	INSERT	Leistungsart	POSNR='0700' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0700','A','Geburtsvorbereitung in der Gruppe',6.47,'Geburtsvorbereitung bei Unterweisung in der Gruppe, bis zu zehn Schwangere je Gruppe und höchsten 14 Stunden, für jede Schwangere je Unterrichtsstunden (60 Minuten)','2014-07-01','2015-06-30','E60','','','','',0);
#


## Anhebung der Vergütung der Positionen 300, 700, 1800, 1810 sowie 2700 zum 1.7.2015
#
# PosNr 0300
#
WWWRUN	INSERT	Leistungsart	POSNR='0300' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0300','A','Vorsorgeuntersuchung',25.23,'Vorsorgeuntersuchung der Schwangeren nach Maßgabe der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung in der jeweils geltenden Fassung','2015-07-01','2015-09-24',0,'+3400');
#
# Posnr 0700
#
WWWRUN	INSERT	Leistungsart	POSNR='0700' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0700','A','Geburtsvorbereitung in der Gruppe',6.49,'Geburtsvorbereitung bei Unterweisung in der Gruppe, bis zu zehn Schwangere je Gruppe und höchsten 14 Stunden, für jede Schwangere je Unterrichtsstunden (60 Minuten)','2015-07-01','2015-09-24','E60','','','','',0);
#


## Vergütungsverzeichnis ab 25.9.2015 nach Schiedsspruch
#
# Alles neu:
#
# PosNr 0100
#
WWWRUN	INSERT	Leistungsart	POSNR='0100' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0100','A','Beratung',6.84,'Beratung der Schwangeren, auch mittels Kommunikationsmedium','2015-09-25','9999-12-31');
#
#
# PosNr 0101
#
WWWRUN	INSERT	Leistungsart	POSNR='0101' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0101','A','Beratung Beleghebamme',6.84,'Beratung der Schwangeren, auch mittels Kommunikationsmedium durch Beleghebamme','2015-09-25','9999-12-31');
#
#
# PosNr 0102
#
WWWRUN	INSERT	Leistungsart	POSNR='0102' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS) values (9999,'0102','A','Beratung Beleghebamme 1:1',6.84,'Beratung der Schwangeren, auch mittels Kommunikationsmedium durch Beleghebamme bei 1:1 Betreuung','2015-09-25','9999-12-31');
#
#
#
#
# PosNr 0200
#
WWWRUN	INSERT	Leistungsart	POSNR='0200' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'0200','A','Vorgespräch',8.83,'Vorgespräch über Fragen der Schwangerschaft und Geburt,mindestens 30 Minuten, je angefangene 15 Minuten','2015-09-25','9999-12-31',15);
#
#
#
# PosNr 0300
#
WWWRUN	INSERT	Leistungsart	POSNR='0300' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0300','A','Vorsorgeuntersuchung',26.43,'Vorsorgeuntersuchung der Schwangeren nach Maßgabe der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung in der jeweils geltenden Fassung','2015-09-25','9999-12-31',0,'+3400');
#
#
# PosNr 0400
#
WWWRUN	INSERT	Leistungsart	POSNR='0400' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0400','A','Entnahme von Körpermaterial',6.73,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung','2015-09-25','9999-12-31',0,'');
#
#
# PosNr 0401
#
WWWRUN	INSERT	Leistungsart	POSNR='0401' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0401','A','Entnahme von Körpermaterial Belegheb.',6.73,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung durch Beleghebamme','2015-09-25','9999-12-31',0,'');
#
# PosNr 402
#
WWWRUN	INSERT	Leistungsart	POSNR='0402' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1) values (9999,'0402','A','Entnahme von Körpermaterial Belegheb. 1:1',6.73,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand- und Portokosten, Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien und Befundübermittlung durch Beleghebamme 1:1','2015-09-25','9999-12-31',0,'');
#
#
# PosNr 0500
#
WWWRUN	INSERT	Leistungsart	POSNR='0500' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0500','A','Hilfe bei Beschw.',17.69,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten','2015-09-25','9999-12-31',30,'+3500','0510','0510','0510',180);
#
#
# PosNr 0501
#
WWWRUN	INSERT	Leistungsart	POSNR='0501' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0501','A','Hilfe bei Beschw. Belegheb.',17.69,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten Beleghebamme','2015-09-25','9999-12-31',30,'+3500','0511','0511','0511',180);
#
# PosNr 0502
#
WWWRUN	INSERT	Leistungsart	POSNR='0502' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0502','A','Hilfe bei Beschw. Belegheb. 1:1',17.69,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten Beleghebamme 1:1','2015-09-25','9999-12-31',30,'+3500','0512','0512','0512',180);
#
#
# PosNr 0510
#
WWWRUN	INSERT	Leistungsart	POSNR='0510' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0510','A','Hilfe bei Beschw. Sa,So,Nacht',21.22,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1','2015-09-25','9999-12-31',30,'+3500','','','',180);
#
#
# PosNr 0511
#
WWWRUN	INSERT	Leistungsart	POSNR='0511' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0511','A','Hilfe bei Beschw. Sa,So,Nacht Belegheb.',21.22,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2015-09-25','9999-12-31',30,'+3500','','','',180);
#
# PosNr 0512
#
WWWRUN	INSERT	Leistungsart	POSNR='0512' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0512','A','Hilfe bei Beschw. Sa,So,Nacht Belegheb. 1:1',21.22,'Hilfe bei Schwangerschaftsbeschwerden oder bei Wehen, für jede angefangenen 30 Minuten, mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2015-09-25','9999-12-31',30,'+3500','','','',180);
#
#
# PosNr 0600
#
WWWRUN	INSERT	Leistungsart	POSNR='0600' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0600','A','CTG Überwachung',7.56,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung.','2015-09-25','9999-12-31',0,'','','','',0);
#
#
# PosNr 0601
#
WWWRUN	INSERT	Leistungsart	POSNR='0601' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0601','A','CTG Überwachung Belegheb.',7.56,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung. Beleghebamme','2015-09-25','9999-12-31',0,'','','','',0);
#
#
# PosNr 0602
#
WWWRUN	INSERT	Leistungsart	POSNR='0602' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0602','A','CTG Überwachung Belegheb. 1:1',7.56,'Cardiotokografische Überwachnung bei Indikationen nach Maßgabe der Anlage 2 zu den Richtlinien des gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwangerschaft und nach der Entbindung (Mutterschafts-Richtlinien) in der jeweils geltenden Fassung einschl. Dokumentation im Mutterpass nach den Mutterschafts-Richtlinien in der jeweils geltenden Fassung. Beleghebamme 1:1','2015-09-25','9999-12-31',0,'','','','',0);
#
#
# Posnr 0700
#
WWWRUN	INSERT	Leistungsart	POSNR='0700' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0700','A','Geburtsvorbereitung in der Gruppe',6.80,'Geburtsvorbereitung bei Unterweisung in der Gruppe, bis zu zehn Schwangere je Gruppe und höchsten 14 Stunden, für jede Schwangere je Unterrichtsstunden (60 Minuten)','2015-09-25','9999-12-31','E60','','','','',0);
#
#
# Posnr 0800
WWWRUN	INSERT	Leistungsart	POSNR='0800' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,BEGRUENDUNGSPFLICHT) values (9999,'0800','A','Einzelgeburtsvorbereitung',8.83,'Geburtsvorbereitung bei Einzelunterweisung auf ärztliche Anordnung höchstens 28 Unterrichtseinheiten a 15 Minuten, für jede angefangenen 15 Minuten','2015-09-25','9999-12-31','15','','','','',0,'J');
#


