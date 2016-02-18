# ------------- Wochenbett ----------------------
#
# Leistungen während des Wochenbetts
# Leistungsgruppe C
#

# Gebührenordnung vor dem 01.07.2010 für bestimmte Positionsnummern ungültig machen
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2010-06-30' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('1800','1801','1802','1810','1811','1812','2100','2110','2200','2201','2202');


# Gebührenordnung vor dem 01.07.2012 für bestimmte Positionsnummern ungültig machen
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-06-30' where GUELT_VON = '2010-07-01' and GUELT_BIS = '9999-12-31' and POSNR in ('1800','1801','1802','1810','1811','1812','2100','2110');
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-06-30' where GUELT_VON = '2010-01-01' and GUELT_BIS = '9999-12-31' and POSNR in ('2001','2002','2011','2012');


# Gebührenordnung vor dem 01.01.2013 für fast alle Positionsnummern ungültig machen
# Leistungsgruppe C
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2012-12-31' where GUELT_VON in ('2010-01-01','2010-07-01','2012-07-01') and GUELT_BIS = '9999-12-31' and Leistungstyp='C';


# Verfallsdatum für einige Positionen (ohne Geburtshilfe) die seit dem 1.1.2013 galten 
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2014-06-30' where POSNR in ('1800', '1810') and GUELT_VON='2013-01-01' and GUELT_BIS='9999-12-31';


## Verfallsdatum für Positionen (ohne Geburtshilfe) die zum 1.7.2015 erhöht wurden
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2015-06-30' where POSNR in ('1800', '1810') and GUELT_VON='2014-07-01' and GUELT_BIS='9999-12-31';


# Neues Vergütungsverzeichnis ab 25.9.2015 nach Schiedsspruch
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2015-09-24' where GUELT_VON < DATE('2015-09-25') and GUELT_BIS = '9999-12-31' and Leistungstyp='C';


## Neue Gebührenordnung ab 01.01.2010
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


## -------- geänderte Posistionsnummern ab 01.07.2010 ---------------------
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


## -------- geänderte Positionsnummern ab 01.07.2012
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


