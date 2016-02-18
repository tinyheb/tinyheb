## Das Beste kommt zum Schluss - ich glaube hier werden Datensätze "gepatcht".(?!)
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

