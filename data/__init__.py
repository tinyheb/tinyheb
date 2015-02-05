# -*- coding: utf-8 -*-

import os
from sqlobject import sqlhub, connectionForURI
from models import Stammdatum

# create connection to sqlite
db_filename = os.path.abspath("tinyheb.db")
connection = connectionForURI("sqlite://%s" % db_filename)
sqlhub.processConnection = connection

# initialize database
Stammdatum.createTable(ifNotExists=True)