## Neue Gebührenordnung ab dem 1.1.2013
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
WWWRUN	INSERT	Leistungsart	POSNR='1900' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,ZUSATZGEBUEHREN2,ZUSATZGEBUEHREN3,ZUSATZGEBUEHREN4,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1900','C','Zuschlag 1. Wochenbettbetreuung nach der Geburt',6.42,'Zuschlag zu der Gebühr nach Nr. 1800 für die erste aufsuchende Wochenbettbetreuung nach der Geburt','2013-01-01','2015-09-24','','+3800','<5GK','+3900','>4GK','','','',0,'');
#
#
# PosNr 2001
#
WWWRUN	INSERT	Leistungsart	POSNR='2001' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2001','C','Wochenbettbetreuung in K-Haus Belegheb.',15.29,'aufsuchende Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2013-01-01','2015-09-24',0,'','2011','2011','2011',0,'');
#
# PosNr 2002
#
WWWRUN	INSERT	Leistungsart	POSNR='2002' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2002','C','Wochenbettbetreuung in K-Haus Belegheb. 1:1',15.29,'aufsuchende Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme 1:1','2013-01-01','2015-09-24',0,'','2012','2012','2012',0,'');
#
#
# PosNr 2011
#
WWWRUN	INSERT	Leistungsart	POSNR='2011' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2011','C','Wochenbettbetr. in K-Haus Nacht,Sa,So Belegheb.',18.33,'Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2013-01-01','2015-09-24',0,'','','','',0,'');
#
# PosNr 2012
#
WWWRUN	INSERT	Leistungsart	POSNR='2012' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2012','C','Wochenbettbetr. in K-Haus Nacht,Sa,So Belegheb. 1:1',18.33,'Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2013-01-01','2015-09-24',0,'','','','',0,'');
#
#
# PosNr. 2100
#
WWWRUN	INSERT	Leistungsart	POSNR='2100' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2100','C','Wochenbettbetreuung in Einr. Leitung Heb.',25.50,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt','2013-01-01','2015-09-24',0,'','2110','2110','2110',0,'');
#
#
# PosNr. 2110
#
WWWRUN	INSERT	Leistungsart	POSNR='2110' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2110','C','Wochenbettbetr. in Einr. Leitung Heb. Nacht,Sa,So',30.58,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2013-01-01','2015-09-24',0,'','','','',0,'');
#
#
# PosNr 2200
#
WWWRUN	INSERT	Leistungsart	POSNR='2200' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2200','C','Zuschlag Zwillinge',10.45,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind','2013-01-01','2015-09-24','','','','','',0,'');
#
# PosNr 2201
#
WWWRUN	INSERT	Leistungsart	POSNR='2201' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2201','C','Zuschlag Zwillinge Beleghebamme',10.45,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind Beleghebamme','2013-01-01','2015-09-24','','','','','',0,'');
#
# PosNr 2202
#
WWWRUN	INSERT	Leistungsart	POSNR='2202' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2202','C','Zuschlag Zwillinge Beleghebamme 1:1',10.45,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind Beleghebamme 1:1','2013-01-01','2015-09-24','','','','','',0,'');
#
#
# PosNr 2300
#
WWWRUN	INSERT	Leistungsart	POSNR='2300' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2300','C','Beratung mittels Kommunikationsmedium',5.73,'Beratung der Wöchnerin mittels Kommunikationsmedium','2013-01-01','2015-09-24','','','','','',0,'');
#
# PosNr 2301
#
WWWRUN	INSERT	Leistungsart	POSNR='2301' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2301','C','Beratung mittels Kommunikationsmedium Belegheb.',5.73,'Beratung der Wöchnerin mittels Kommunikationsmedium durch Beleghebamme','2013-01-01','2015-09-24','','','','','',0,'');
#
# PosNr 2302
#
WWWRUN	INSERT	Leistungsart	POSNR='2302' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2302','C','Beratung mittels Kommunikationsmed. Belegheb. 1:1',5.73,'Beratung der Wöchnerin mittels Kommunikationsmedium durch Beleghebamme 1:1','2013-01-01','2015-09-24','','','','','',0,'');
#
#
# PosNr. 2400
#
WWWRUN	INSERT	Leistungsart	POSNR='2400' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2400','C','Erstuntersuchung (U1)',8.59,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung.','2013-01-01','2015-09-24','','','','','',0,'');
#
# PosNr. 2401
#
WWWRUN	INSERT	Leistungsart	POSNR='2401' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2401','C','Erstuntersuchung (U1) Beleghebamme',8.59,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung Beleghebamme.','2013-01-01','2015-09-24','','','','','',0,'');
#
# PosNr. 2402
#
WWWRUN	INSERT	Leistungsart	POSNR='2402' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2402','C','Erstuntersuchung (U1) Beleghebamme 1:1',8.59,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung Beleghebamme 1:1.','2013-01-01','2015-09-24','','','','','',0,'');
#
#
# PosNr. 2500
#
WWWRUN	INSERT	Leistungsart	POSNR='2500' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2500','C','Entnahme von Körpermaterial',6.42,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung','2013-01-01','2015-09-24','','','','','',0,'');
#
# PosNr. 2501
#
WWWRUN	INSERT	Leistungsart	POSNR='2501' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2501','C','Entnahme von Körpermaterial Belegheb.',6.42,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung Beleghebamme','2013-01-01','2015-09-24','','','','','',0,'');
#
# PosNr. 2502
#
WWWRUN	INSERT	Leistungsart	POSNR='2502' and GUELT_VON='2013-01-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2502','C','Entnahme von Körpermaterial Belegheb. 1:1',6.42,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung Beleghebamme','2013-01-01','2015-09-24','','','','','',0,'');


## Ausgleich der Haftpflichtkostensteigerung (ohne Geburtshilfe) ab 1.7.2014
# Für folgende Positionen erhöht sich die Vergütung auf unbestimmte Zeit:
# - Hilfe bei Beschwerden   (0500-0512)
# - Geburtsvorbereitung     (0700)
# - Wochenbettbetreuung     (1800/1810)
# - Rückbildungsgymnastik   (2700)
#
# Positionsnummern mit neuem Betrag und neuer Gültigkeit einfügen

# PosNr. 1800
#
WWWRUN	INSERT	Leistungsart	POSNR='1800' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1800','C','Wochenbettbetreuung',31.35,'aufsuchende Wochenbettbetreuung nach der Geburt','2014-07-01','2015-06-30',0,'','1810','1810','1810',0,'+1900');
#
# PosNr. 1810
#
WWWRUN	INSERT	Leistungsart	POSNR='1810' and GUELT_VON='2014-07-01' and GUELT_BIS='2015-06-30'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1810','C','Wochenbettbetreuung Nacht,Sa,So',37.58,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2014-07-01','2015-06-30',0,'','','','',0,'+1900');
#


