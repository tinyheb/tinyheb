## tinyHeb unter Windows ausführen

*Getestet unter Windows 7 (32 bit).*

* Python installieren (https://www.python.org/ftp/python/2.7.9/python-2.7.9.msi bzw. https://www.python.org/ftp/python/2.7.9/python-2.7.9.amd64.msi)
* wxPython installieren (http://downloads.sourceforge.net/wxpython/wxPython3.0-win32-3.0.2.0-py27.exe bzw. http://downloads.sourceforge.net/wxpython/wxPython3.0-win64-3.0.2.0-py27.exe)
* Shell starten (`cmd.exe`) und ins tinyHeb-Verzeichnis wechseln und folgende Kommandos ausführen:

```
pip install virtualenv
virtualenv --system-site-packages venv
venv\Scripts\activate.bat
pip install -r requirements_windows.txt
python tinyheb.py
```
