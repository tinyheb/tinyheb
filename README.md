# tinyHeb

tinyHeb ist eine freie Abrechnungssoftware für Hebammen.

**tinyHeb Version 2.0 befindet sich in der Entwicklung und ist nicht für den produktiven Einsatz bereit.**

## tinyHeb ausführen

### Abhängigkeiten installieren

*wxPython* über das Paketmanagement installieren.

```
$ git clone -b tinyhebv2 https://github.com/tinyheb/tinyheb.git
$ cd tinyheb
$ virtualenv --system-site-packages venv
$ source venv/bin/activate
$ pip install -r requirements.txt
```

Außerdem wird *wxGlade* verwendet um das GUI zu gestalten. Die Quelldatei heißt `tinyheb.wxg`.

### Ausführen

```
$ python tinyheb.py
```
