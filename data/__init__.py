# -*- coding: utf-8 -*-

import os
from sqlobject import sqlhub, connectionForURI
from models import Stammdatum

# create connection to sqlite
db_filename = os.path.abspath("tinyheb.db")

if os.name == "nt":
    print "on win"
    conn_string = "sqlite:/%s" % db_filename
else:
    print "Non win"
    conn_string = "sqlite://%s" % db_filename

print "Using sqlite file: %s" % db_filename
connection = connectionForURI(conn_string)
sqlhub.processConnection = connection

# initialize database
Stammdatum.createTable(ifNotExists=True)
