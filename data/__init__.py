# -*- coding: utf-8 -*-

import os
from sqlobject import sqlhub, connectionForURI
from models import Stammdatum

# create connection to sqlite
db_filename = os.path.abspath("tinyheb.db")

if os.name == "nt":
    conn_string = "sqlite:/%s" % db_filename
else:
    conn_string = "sqlite://%s" % db_filename

print "Using sqlite file: %s" % db_filename
connection = connectionForURI(conn_string)

# pass connection to sqlobject
sqlhub.processConnection = connection

# initialize database
Stammdatum.createTable(ifNotExists=True)