## Anhebung der Vergütung der Positionen 300, 700, 1800, 1810 sowie 2700 zum 1.7.2015
#
# PosNr. 1800
#
WWWRUN	INSERT	Leistungsart	POSNR='1800' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1800','C','Wochenbettbetreuung',31.38,'aufsuchende Wochenbettbetreuung nach der Geburt','2015-07-01','2015-09-24',0,'','1810','1810','1810',0,'+1900');
#
# PosNr. 1810
#
WWWRUN	INSERT	Leistungsart	POSNR='1810' and GUELT_VON='2015-07-01' and GUELT_BIS='2015-09-24'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1810','C','Wochenbettbetreuung Nacht,Sa,So',37.61,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2015-07-01','2015-09-24',0,'','','','',0,'+1900');


## Neues Vergütungsverzeichnis ab 25.9.2015 nach Schiedsspruch
#
# PosNr. 1800
#
WWWRUN	INSERT	Leistungsart	POSNR='1800' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1800','C','Wochenbettbetreuung',32.87,'aufsuchende Wochenbettbetreuung nach der Geburt','2015-09-25','9999-12-31',0,'','1810','1810','1810',0,'+1900');
#
# PosNr. 1810
#
WWWRUN	INSERT	Leistungsart	POSNR='1810' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1810','C','Wochenbettbetreuung Nacht,Sa,So',39.40,'aufsuchende Wochenbettbetreuung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2015-09-25','9999-12-31',0,'','','','',0,'+1900');
#
# PosNr 1900
#
WWWRUN	INSERT	Leistungsart	POSNR='1900' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,ZUSATZGEBUEHREN2,ZUSATZGEBUEHREN3,ZUSATZGEBUEHREN4,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'1900','C','Zuschlag 1. Wochenbettbetreuung nach der Geburt',6.73,'Zuschlag zu der Gebühr nach Nr. 1800 für die erste aufsuchende Wochenbettbetreuung nach der Geburt','2015-09-25','9999-12-31','','+3800','<5GK','+3900','>4GK','','','',0,'');
#
#
# PosNr 2001
#
WWWRUN	INSERT	Leistungsart	POSNR='2001' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2001','C','Wochenbettbetreuung in K-Haus Belegheb.',16.02,'aufsuchende Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme','2015-09-25','9999-12-31',0,'','2011','2011','2011',0,'');
#
# PosNr 2002
#
WWWRUN	INSERT	Leistungsart	POSNR='2002' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2002','C','Wochenbettbetreuung in K-Haus Belegheb. 1:1',16.02,'aufsuchende Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung Beleghebamme 1:1','2015-09-25','9999-12-31',0,'','2012','2012','2012',0,'');
#
#
# PosNr 2011
#
WWWRUN	INSERT	Leistungsart	POSNR='2011' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2011','C','Wochenbettbetr. in K-Haus Nacht,Sa,So Belegheb.',19.20,'Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme','2015-09-25','9999-12-31',0,'','','','',0,'');
#
# PosNr 2012
#
WWWRUN	INSERT	Leistungsart	POSNR='2012' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2012','C','Wochenbettbetr. in K-Haus Nacht,Sa,So Belegheb. 1:1',19.20,'Wochenbettbetreuung in einem Krankenhaus oder in einer außerklinischen Einrichtung unter ärztlicher Leitung mit Zuschlag gemäß §5 Abs. 1 Beleghebamme 1:1','2015-09-25','9999-12-31',0,'','','','',0,'');
#
#
# PosNr. 2100
#
WWWRUN	INSERT	Leistungsart	POSNR='2100' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2100','C','Wochenbettbetreuung in Einr. Leitung Heb.',26.71,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt','2015-09-25','9999-12-31',0,'','2110','2110','2110',0,'');
#
#
# PosNr. 2110
#
WWWRUN	INSERT	Leistungsart	POSNR='2110' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2110','C','Wochenbettbetr. in Einr. Leitung Heb. Nacht,Sa,So',32.04,'aufsuchende Wochenbettbetreuung in einer von Hebammen geleiteten Einrichtung nach der Geburt mit Zuschlag gemäß §5 Abs. 1','2015-09-25','9999-12-31',0,'','','','',0,'');
#
#
# PosNr 2200
#
WWWRUN	INSERT	Leistungsart	POSNR='2200' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2200','C','Zuschlag Zwillinge',10.95,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind','2015-09-25','9999-12-31','','','','','',0,'');
#
# PosNr 2201
#
WWWRUN	INSERT	Leistungsart	POSNR='2201' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2201','C','Zuschlag Zwillinge Beleghebamme',10.95,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind Beleghebamme','2015-09-25','9999-12-31','','','','','',0,'');
#
# PosNr 2202
#
WWWRUN	INSERT	Leistungsart	POSNR='2202' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2202','C','Zuschlag Zwillinge Beleghebamme 1:1',10.95,'Zuschlag für eine aufsuchende Wochenbettbetreuung nach der Geburt von Zwillingen und mehr Kindern zu den Gebühren nach den Nummern 1800 bis 2110, für das zweite und jedes weitere Kind, je Kind Beleghebamme 1:1','2015-09-25','9999-12-31','','','','','',0,'');
#
#
# PosNr 2300
#
WWWRUN	INSERT	Leistungsart	POSNR='2300' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2300','C','Beratung mittels Kommunikationsmedium',6.00,'Beratung der Wöchnerin mittels Kommunikationsmedium','2015-09-25','9999-12-31','','','','','',0,'');
#
# PosNr 2301
#
WWWRUN	INSERT	Leistungsart	POSNR='2301' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2301','C','Beratung mittels Kommunikationsmedium Belegheb.',6.00,'Beratung der Wöchnerin mittels Kommunikationsmedium durch Beleghebamme','2015-09-25','9999-12-31','','','','','',0,'');
#
# PosNr 2302
#
WWWRUN	INSERT	Leistungsart	POSNR='2302' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2302','C','Beratung mittels Kommunikationsmed. Belegheb. 1:1',6.00,'Beratung der Wöchnerin mittels Kommunikationsmedium durch Beleghebamme 1:1','2015-09-25','9999-12-31','','','','','',0,'');
#
#
# PosNr. 2400
#
WWWRUN	INSERT	Leistungsart	POSNR='2400' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2400','C','Erstuntersuchung (U1)',9.00,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung.','2015-09-25','9999-12-31','','','','','',0,'');
#
# PosNr. 2401
#
WWWRUN	INSERT	Leistungsart	POSNR='2401' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2401','C','Erstuntersuchung (U1) Beleghebamme',9.00,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung Beleghebamme.','2015-09-25','9999-12-31','','','','','',0,'');
#
# PosNr. 2402
#
WWWRUN	INSERT	Leistungsart	POSNR='2402' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2402','C','Erstuntersuchung (U1) Beleghebamme 1:1',9.00,'Erstuntersuchung des Kindes einschließlich Eintragung der Befunde in das Untersuchungsheft für Kinder (U 1) nach den Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung Beleghebamme 1:1.','2015-09-25','9999-12-31','','','','','',0,'');
#
#
# PosNr. 2500
#
WWWRUN	INSERT	Leistungsart	POSNR='2500' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2500','C','Entnahme von Körpermaterial',6.73,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung','2015-09-25','9999-12-31','','','','','',0,'');
#
# PosNr. 2501
#
WWWRUN	INSERT	Leistungsart	POSNR='2501' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2501','C','Entnahme von Körpermaterial Belegheb.',6.73,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung Beleghebamme','2015-09-25','9999-12-31','','','','','',0,'');
#
# PosNr. 2502
#
WWWRUN	INSERT	Leistungsart	POSNR='2502' and GUELT_VON='2015-09-25' and GUELT_BIS='9999-12-31'	insert into Leistungsart (ID,POSNR,LEISTUNGSTYP,KBEZ,EINZELPREIS,BEZEICHNUNG,GUELT_VON,GUELT_BIS,FUERZEIT,ZUSATZGEBUEHREN1,SAMSTAG,SONNTAG,NACHT,DAUER,EINMALIG) values (9999,'2502','C','Entnahme von Körpermaterial Belegheb. 1:1',6.73,'Entnahme von Körpermaterial zur Durchführung notwendiger Laboruntersuchungen im Rahmen der Richtlinien des Gemeinsamen Bundesausschusses über die ärztliche Betreuung während der Schwanderschaft und nach der Entbindung (Mutterschafts-Richtlinien) oder im Rahmen der Richtlinien des Bundesausschusses der Ärzte und Krankenkassen über die Früherkennung von Krankheiten bei Kindern bis zur Vollendung des 6. Lebensjahres (Kinder-Richtlinien) in der jeweils geltenden Fassung, je Entnahme, einschließlich Veranlassung der Laboruntersuchung(en), Versand und Portojosten, Dokumentation nach den vorgenannten Richtlinien und Befundübermittlung Beleghebamme','2015-09-25','9999-12-31','','','','','',0,'');

