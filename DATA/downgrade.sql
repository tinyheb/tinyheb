# Updates für tinyHeb
#
# $Id$
# Tag $Name$
#
# ---------- nach 0.19.0 ----------------
#
# Parm Begründung geplante Hausgeburt löschen
#
WWWRUN	UPDATE	Parms		delete from Parms where NAME='BEGRUENDUNG' and VALUE='geplante Hausgeburt';
#
#
# Feld PRIVAT_FAKTOR aus Tabelle Stammdaten löschen
ROOT	ALTER	Stammdaten		alter table Stammdaten drop PRIVAT_FAKTOR;
#
# Materialpauschalen wieder auf alten Wert setzen
WWWRUN	UPDATE	Leistungsart		delete from Leistungsart where LEISTUNGSTYP='M' and GUELT_VON='2008-07-01' and GUELT_BIS='9999-12-31' and POSNR >= 340 and POSNR <= 400;
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='9999-12-31' where GUELT_VON='2007-08-01' and GUELT_BIS='2008-06-30';
