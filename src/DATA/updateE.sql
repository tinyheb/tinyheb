#
# ------------ Wegegeld und Auslagenersatz -------------------------
#
# In GO Leistungsgruppe E in tinyHeb Leistungsgruppen W und M
#

# Gebührenordnung für Materialpauschalen vom 01.01.2010 für bestimmte Posnr ungültig machen
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-07-31' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('3400','3500','3600','3700','3800','3900');


# Gebührenordnung vor dem 01.01.2013 für fast alle Positionsnummern ungültig machen
# Leistungsgruppe W
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-12-31' where GUELT_VON in ('2010-01-01') and GUELT_BIS = '9999-12-31' and Leistungstyp='W';
# Leistungsgruppe M
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-12-31' where GUELT_VON in ('2010-01-01') and GUELT_BIS = '9999-12-31' and POSNR in ('4000') and Leistungstyp='M';


# Neues Vergütungsverzeichnis ab 25.9.2015 nach Schiedsspruch
# Leistungsgruppe W
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2015-09-24' where GUELT_VON < DATE('2015-09-25') and GUELT_BIS = '9999-12-31' and Leistungstyp='W';
# Leistungsgruppe M
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2015-09-24' where GUELT_VON < DATE('2015-09-25') and GUELT_BIS = '9999-12-31' and POSNR='4000';
# bugfix Leistungsgruppe M unchanged
WWWRUN	UPDATE	Leistungsart		delete from Leistungsart where GUELT_BIS='2015-09-24' and POSNR in ('3400','3500','3600','3700','3800','3810','3900','3910','3920');



## Neue Gebührenordnung ab 01.01.2010
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


## ----- geändert ab 01.08.2012
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


## Neue Gebührenordnung ab dem 1.1.2013
# In GO Leistungsgruppe E in tinyHeb Leistungsgruppen W und M
#
# PosNr 3000 Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3000' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3000','W','Wegegeld nicht mehr als 2 KM bei Tag',1.89,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2013-01-01','2015-09-24',0);
#
# PosNr 3010 anteiliges Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3010' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3010','W','ant. Wegegeld nicht mehr als 2 KM bei Tag',1.89,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2013-01-01','2015-09-24',0);
#
# PosNr 3100 Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3100' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3100','W','Wegegeld nicht mehr als 2 KM bei Nacht',2.67,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2013-01-01','2015-09-24',0);
#
# PosNr 3110 anteiliges Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3110' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3110','W','ant. Wegegeld nicht mehr als 2 KM bei Nacht',2.67,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2013-01-01','2015-09-24',0);
#
# PosNr 3200 Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3200' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3200','W','Wegegeld von mehr als 2 KM bei Tag',0.66,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2013-01-01','2015-09-24',0);
#
# PosNr 3210 anteiliges Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3210' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3210','W','ant. Wegegeld von mehr als 2 KM bei Tag',0.66,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2013-01-01','2015-09-24',0);
#
# PosNr 3300 Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3300' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3300','W','Wegegeld von mehr als 2 KM bei Nacht',0.91,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2013-01-01','2015-09-24',0);
#
#
# PosNr 3310 anteiliges Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3310' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3310','W','ant. Wegegeld von mehr als 2 KM bei Nacht',0.91,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2013-01-01','2015-09-24',0);
#

# Auslagenersatz: Material (Leistungsgruppe M in tinyheb)
#
# PosNr. 4000
#
WWWRUN	INSERT	Leistungsart	POSNR='4000' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'4000','M','Perinatalerhebung',8.43,'Perinatalerhebung bei einer außerklinischen Geburt nach vorgeschriebenem Formblatt einschließlich Versand- und Portokosten','2013-01-01','2015-09-24',0);
#
#


