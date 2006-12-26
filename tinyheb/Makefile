PM=*.pm
HTML=*.html
TXT=*.txt README
JS=*.js
CSS=*.css

SUB_DIRS=erfassung edifact rechnung tools concept

USER=root

INSTALL=install
VERBOSE=

DESTDIR=

INST_DIR=$(DESTDIR)/srv/www/cgi-bin/tinyheb/
APACHE_CONF=$(DESTDIR)/etc/apache2/conf.d/

nix:
	echo mache nix

install:
	echo Installiere nach $(INST_DIR)
	$(INSTALL) -d $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p $(INST_DIR)
	$(INSTALL) $(VERBOSE) -o $(USER) -m -x,+r,u+w,g-w,o-w -p $(PM) $(INST_DIR)
	$(INSTALL) $(VERBOSE) -o $(USER) -m -x,+r,u+w,g-w,o-w -p $(HTML) $(INST_DIR)
	$(INSTALL) $(VERBOSE) -o $(USER) -m -x,+r,u+w,g-w,o-w -p $(TXT) $(INST_DIR)
	$(INSTALL) $(VERBOSE) -o $(USER) -m -x,+r,u+w,g-w,o-w -p $(JS) $(INST_DIR)
	$(INSTALL) $(VERBOSE) -o $(USER) -m -x,+r,u+w,g-w,o-w -p $(CSS) $(INST_DIR)

#	Sub Directories installieren
#	 erfassungssteuerung	
	$(INSTALL) -d $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p $(INST_DIR)/erfassung/
	$(INSTALL) $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p erfassung/*.js erfassung/*.pl $(INST_DIR)/erfassung/

#	 rechnungen	
	$(INSTALL) -d $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p $(INST_DIR)/rechnung/
	$(INSTALL) $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p rechnung/*.js rechnung/*.pl $(INST_DIR)/rechnung/

#	 tools	
	$(INSTALL) -d $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p $(INST_DIR)/tools/
	$(INSTALL) $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p tools/*.* $(INST_DIR)/tools/

#	 edifact
	$(INSTALL) -d $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p $(INST_DIR)/edifact/
	$(INSTALL) $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p edifact/*.* $(INST_DIR)/edifact/

#	 DATA
	$(INSTALL) -d $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p $(INST_DIR)/DATA/
	$(INSTALL) $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p DATA/*.* $(INST_DIR)/DATA/

#	 Concept
	$(INSTALL) -d $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p $(INST_DIR)/concept/
	$(INSTALL) $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p concept/*.pdf $(INST_DIR)/concept/


#	 win32
	$(INSTALL) -d $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p $(INST_DIR)/win32/
	$(INSTALL) $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p win32/*.* $(INST_DIR)/win32/


# Apache Directiven

	$(INSTALL) -d $(VERBOSE) -o $(USER) -m +x,+r,u+w,g-w,o-w -p $(APACHE_CONF)/
	$(INSTALL) $(VERBOSE) -o $(USER) -m -x,+r,u+w,g-w,o-w -p apache2/tinyheb.conf $(APACHE_CONF)/tinyheb.conf

# MySQL DB inititalisieren
	cd $(INST_DIR)/DATA
	echo "mysql -u root < init.sql muss noch im Verzeichnis $(INST_DIR)/DATA ausgeführt werden"


