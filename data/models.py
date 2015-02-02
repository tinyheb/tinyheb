from sqlobject import SQLObject, StringCol

class Stammdatum(SQLObject):
    fname = StringCol()
    mi = StringCol(length=1, default=None)
    lname = StringCol()