## Neues Vergütungsverzeichnis ab 25.9.2015 nach Schiedsspruch
#
# PosNr 3000 Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3000' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3000','W','Wegegeld nicht mehr als 2 KM bei Tag (Ambulant)',1.98,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2015-09-25','9999-12-31',0);
#
# PosNr 3001 Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3001' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3001','W','Wegegeld nicht mehr als 2 KM bei Tag (beleg)',1.98,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2015-09-25','9999-12-31',0);
#
# PosNr 3002 Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3002' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3002','W','Wegegeld nicht mehr als 2 KM bei Tag (beleg 1:1)',1.98,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2015-09-25','9999-12-31',0);
###
#
# PosNr 3010 anteiliges Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3010' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3010','W','ant. Wegegeld nicht mehr als 2 KM bei Tag (ambulant)',1.98,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2015-09-25','9999-12-31',0);
#
# PosNr 3011 anteiliges Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3011' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3011','W','ant. Wegegeld nicht mehr als 2 KM bei Tag (beleg)',1.98,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2015-09-25','9999-12-31',0);
#
# PosNr 3012 anteiliges Wegegeld nicht mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3012' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3012','W','ant. Wegegeld nicht mehr als 2 KM bei Tag (beleg 1:1)',1.98,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung','2015-09-25','9999-12-31',0);
#
# PosNr 3100 Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3100' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3100','W','Wegegeld nicht mehr als 2 KM bei Nacht (ambulant)',2.80,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2015-09-25','9999-12-31',0);
#
# PosNr 3101 Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3101' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3101','W','Wegegeld nicht mehr als 2 KM bei Nacht (beleg)',2.80,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2015-09-25','9999-12-31',0);
#
# PosNr 3102 Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3102' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3102','W','Wegegeld nicht mehr als 2 KM bei Nacht (beleg 1:1)',2.80,'Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2015-09-25','9999-12-31',0);
#
# PosNr 3110 anteiliges Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3110' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3110','W','ant. Wegegeld nicht mehr als 2 KM bei Nacht (ambulant)',2.80,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2015-09-25','9999-12-31',0);
#
# PosNr 3111 anteiliges Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3111' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3111','W','ant. Wegegeld nicht mehr als 2 KM bei Nacht (beleg)',2.80,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2015-09-25','9999-12-31',0);
#
# PosNr 3112 anteiliges Wegegeld nicht mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3112' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3112','W','ant. Wegegeld nicht mehr als 2 KM bei Nacht (beleg 1:1)',2.80,'anteiliges Wegegeld bei einer Entfernung von nicht mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00','2015-09-25','9999-12-31',0);
#
# PosNr 3200 Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3200' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3200','W','Wegegeld von mehr als 2 KM bei Tag (ambulant)',0.69,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2015-09-25','9999-12-31',0);
#
# PosNr 3201 Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3201' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3201','W','Wegegeld von mehr als 2 KM bei Tag (beleg)',0.69,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2015-09-25','9999-12-31',0);
#
# PosNr 3202 Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3202' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3202','W','Wegegeld von mehr als 2 KM bei Tag (beleg 1:1)',0.69,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2015-09-25','9999-12-31',0);
#
# PosNr 3210 anteiliges Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3210' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3210','W','ant. Wegegeld von mehr als 2 KM bei Tag (ambulant)',0.69,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2015-09-25','9999-12-31',0);
#
# PosNr 3211 anteiliges Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3211' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3211','W','ant. Wegegeld von mehr als 2 KM bei Tag (beleg)',0.69,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2015-09-25','9999-12-31',0);
#
# PosNr 3212 anteiliges Wegegeld mehr als 2 KM Tag
#
WWWRUN	INSERT	Leistungsart	POSNR='3212' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3212','W','ant. Wegegeld von mehr als 2 KM bei Tag (beleg 1:1)',0.69,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung, für jeden zurückgelegten Kilometer','2015-09-25','9999-12-31',0);
#
# PosNr 3300 Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3300' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3300','W','Wegegeld von mehr als 2 KM bei Nacht (ambulant)',0.95,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2015-09-25','9999-12-31',0);
##
# PosNr 3301 Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3301' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3301','W','Wegegeld von mehr als 2 KM bei Nacht (beleg)',0.95,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2015-09-25','9999-12-31',0);
##
# PosNr 3302 Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3302' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3302','W','Wegegeld von mehr als 2 KM bei Nacht (beleg 1:1)',0.95,'Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2015-09-25','9999-12-31',0);
#
# PosNr 3310 anteiliges Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3310' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3310','W','ant. Wegegeld von mehr als 2 KM bei Nacht (ambulant)',0.95,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2015-09-25','9999-12-31',0);
#
# PosNr 3311 anteiliges Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3311' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3311','W','ant. Wegegeld von mehr als 2 KM bei Nacht (belegt)',0.95,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2015-09-25','9999-12-31',0);
#
# PosNr 3312 anteiliges Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3312' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3312','W','ant. Wegegeld von mehr als 2 KM bei Nacht (belegt 1:1)',0.95,'anteiliges Wegegeld bei einer Entfernung von mehr als zwei Kilometern zwischen der Wohnung oder Praxis der Hebamme und der Stelle der Leistung in der Zeit von 20:00 bis 8:00, für jeden zurückgelegten Kilometer','2015-09-25','9999-12-31',0);
#
# PosNr 3350 anteiliges Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3350' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3350','W','Pauschale für Nutzung des ÖPNV (ambulant)',2.47,'Pauschale für die Benutzung öffentlicher Verkehrsmittel','2015-09-25','9999-12-31',0);
#
# PosNr 3351 anteiliges Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3351' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3351','W','Pauschale für Nutzung des ÖPNV (beleg)',2.47,'Pauschale für die Benutzung öffentlicher Verkehrsmittel','2015-09-25','9999-12-31',0);
#
# PosNr 3352 anteiliges Wegegeld mehr als 2 KM Nacht
#
WWWRUN	INSERT	Leistungsart	POSNR='3352' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'3352','W','Pauschale für Nutzung des ÖPNV (beleg 1:1)',2.47,'Pauschale für die Benutzung öffentlicher Verkehrsmittel','2015-09-25','9999-12-31',0);
#

# Auslagenersatz: Material (Leistungsgruppe M in tinyheb)
#
# PosNr. 4000
#
WWWRUN	INSERT	Leistungsart	POSNR='4000' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT) values (9999,'4000','M','Perinatalerhebung',8.83,'Perinatalerhebung bei einer außerklinischen Geburt nach vorgeschriebenem Formblatt einschließlich Versand- und Portokosten','2015-09-25','9999-12-31',0);
#
#

