# -*- coding: utf-8 -*-

from sqlobject import SQLObject, StringCol, IntCol

class Stammdatum(SQLObject):
    name = StringCol()
    vorname = StringCol()
    strasse = StringCol()
    plz = IntCol()
    ort = StringCol()
    krankenkasse = StringCol()
