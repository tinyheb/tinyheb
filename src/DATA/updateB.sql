# -------------Geburtshilfe ---------------------
#
# Leistungen Geburtshilfe
# Leistungsgruppe B


# Gebührenordnung vor dem 01.07.2010 für bestimmte Positionsnummern ungültig machen
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2010-06-30' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('1100','1110','1200','1210');


# Gebührenordnung vor dem 01.07.2012 für bestimmte Positionsnummern ungültig machen

WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-06-30' where GUELT_VON = '2011-06-27' and GUELT_BIS = '9999-12-31' and POSNR in ('0900','0910','0920','0930','0940','0950');

WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-06-30' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('0901','0902','0911','0912','1000','1010');

WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-06-30' where GUELT_VON = '2010-07-01' and GUELT_BIS = '9999-12-31' and POSNR in ('1100','1110','1200','1210');

WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-06-30' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('1600','1601','1602','1610','1611','1612','1700','1701','1702','1710','1711','1712');


# Gebührenordnung vor dem 01.01.2013 für fast alle Positionsnummern ungültig machen
# Leistungsgruppe B
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-12-31' where GUELT_VON in ('2010-01-01','2012-07-01') and GUELT_BIS = '9999-12-31' and Leistungstyp='B';


# Verfallsdatum für einige Positionen (mit Geburtshilfe) die seit dem 01.01.2013 galten
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2013-12-31' where GUELT_VON = '2013-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('0901','0902','0911','0912','1000','1010','1100','1110','1200','1210','1600','1601','1602','1610','1611','1612','1700','1701','1702','1710','1711','1712');


# Neues Vergütungsverzeichnis ab 25.9.2015 nach Schiedsspruch
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2015-09-24' where GUELT_VON < DATE('2015-09-25') and GUELT_BIS = '9999-12-31' and Leistungstyp='B';




## Neue Gebührenordnung ab 01.01.2010
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


## -------- geänderte Posistionsnummern ab 01.07.2010 ---------------------
#
# PosNr 1100
#
WWWRUN	INSERT	Leistungsart	POSNR='1100' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1100','B','Geburt außerkl. Leitung Hebammen',467.2,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung','2010-07-01','2012-06-30',0,'+3600','1110','1110','1110',0);
#
# PosNr 1110
#
WWWRUN	INSERT	Leistungsart	POSNR='1110' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1110','B','Geburt außerkl. Leitung Hebammen Nacht,Sa,So',560.65,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung mit Zuschlag gemäß §5 Abs. 1','2010-07-01','2015-09-24',0,'+3600','','','',0);
#
# PosNr 1200
#
WWWRUN	INSERT	Leistungsart	POSNR='1200' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1200','B','Hilfe bei Hausgeburt',548.80,'Hilfe bei Hausgeburt','2010-07-01','2012-06-30',0,'+3600','1210','1210','1210',0);
#
# PosNr 1210
#
WWWRUN	INSERT	Leistungsart	POSNR='1210' and GUELT_VON='2010-07-01' and GUELT_BIS='2012-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1210','B','Hilfe bei Hausgeburt Nacht,Sa,So',658.56,'Hilfe bei Hausgeburt mit Zuschlag gemäß §5 Abs. 1','2010-07-01','2012-06-30',0,'+3600','','','',0);


## -------- Positionsnummern w/ Betriebskostenpauschale vom 27.06.2011 bis 30.06.2012
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


## -------- geänderte Positionsnummern ab 01.07.2012
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


## -------- neue Positionsnummern w/ Betriebskostenpauschale ab 01.07.2012
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


