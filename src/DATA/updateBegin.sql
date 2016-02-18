# Updates für tinyHeb
#
# altes Zeug...
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
#
#
# zunächst alte GO ungültig machen
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2007-07-31' where GUELT_VON = '2004-01-01' and GUELT_BIS = '9999-12-31';
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2007-07-31' where GUELT_VON = '2006-01-01' and GUELT_BIS = '9999-12-31';
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2009-12-31' where GUELT_VON = '2008-07-01' and GUELT_BIS = '9999-12-31';
#
#
#
#
# alte Materialien ungültig machen
#
WWWRUN	UPDATE	Leistungsart		update Leistungsart set GUELT_BIS='2009-12-31' where GUELT_VON = '2007-08-01' and GUELT_BIS = '9999-12-31';
#

