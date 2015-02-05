# -*- coding: utf-8 -*-

import wx
from ObjectListView import ObjectListView, ColumnDefn
from data.models import Stammdatum


COLUMNS = [
    ColumnDefn(title="Name", valueGetter="name", minimumWidth=100, isSpaceFilling=True),
    ColumnDefn(title="Vorname", valueGetter="vorname", minimumWidth=100, isSpaceFilling=True),
    ColumnDefn(title=u"Straße", valueGetter="strasse", minimumWidth=100, isSpaceFilling=True),
    ColumnDefn(title=u"PLZ", valueGetter="plz", minimumWidth=80, isSpaceFilling=True),
    ColumnDefn(title=u"Ort", valueGetter="ort", minimumWidth=100, isSpaceFilling=True),
    ColumnDefn(title=u"Krankenkasse", valueGetter="krankenkasse", minimumWidth=100, isSpaceFilling=True),
]

class StammdatenListCtrl(ObjectListView):

    def __init__(self, parent):
        ObjectListView.__init__(
            self, parent, -1, style=wx.LC_REPORT|wx.SUNKEN_BORDER)

        self.evenRowsBackColor = wx.SystemSettings.GetColour(
            wx.SYS_COLOUR_LISTBOX)
        self.oddRowsBackColor = wx.SystemSettings.GetColour(
            wx.SYS_COLOUR_3DLIGHT)

        self.SetColumns(COLUMNS)
        objects = list(Stammdatum.select())
        print objects
        self.SetObjects(objects)