## Neue Gebührenordnung ab dem 1.1.2013
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
WWWRUN	INSERT	Leistungsart	POSNR='1300' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1300','B','Hilfe bei Fehlgeburt',179.76,'Hilfe bei einer Fehlgeburt','2013-01-01','2015-09-24',0,'+3600','1310','1310','1310',0);
#
# PosNr 1301
#
WWWRUN	INSERT	Leistungsart	POSNR='1301' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1301','B','Hilfe bei Fehlgeburt Belegheb.',179.76,'Hilfe bei einer Fehlgeburt Beleghebamme','2013-1-01','2015-09-24',0,'+3600','1311','1311','1311',0);
#
#
# PosNr 1302
#
WWWRUN	INSERT	Leistungsart	POSNR='1302' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1302','B','Hilfe bei Fehlgeburt Belegheb. 1:1',179.76,'Hilfe bei einer Fehlgeburt Beleghebamme 1:1','2013-01-01','2015-09-24',0,'+3600','1312','1312','1312',0);
#
#
# PosNr 1310
#
WWWRUN	INSERT	Leistungsart	POSNR='1310' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1310','B','Hilfe bei Fehlgeburt Nacht,Sa,So',215.71,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1','2013-01-01','2015-09-24',0,'+3600','','','',0);
#
# PosNr 1311
#
WWWRUN	INSERT	Leistungsart	POSNR='1311' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1311','B','Hilfe bei Fehlgeb. Nacht,Sa,So Belegheb.',215.71,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2013-01-01','2015-09-24',0,'+3600','','','',0);
#
# PosNr 1312
#
WWWRUN	INSERT	Leistungsart	POSNR='1312' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1312','B','Hilfe bei Fehlgeb. Nacht,Sa,So Belegheb. 1:1',215.71,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2013-01-01','2015-09-24',0,'+3600','','','',0);
#
#
# PosNr 1400
#
WWWRUN	INSERT	Leistungsart	POSNR='1400' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1400','B','Vers. Schnitt-/ Rissverletzung ohne DR III/IV',33.71,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV','2013-01-01','2015-09-24',0,'+3700','','','',0);
#
#
# PosNr 1401
#
WWWRUN	INSERT	Leistungsart	POSNR='1401' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1401','B','Vers. Schnitt-/ Rissv. ohne DR III/IV Belegheb.',33.71,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV durch Beleghebamme','2013-01-01','2015-09-24',0,'+3700','','','',0);
#
#
# PosNr 1402
#
WWWRUN	INSERT	Leistungsart	POSNR='1402' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1402','B','Vers. Schnitt-/ Rissv. ohne DR III/IV Belegheb. 1:1',33.71,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV durch Beleghebamme 1:1','2013-01-01','2015-09-24',0,'+3700','','','',0);
#
#
# PosNr 1500
#
WWWRUN	INSERT	Leistungsart	POSNR='1500' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1500','B','Zuschlag Zwillinge',78.65,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind','2013-01-01','2015-09-24','','','','','',0);
#
# PosNr 1501
#
WWWRUN	INSERT	Leistungsart	POSNR='1501' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1501','B','Zuschlag Zwillinge Belegheb.',78.65,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind Beleghebamme','2013-01-01','2015-09-24','','','','','',0);
#
# PosNr 1502
#
WWWRUN	INSERT	Leistungsart	POSNR='1502' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1502','B','Zuschlag Zwillinge Belegheb. 1:1',78.65,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind Beleghebamme 1:1','2013-01-01','2015-09-24','','','','','',0);
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

# -------- geänderte Positionsnummern w/ Betriebskostenpauschale ab 01.01.2013
#
# Posnr 9000
WWWRUN	INSERT	Leistungsart	POSNR='9000' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9000','B','Betriebskostenpausch. vollendete Geb. nach QM',707.00,'Betriebskostenpauschale für eine vollendete Geburt in einer von Hebammen geleiteten Einrichtung, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2013-01-01','2015-09-24','','','','','',0,'');
#
#
# Posnr 9100
#
WWWRUN	INSERT	Leistungsart	POSNR='9100' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9100','B','Betriebskostenpauschale vollendete Geb. vor QM',637.00,'Betriebskostenpauschale für eine vollendete Geburt in einer von Hebammen geleiteten Einrichtung bis zum Zeitpunkt der Einführung eines QM-Systems','2013-01-01','2015-09-24','','','','','',0,'');
#
#
# Posnr 9200
#
WWWRUN	INSERT	Leistungsart	POSNR='9200' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9200','B','Betriebskostenpauschale nicht-vollendete Geb. nach QM',675.00,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach weniger als 4 Stunden, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2013-01-01','2015-09-24','','','','','',0,'');
#
#
# Posnr 9300
#
WWWRUN	INSERT	Leistungsart	POSNR='9300' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9300','B','Betriebskostenpauschale nicht-vollendete Geb. vor QM',580.00,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach weniger als 4 Stunden bis zum Zeitpunkt der Einführung eines QM-Systems','2013-01-01','2015-09-24','','','','','',0,'');
#
#
# Posnr 9400
#
WWWRUN	INSERT	Leistungsart	POSNR='9400' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9400','B','Betriebskostenpauschale nicht-vollendete Geb. nach QM',707.00,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach mehr als 4 Stunden, sofern die Einrichtung eines QM-System gemäß §7 Abs. 2 und Anlage 1 begonnen oder die Einführung beschlossen hat','2013-01-01','2015-09-24','','','','','',0,'');
#
#
# Posnr 9500
#
WWWRUN	INSERT	Leistungsart	POSNR='9500' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'9500','B','Betriebskostenpauschale nicht-vollendete Geb. vor QM',637.00,'Betriebskostenpauschale für eine nicht-vollendete Geburt in einer von Hebammen geleiteten Einrichtung bei Verlegung aus der Einrichtung nach mehr als 4 Stunden bis zum Zeitpunkt der Einführung eines QM-Systems','2013-01-01','2015-09-24','','','','','',0,'');


