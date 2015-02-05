# -*- coding: utf-8 -*-

import wx
from TinyhebFrame import TinyhebFrame

class TinyhebApp(wx.App):
    def OnInit(self):
        wx.InitAllImageHandlers()
        tinyheb_frame = TinyhebFrame(None, -1, "")
        self.SetTopWindow(tinyheb_frame)
        tinyheb_frame.Show()
        return 1
