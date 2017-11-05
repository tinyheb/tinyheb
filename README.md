# Was ist tinyHeb
tinyHeb ist eine Webapplikation mit der Hebammen die notwendigen Abrechnungen gegenüber den gesetzlichen Krankenkassen durchführen können. tinyHeb kann sowohl Papier, wie auch elektronische Rechnungen produzieren. Die gesetzlichen Anforderungen nach [§301a](https://dejure.org/gesetze/SGB_V/301a.html), resp. [§302](https://dejure.org/gesetze/SGB_V/302.html) SGB V werden eingehalten.

# Installation
In diesem Abschnitt ist die Installation für Linux Systeme beschrieben, Win* Nutzer lesen bitte die Installationshinweise in der Datei [README.win](README_win.txt).
Am einfachsten ist die Installation über RPM Pakete, die im Internet zum Download zur Verfügung stehen. Die genaue Anleitung findet man im Internet unter: https://tinyheb.de/. Abhängige Pakete werden automatisch installiert.

Wer in den vollen Genuß der Rechnungvorschau kommen möchte, braucht einen modernen Browser, der PDF-Dateien anzeigen kann, beispielsweise mittels der Erweiterung [PDF.js](https://github.com/mozilla/pdf.js/).
Ältere Browser (Firefox vor Version 52, sowie [Firefox ESR](https://www.mozilla.org/en-US/firefox/organizations/)) können noch das Paket mozplugger installieren, dies ist leider seit SuSE 9.3 nicht mehr in der Distribution enthalten. Bei Packmann kann es heruntergeladen werden. Wer nicht weiss wie das funktioniert, schicke mir bitte eine Mail.

Wenn die Installation auf Basis des Sources durchgeführt werden soll sind die folgenden Schritte notwendig:
1. Schritt
Prüfen, ob die Basiskomponenten vorhanden sind, es muss MySQL Server und MySQL Client installiert sein, und der Apache2 Webserver. Dann
    ```
    su
    make install
    ```
    oder bei Debian (Ubuntu, Kubuntu, ...)
    ```
    sudo make install
    ```

2. Schritt
Wechsel in das Verzeichnis DATA.
Befehl `mysql -u root < init.sql` ausführen, damit wird der notwendigen user und die Datenbanktabellen angelegt.

3. Schritt
Webserver neu starten `/etc/init.d/apache2 restart`

4. Schritt
Benötigte Perl-Module installieren, das sind:
- DBI,
- DBD,
- CGI,
- Date::Calc
- File::stat,
- MIME::QuotedPrint,
- Tk,
- Mail::Sender,
- PostScript::Simple
- Net::SSLeay
die gibt es als DEB- oder RPM-Pakete, was zu empfehlen ist, oder bei www.cpan.org.

# Fast fertig
Im Browser kann jetzt über http://localhost/tinyheb/hebamme.html tinyHeb gestart werden. Um elektronische Rechnungen zu verschicken existiert das Programm [xauftrag.pl](src/edifact/xauftrag.pl) im Verzeichnis [edifact](src/edifact/).
Jetzt ist es noch notwendig die Parameter wie in Kapitel 2.4 des [Handbuches](https://tinyheb.de/assets/tinyheb-handbuch.pdf) beschrieben anzupassen, damit z.B. der wirkliche Name der Hebamme auf der Rechnung erscheint.

# Änderungshistorie
Die Änderungshistorie befindet sich in der Datei [RelNotes.txt](RelNotes.txt).

# zusätzliche Programme
[OpenSSL](https://www.openssl.org/) muss installiert sein, wenn man verschlüsselte Rechnungen erzeugen möchte.

# Fragen
Fragen werden am besten auf der tinyHeb-Mailingliste diskutiert und beantwortet: https://lists.launchpad.net/tinouheb/