## Anhebung der Gebühren für die Zeit vom 1.1.14 bis zum 30.06.14
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


## Anpassung mit Haftpflichtzulagen für Geburtshilfe ab 1.7.2014
#
# PosNr 0901
#
WWWRUN	INSERT	Leistungsart	POSNR='0901' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0901','B','Geburt im Krankenhaus Belegheb.',275.22,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme','2014-07-01','2015-09-24',0,'+0991','0911','0911','0911',0);
#
# PosNr 0902
#
WWWRUN	INSERT	Leistungsart	POSNR='0902' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0902','B','Geburt im Krankenhaus Belegheb. 1:1',288.72,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme 1:1','2014-07-01','2015-09-24',0,'+0992','0912','0912','0912',0);
#
# PosNr 0911
#
WWWRUN	INSERT	Leistungsart	POSNR='0911' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0911','B','Geburt im K-Haus, Nacht,Sa,So Belegheb.',328.67,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-07-01','2015-09-24',0,'+0991','','','',0);
#
# PosNr 0912
#
WWWRUN	INSERT	Leistungsart	POSNR='0912' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0912','B','Geburt im K-Haus, Nacht,Sa,So Belegheb. 1:1',342.17,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2014-07-01','2015-09-24',0,'+0992','','','',0);
#
# PosNr 1000
#
WWWRUN	INSERT	Leistungsart	POSNR='1000' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1000','B','Geburt außerkl. ärztl. Leitung',275.22,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung','2014-07-01','2015-09-24',0,'+3600','+1090','1010','1010','1010',0);
#
# PosNr 1010
#
WWWRUN	INSERT	Leistungsart	POSNR='1010' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1010','B','Geburt außerkl. ärztl. Leitung, Nacht,Sa,So',328.67,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2014-07-01','2015-09-24',0,'+3600','+1090','','','',0);
#
# PosNr 1100
#
WWWRUN	INSERT	Leistungsart	POSNR='1100' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1100','B','Geburt außerkl. Leitung Hebammen',559.00,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung','2014-07-01','2015-09-24',0,'+3600','+1190','1110','1110','1110',0);
#
# PosNr 1110
#
WWWRUN	INSERT	Leistungsart	POSNR='1110' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1110','B','Geburt außerkl. Leitung Hebammen Nacht,Sa,So',663.98,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung mit Zuschlag gemäß §5 Abs. 1','2014-07-01','2015-09-24',0,'+3600','+1190','','','',0);
#
# PosNr 1200
#
WWWRUN	INSERT	Leistungsart	POSNR='1200' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1200','B','Hilfe bei Hausgeburt',703.08,'Hilfe bei Hausgeburt','2014-07-01','2015-09-24',0,'+3600','+1290','1210','1210','1210',0);
#
# PosNr 1210
#
WWWRUN	INSERT	Leistungsart	POSNR='1210' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1210','B','Hilfe bei Hausgeburt Nacht,Sa,So',826.39,'Hilfe bei Hausgeburt mit Zuschlag gemäß §5 Abs. 1','2014-07-01','2015-09-24',0,'+3600','+1290','','','',0);
#
# PosNr 1600
#
WWWRUN	INSERT	Leistungsart	POSNR='1600' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1600','B','Hilfe bei nicht vollendeter Geburt',208.14,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung','2014-07-01','2015-09-24',0,'+3600','+1690','1610','1610','1610',0);
#
# PosNr 1601
#
WWWRUN	INSERT	Leistungsart	POSNR='1601' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1601','B','Hilfe bei nicht vollendeter Geb. Belegheb.',208.14,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2014-07-01','2015-09-24',0,'+1691','1611','1611','1611',0);
#
# PosNr 1602
#
WWWRUN	INSERT	Leistungsart	POSNR='1602' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1602','B','Hilfe bei nicht vollendeter Geb. Belegheb. 1:1',208.14,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2014-07-01','2015-09-24',0,'+1692','1612','1612','1612',0);
#
# PosNr 1610
#
WWWRUN	INSERT	Leistungsart	POSNR='1610' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1610','B','Hilfe bei nicht vollendeter Geburt Nacht,Sa,So',246.97,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2014-07-01','2015-09-24',0,'+3600','+1690','','','',0);
#
# PosNr 1611
#
WWWRUN	INSERT	Leistungsart	POSNR='1611' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1611','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb.',246.97,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-07-01','2015-09-24',0,'+1691','','','',0);
#
# PosNr 1612
#
WWWRUN	INSERT	Leistungsart	POSNR='1612' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1612','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb. 1:1',246.97,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2014-07-01','2015-09-24',0,'+1692','','','',0);
#
# PosNr. 1700
#
WWWRUN	INSERT	Leistungsart	POSNR='1700' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1700','B','2. Hebamme',29.14,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2014-07-01','2015-09-24','30','','+1790','1710','1710','1710',240);
#
# PosNr. 1701
#
WWWRUN	INSERT	Leistungsart	POSNR='1701' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1701','B','2. Hebamme Beleghebamme',29.14,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2014-07-01','2015-09-24','30','','+1791','1711','1711','1711',240);
#
# PosNr. 1702
#
WWWRUN	INSERT	Leistungsart	POSNR='1702' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1702','B','2. Hebamme Beleghebamme 1:1',29.14,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2014-07-01','2015-09-24','30','','+1792','1712','1712','1712',240);
#
# PosNr. 1710
#
WWWRUN	INSERT	Leistungsart	POSNR='1710' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1710','B','2. Hebamme Nacht,Sa,So',33.77,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1','2014-07-01','2015-09-24','30','','+1790','','','',240);
#
# PosNr. 1711
#
WWWRUN	INSERT	Leistungsart	POSNR='1711' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1711','B','2. Hebamme Nacht,Sa,So Belegheb.',33.77,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-07-01','2015-09-24','30','','+1791','','','',240);
#
# PosNr. 1712
#
WWWRUN	INSERT	Leistungsart	POSNR='1712' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,EINMALIG,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1712','B','2. Hebamme Nacht,Sa,So Belegheb. 1:1',33.77,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2014-07-01','2015-09-24','30','','+1792','','','',240);
#

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
## die bis zum 30.6.2015 befristeten Haftpflichtzulagen mit kleineren Werten unbefristet fortführen...
#
# PosNr 0991
#
WWWRUN	INSERT	Leistungsart	POSNR='0991' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'0991','B','Haftpflichtzulage Geburt im Krankenhaus Belegheb.',8.81,'Haftpflichtzulage für eine Geburt ab dem 01.07.2015 im Krankenhaus als Beleghebamme','2015-07-01','2015-09-24',0);
#
# PosNr 0992
#
WWWRUN	INSERT	Leistungsart	POSNR='0992' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'0992','B','Haftpflichtzulage Geburt im Krankenhaus Belegheb. 1:1',20.00,'Haftpflichtzulage für eine Geburt ab dem 01.07.2015 im Krankenhaus als Beleghebamme 1:1','2015-07-01','2015-09-24',0);
#
# PosNr 1090
#
WWWRUN	INSERT	Leistungsart	POSNR='1090' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1090','B','Haftpflichtzulage Geburt außerkl. ärztl. Leitung',10.00,'Haftpflichtzulage für eine außerklinische Geburt ab dem 01.07.2015 in einer Einrichtung unter ärztlicher Leitung','2015-07-01','2015-09-24',0);
#
# PosNr 1190
#
WWWRUN	INSERT	Leistungsart	POSNR='1190' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1190','B','Haftpflichtzulage Geburt außerkl. Leitung Hebammen',32.00,'Haftpflichtzulage für eine außerklinische Geburt ab dem 01.07.2015 in einer von Hebammen geleiteten Einrichtung','2015-07-01','2015-09-24',0);
#
# PosNr 1290
#
WWWRUN	INSERT	Leistungsart	POSNR='1290' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1290','B','Haftpflichtzulage Hausgeburt',100.00,'Haftpflichtzulage für eine Hausgeburt ab dem 01.07.2015','2015-07-01','2015-09-24',0);
#
# PosNr 1690
#
WWWRUN	INSERT	Leistungsart	POSNR='1690' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1690','B','Haftpflichtzulage unvollendete Geburt',10.00,'Haftpflichtzulage für Hilfe bei einer nicht vollendeten Geburt ab dem 01.07.2015 als ambulante Leistung','2015-07-01','2015-09-24',0);
#
# PosNr 1691
#
WWWRUN	INSERT	Leistungsart	POSNR='1691' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1691','B','Haftpflichtzulage unvollendete Geburt Beleghebamme',10.00,'Haftpflichtzulage für Hilfe bei einer nicht vollendeten Geburt ab dem 01.07.2015 als Beleghebamme','2015-07-01','2015-09-24',0);
#
# PosNr 1692
#
WWWRUN	INSERT	Leistungsart	POSNR='1692' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1692','B','Haftpflichtzulage unvollendete Geburt Beleghebamme 1:1',10.00,'Haftpflichtzulage für Hilfe bei einer nicht vollendeten Geburt ab dem 01.07.2015 als Beleghebamme in einer 1:1 Betreuung','2015-07-01','2015-09-24',0);
#
# PosNr 1790
#
WWWRUN	INSERT	Leistungsart	POSNR='1790' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1790','B','Haftpflichtzulage 2. Hebamme',3.00,'Haftpflichtzulage für Hilfe bei einer außerklinischen Geburt oder Fehlgeburt ab dem 01.07.2015 durch eine zweite Hebamme, für jede angefangene halbe Stunde als ambulante Leistung','2015-07-01','2015-09-24',0);
#
# PosNr 1791
#
WWWRUN	INSERT	Leistungsart	POSNR='1791' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1791','B','Haftpflichtzulage 2. Hebamme Beleghebamme',3.00,'Haftpflichtzulage für Hilfe bei einer klinischen Geburt oder Fehlgeburt ab dem 01.07.2015 durch eine zweite Hebamme, für jede angefangene halbe Stunde als Beleghebamme','2015-07-01','2015-09-24',0);
#
# PosNr 1792
#
WWWRUN	INSERT	Leistungsart	POSNR='1792' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'1792','B','Haftpflichtzulage 2. Hebamme Belegheb. 1:1',3.00,'Haftpflichtzulage für Hilfe bei einer klinischen Geburt oder Fehlgeburt ab dem 01.07.2015 durch eine zweite Hebamme, für jede angefangene halbe Stunde als Beleghebamme in einer 1:1 Betreuung','2015-07-01','2015-09-24',0);
#


