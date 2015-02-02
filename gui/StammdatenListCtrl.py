# -*- coding: utf-8 -*-

import wx

class StammdatenListCtrl(wx.ListCtrl):

    def __init__(self, *args, **kwds):
        wx.ListCtrl.__init__(self, *args, **kwds)

        self.InsertColumn(0, "Name")
        self.InsertColumn(1, "Vorname")
        self.InsertColumn(2, u"Straße")
        self.InsertColumn(3, "PLZ")
        self.InsertColumn(4, "Ort")
        self.InsertColumn(5, "Krankenkasse")
