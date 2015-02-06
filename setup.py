#!/usr/bin/env python
# -*- coding: utf-8 -*-

from distutils.core import setup
import py2exe

setup(
    name="tinyheb",
    version="0.8.0",
    description="Eine Open-Source-Abrechnungssoftware für Hebammen",

    windows=[{'script': 'tinyheb.py'}],
    options = {
        "py2exe": {
            "dll_excludes": ["MSVCP90.dll"],
        },
    },
)
