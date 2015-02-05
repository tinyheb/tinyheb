# -*- coding: utf-8 -*-

import os
from sqlobject import sqlhub, connectionForURI
from data.models import Stammdatum


db_filename = os.path.abspath("tinyheb.db")
connection = connectionForURI("sqlite://%s" % db_filename)
sqlhub.processConnection = connection

def setup():
    stammdaten = (
        ("Gonzales", "Rosa", "Musterstr.", 10999, "Berlin", "Barmer"),
        ("Schmidt", "Helga", "Uferweg", 12345, "Hagen", "TK"),
        ("Bauer", "Ruth", "Bergstraße", 19874, "Hamburg", "AOK"),
    )
    for name, vorname, strasse, plz, ort, krankenkasse in stammdaten:
        sd = Stammdatum(name=name, vorname=vorname, strasse=strasse, plz=plz,
                        ort=ort, krankenkasse=krankenkasse)

def teardown():
    pass
