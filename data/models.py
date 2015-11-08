# -*- coding: utf-8 -*-

from sqlobject import SQLObject, StringCol, IntCol

class Stammdatum(SQLObject):
    # TODO: add missing cols
    # TODO: especially how to do the id?
    name = StringCol(default="")
    vorname = StringCol(default="")
    strasse = StringCol(default="")
    plz = IntCol(default=0)
    ort = StringCol(default="")
    krankenkasse = StringCol(default="")

