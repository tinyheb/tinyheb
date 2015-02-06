# -*- coding: utf-8 -*-

import os
from sqlobject import sqlhub, connectionForURI
from data import connection
from data.models import Stammdatum


def setup():
    stammdaten = (
        ("Gonzales", "Rosa", "Musterstr.", 10999, "Berlin", "Barmer"),
        ("Schmidt", "Helga", "Uferweg", 12345, "Hagen", "TK"),
        ("Bauer", "Ruth", "Bergstraße", 19874, "Hamburg", "AOK"),
    )
    for name, vorname, strasse, plz, ort, krankenkasse in stammdaten:
        sd = Stammdatum(name=name, vorname=vorname, strasse=strasse, plz=plz,
                        ort=ort, krankenkasse=krankenkasse)

def trivial_test():
    print "This test is always passed."
    pass

def teardown():
    pass
