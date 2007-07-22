PM=*.pm
HTML=*.html
TXT=*.txt README
JS=*.js
CSS=*.css

SUB_DIRS=erfassung edifact rechnung tools

#USER=root

INSTALL=install
VERBOSE=

#DESTDIR=

INST_DIR=$(DESTDIR)/srv/www/cgi-bin/tinyheb/
APACHE_CONF=$(DESTDIR)/etc/apache2/conf.d/

nix:
	@echo mache nix

clean:
	@echo mache nix

install:
	@echo Installiere nach $(INST_DIR)
	$(INSTALL) -d $(VERBOSE)  -m +x,+r,u+w,g-w,o-w -p $(INST_DIR)
	$(INSTALL) $(VERBOSE) -m -x,+r,u+w,g-w,o-w -p $(PM) $(INST_DIR)
	$(INSTALL) $(VERBOSE) -m -x,+r,u+w,g-w,o-w -p $(HTML) $(INST_DIR)
	$(INSTALL) $(VERBOSE) -m -x,+r,u+w,g-w,o-w -p $(TXT) $(INST_DIR)
	$(INSTALL) $(VERBOSE) -m -x,+r,u+w,g-w,o-w -p $(JS) $(INST_DIR)
	$(INSTALL) $(VERBOSE) -m -x,+r,u+w,g-w,o-w -p $(CSS) $(INST_DIR)

#	Sub Directories installieren
	for i in $(SUB_DIRS); do \
	echo Unterverzeichnis $$i; \
	$(INSTALL) -d $(VERBOSE) -m +x,+r,u+w,g-w,o-w -p $(INST_DIR)/$$i/; \
	\
	if [ -n "$$(ls $$i/*.js 2>/dev/null)" ]; then \
	$(INSTALL) $(VERBOSE) -m -x,+r,u+w,g-w,o-w -p $$i/*.js $(INST_DIR)/$$i/; \
	fi; \
	\
	if [ -n "$$(ls $$i/*.pl 2>/dev/null)" ]; then \
		$(INSTALL) $(VERBOSE) -m +x,+r,u+w,g-w,o-w -p $$i/*.pl $(INST_DIR)/$$i/; \
	fi; \
	\
	if [ -n "$$(ls $$i/*.html 2>/dev/null)" ]; then \
		$(INSTALL) $(VERBOSE) -m -x,+r,u+w,g-w,o-w -p $$i/*.html $(INST_DIR)/$$i/; \
	fi; \
	\
	if [ -n "$$(ls $$i/*.sql 2>/dev/null)" ]; then \
		$(INSTALL) $(VERBOSE) -m -x,+r,u+w,g-w,o-w -p $$i/*.sql $(INST_DIR)/$$i/; \
	fi; \
	\
	if [ -n "$$(ls $$i/*.pdf 2>/dev/null)" ]; then \
		$(INSTALL) $(VERBOSE) -m -x,+r,u+w,g-w,o-w -p $$i/*.pdf $(INST_DIR)/$$i/; \
	fi; \
	\
	if [ -n "$$(ls $$i/*.ini 2>/dev/null)" ]; then \
		$(INSTALL) $(VERBOSE) -m -x,+r,u+w,g-w,o-w -p $$i/*.ini $(INST_DIR)/$$i/; \
	fi; \
	if [ -n "$$(ls $$i/*.conf 2>/dev/null)" ]; then \
		$(INSTALL) $(VERBOSE) -m -x,+r,u+w,g-w,o-w -p $$i/*.conf $(INST_DIR)/$$i/; \
	fi; \
	done
# Apache Directiven

	$(INSTALL) -d $(VERBOSE)  -m +x,+r,u+w,g-w,o-w -p $(APACHE_CONF)/
	$(INSTALL) $(VERBOSE) -m -x,+r,u+w,g-w,o-w -p apache2/tinyheb.conf $(APACHE_CONF)/tinyheb.conf

# MySQL init
	@echo jetzt muss noch die Datenbank initialisiert werden
	cd $(INST_DIR)/DATA; \
-	@echo "mysql -u root < init.sql muss noch im Verzeichnis $(INST_DIR)/DATA ausgeführt werden"



