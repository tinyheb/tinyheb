# -*- coding: utf-8 -*-

import wx

from data.models import Stammdatum
from StammdatenListCtrl import StammdatenListCtrl

contextMenu = ["Neu", "Löschen"]


class TinyhebStammdatenPanel(wx.Panel):
    def __init__(self, *args, **kwds):
        kwds["style"] = wx.TAB_TRAVERSAL
        wx.Panel.__init__(self, *args, **kwds)

        self.__set_properties()
        self.__do_layout()

        self.Bind(wx.EVT_LIST_ITEM_RIGHT_CLICK, self.onRightClick, id=wx.ID_ANY)
        self.contextMenu = wx.Menu()

        contextMenuHandler = {"Neu": self.onNewStammdatum, "Löschen": self.onDeleteStammdatum}
        for (name, handler) in contextMenuHandler.iteritems():
            menuItemId = wx.NewId()
            self.contextMenu.Append(menuItemId, name)
            self.Bind(wx.EVT_MENU, handler, id=menuItemId)

    def __set_properties(self):
        self.stammdaten_list_ctrl = StammdatenListCtrl(self)

    def __do_layout(self):
        stammdaten_sizer = wx.BoxSizer(wx.HORIZONTAL)
        self.SetSizer(stammdaten_sizer)
        stammdaten_sizer.Fit(self)
        self.Layout()
        # end wxGlade
        stammdaten_sizer.Add(self.stammdaten_list_ctrl, 1, wx.EXPAND, 0)

    def onRightClick(self, event):
        self.PopupMenu(self.contextMenu, event.GetPoint())

    def onNewStammdatum(self, event):
        sd = Stammdatum()
        self.stammdaten_list_ctrl.AddObject(sd)

    def onDeleteStammdatum(self, event):
        target = self.stammdaten_list_ctrl.GetSelectedObject()
        try:
            # TODO: ask for reaffirmation!
            self.stammdaten_list_ctrl.RemoveObject(target)
            target.destroySelf()
        except(Exception):
            pass

    # TODO: tooltip with validate error