## Vergütungsverzeichnis ab 25.9.2015 nach Schiedsspruch
#
# PosNr 0901
#
WWWRUN	INSERT	Leistungsart	POSNR='0901' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0901','B','Geburt im Krankenhaus Belegheb.',271.94,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme','2015-09-25','9999-12-31',0,'','0911','0911','0911',0);
#
# PosNr 0902
#
WWWRUN	INSERT	Leistungsart	POSNR='0902' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0902','B','Geburt im Krankenhaus Belegheb. 1:1',271.94,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus Beleghebamme 1:1','2015-09-25','9999-12-31',0,'','0912','0912','0912',0);
#
#
#
# PosNr 0911
#
WWWRUN	INSERT	Leistungsart	POSNR='0911' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0911','B','Geburt im K-Haus, Nacht,Sa,So Belegheb.',327.94,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2015-09-25','9999-12-31',0,'','','','',0);
#
#
# PosNr 0912
#
WWWRUN	INSERT	Leistungsart	POSNR='0912' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'0912','B','Geburt im K-Haus, Nacht,Sa,So Belegheb. 1:1',327.94,'Hilfe bei der Geburt eines Kindes in einem Krankenhaus mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2015-09-25','9999-12-31',0,'','','','',0);
#
#
# PosNr 1000
#
WWWRUN	INSERT	Leistungsart	POSNR='1000' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1000','B','Geburt außerkl. ärztl. Leitung',279.94,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung','2015-09-25','9999-12-31',0,'+3600','1010','1010','1010',0);
#
# PosNr 1010
#
WWWRUN	INSERT	Leistungsart	POSNR='1010' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1010','B','Geburt außerkl. ärztl. Leitung, Nacht,Sa,So',335.94,'Hilfe bei einer außerklinischen Geburt in einer Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2015-09-25','9999-12-31',0,'+3600','','','',0);
#
# PosNr 1100
#
WWWRUN	INSERT	Leistungsart	POSNR='1100' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1100','B','Geburt außerkl. Leitung Hebammen',449.90,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung','2015-09-25','9999-12-31',0,'+3600','1110','1110','1110',0);
#
# PosNr 1110
#
WWWRUN	INSERT	Leistungsart	POSNR='1110' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1110','B','Geburt außerkl. Leitung Hebammen Nacht,Sa,So',559.87,'Hilfe bei einer außerklinischen Geburt in einer von Hebammen geleiteten Einrichtung mit Zuschlag gemäß §5 Abs. 1','2015-09-25','9999-12-31',0,'+3600','','','',0);
#
# PosNr 1200
#
WWWRUN	INSERT	Leistungsart	POSNR='1200' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1200','B','Hilfe bei Hausgeburt',545.94,'Hilfe bei Hausgeburt','2015-09-25','9999-12-31',0,'+3600','1210','1210','1210',0);
#
# PosNr 1210
#
WWWRUN	INSERT	Leistungsart	POSNR='1210' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1210','B','Hilfe bei Hausgeburt Nacht,Sa,So',675.12,'Hilfe bei Hausgeburt mit Zuschlag gemäß §5 Abs. 1','2015-09-25','9999-12-31',0,'+3600','','','',0);
#
# PosNr 1300
#
WWWRUN	INSERT	Leistungsart	POSNR='1300' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1300','B','Hilfe bei Fehlgeburt',188.32,'Hilfe bei einer Fehlgeburt','2015-09-25','9999-12-31',0,'+3600','1310','1310','1310',0);
#
# PosNr 1301
#
WWWRUN	INSERT	Leistungsart	POSNR='1301' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1301','B','Hilfe bei Fehlgeburt Belegheb.',188.32,'Hilfe bei einer Fehlgeburt Beleghebamme','2013-1-01','9999-12-31',0,'+3600','1311','1311','1311',0);
#
#
# PosNr 1302
#
WWWRUN	INSERT	Leistungsart	POSNR='1302' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1302','B','Hilfe bei Fehlgeburt Belegheb. 1:1',188.32,'Hilfe bei einer Fehlgeburt Beleghebamme 1:1','2015-09-25','9999-12-31',0,'+3600','1312','1312','1312',0);
#
#
# PosNr 1310
#
WWWRUN	INSERT	Leistungsart	POSNR='1310' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1310','B','Hilfe bei Fehlgeburt Nacht,Sa,So',225.98,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1','2015-09-25','9999-12-31',0,'+3600','','','',0);
#
# PosNr 1311
#
WWWRUN	INSERT	Leistungsart	POSNR='1311' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1311','B','Hilfe bei Fehlgeb. Nacht,Sa,So Belegheb.',225.98,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2015-09-25','9999-12-31',0,'+3600','','','',0);
#
# PosNr 1312
#
WWWRUN	INSERT	Leistungsart	POSNR='1312' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1312','B','Hilfe bei Fehlgeb. Nacht,Sa,So Belegheb. 1:1',225.98,'Hilfe bei einer Fehlgeburt mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2015-09-25','9999-12-31',0,'+3600','','','',0);
#
#
# PosNr 1400
#
WWWRUN	INSERT	Leistungsart	POSNR='1400' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1400','B','Vers. Schnitt-/ Rissverletzung ohne DR III/IV',35.32,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV','2015-09-25','9999-12-31',0,'+3700','','','',0);
#
#
# PosNr 1401
#
WWWRUN	INSERT	Leistungsart	POSNR='1401' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1401','B','Vers. Schnitt-/ Rissv. ohne DR III/IV Belegheb.',35.32,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV durch Beleghebamme','2015-09-25','9999-12-31',0,'+3700','','','',0);
#
#
# PosNr 1402
#
WWWRUN	INSERT	Leistungsart	POSNR='1402' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1402','B','Vers. Schnitt-/ Rissv. ohne DR III/IV Belegheb. 1:1',35.32,'Versorgung einer geburtshilflichen Schnitt- oder Rissverletzung mit Ausnahme DR III oder IV durch Beleghebamme 1:1','2015-09-25','9999-12-31',0,'+3700','','','',0);
#
#
# PosNr 1500
#
WWWRUN	INSERT	Leistungsart	POSNR='1500' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1500','B','Zuschlag Zwillinge',82.40,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind','2015-09-25','9999-12-31','','','','','',0);
#
# PosNr 1501
#
WWWRUN	INSERT	Leistungsart	POSNR='1501' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1501','B','Zuschlag Zwillinge Belegheb.',82.40,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind Beleghebamme','2015-09-25','9999-12-31','','','','','',0);
#
# PosNr 1502
#
WWWRUN	INSERT	Leistungsart	POSNR='1502' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1502','B','Zuschlag Zwillinge Belegheb. 1:1',82.40,'Zuschlag für die Hilfe bei der Geburt von Zwillingen und mehr Kindern, für das zweite und jedes weitere Kind, je Kind Beleghebamme 1:1','2015-09-25','9999-12-31','','','','','',0);
#
#
# PosNr 1600
#
WWWRUN	INSERT	Leistungsart	POSNR='1600' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1600','B','Hilfe bei nicht vollendeter Geburt',203.38,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung','2015-09-25','9999-12-31',0,'','1610','1610','1610',0);
#
# PosNr 1601
#
WWWRUN	INSERT	Leistungsart	POSNR='1601' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1601','B','Hilfe bei nicht vollendeter Geb. Belegheb.',203.38,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2015-09-25','9999-12-31',0,'','1611','1611','1611',0);
#
# PosNr 1602
#
WWWRUN	INSERT	Leistungsart	POSNR='1602' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1602','B','Hilfe bei nicht vollendeter Geb. Belegheb. 1:1',203.38,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2015-09-25','9999-12-31',0,'','1612','1612','1612',0);
#
#
# PosNr 1610
#
WWWRUN	INSERT	Leistungsart	POSNR='1610' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1610','B','Hilfe bei nicht vollendeter Geburt Nacht,Sa,So',244.06,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1','2015-09-25','9999-12-31',0,'','','','',0);
#
# PosNr 1611
#
WWWRUN	INSERT	Leistungsart	POSNR='1611' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1611','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb.',244.06,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2015-09-25','9999-12-31',0,'','','','',0);
#
# PosNr 1612
#
WWWRUN	INSERT	Leistungsart	POSNR='1612' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1612','B','Hilfe bei nicht vollendeter Geb. Nacht,Sa,So Belegheb. 1:1',244.06,'Hilfe bei einer nicht vollendeten Geburt a) im Krankenhaus, b) zu Hause, c) in einer außerklinischen Einrichtung unter Leitung einer Hebammen d) in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2015-09-25','9999-12-31',0,'','','','',0);
#
#
# PosNr. 1700
#
WWWRUN	INSERT	Leistungsart	POSNR='1700' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1700','B','2. Hebamme',24.24,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2015-09-25','9999-12-31','30','+3600','1710','1710','1710',240);
#
# PosNr. 1701
#
WWWRUN	INSERT	Leistungsart	POSNR='1701' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1701','B','2. Hebamme Beleghebamme',24.24,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2015-09-25','9999-12-31','30','+3600','1711','1711','1711',240);
#
# PosNr. 1702
#
WWWRUN	INSERT	Leistungsart	POSNR='1702' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1702','B','2. Hebamme Beleghebamme 1:1',24.24,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde','2015-09-25','9999-12-31','30','+3600','1712','1712','1712',240);
#
#
# PosNr. 1710
#
WWWRUN	INSERT	Leistungsart	POSNR='1710' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1710','B','2. Hebamme Nacht,Sa,So',29.09,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1','2015-09-25','9999-12-31','30','+3600','','','',240);
#
# PosNr. 1711
#
WWWRUN	INSERT	Leistungsart	POSNR='1711' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1711','B','2. Hebamme Nacht,Sa,So Belegheb.',29.09,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2015-09-25','9999-12-31','30','+3600','','','',240);
#
# PosNr. 1712
#
WWWRUN	INSERT	Leistungsart	POSNR='1712' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER) values (9999,'1712','B','2. Hebamme Nacht,Sa,So Belegheb. 1:1',29.09,'Hilfe bei einer außerklinischen Geburt oder Fehlgeburt durch eine zweite Hebamme, für jede angefangene halbe Stunde mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2015-09-25','9999-12-31','30','+3600','','','',240);
#

# TODO: 1799 ??

