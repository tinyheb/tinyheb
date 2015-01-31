## Variables

include mk/tools.mk
include mk/config.mk
# Test directories

GO_DIR := gebuehrenordnung
SD_DIR := stammdaten


# Tests - lynx scripts

GO_TEST_SCRIPTS_2014_01 := $(wildcard $(GO_DIR)/2014-01/*.lynx)
GO_TEST_SCRIPTS_2014_07 := $(wildcard $(GO_DIR)/2014-07/*.lynx)
GO_TEST_SCRIPTS := $(GO_TEST_SCRIPTS_2013_12) $(GO_TEST_SCRIPTS_2014_01) $(GO_TEST_SCRIPTS_2014_07)

GO_TEST_N_CLEAN_2014_01 := $(patsubst %.lynx,%.clean,$(GO_TEST_SCRIPTS_2014_01))
GO_TEST_N_CLEAN_2014_07 := $(patsubst %.lynx,%.clean,$(GO_TEST_SCRIPTS_2014_07))
GO_TEST_N_CLEAN := $(patsubst %.lynx,%.clean,$(GO_TEST_SCRIPTS))

GO_TEST_TARGETS := $(patsubst %.lynx,%,$(GO_TEST_SCRIPTS))

GO_TEST_OUTFILES := $(patsubst %.lynx,%.out,$(GO_TEST_SCRIPTS))


SD_TEST_SCRIPTS := $(wildcard $(SD_DIR)/*.lynx)

SD_TEST_N_CLEAN := $(patsubst %.lynx,%.clean,$(SD_TEST_SCRIPTS))

SD_TEST_TARGETS := $(patsubst %.lynx,%,$(SD_TEST_SCRIPTS))

SD_TEST_OUTFILES := $(patsubst %.lynx,%.out,$(SD_TEST_SCRIPTS))

define do-clean =
$(RM) $(SD_TEST_OUTFILES) $(GO_TEST_OUTFILES)
$(REVERT)
endef

define evaluate-test =
$(TEST) "$(shell $(DIFF) $^)" == ""
endef


## Rules
.PHONY: all stammdaten gebuehrenordnung clean \
	    $(SD_TEST_N_CLEAN) $(GO_TEST_N_CLEAN) $(SD_TEST_TARGETS) $(GO_TEST_TARGETS)

all: stammdaten gebuehrenordnung

stammdaten: $(SD_TEST_N_CLEAN)

gebuehrenordnung: $(GO_TEST_N_CLEAN)
gebuehrenordnung/2014-01: $(GO_TEST_N_CLEAN_2014_01)
gebuehrenordnung/2014-07: $(GO_TEST_N_CLEAN_2014_07)


# run a test and clean up afterwards
$(SD_TEST_N_CLEAN): %.clean: %
	$(do-clean)

$(GO_TEST_N_CLEAN): %.clean: %
	$(MYSQL) -u $(SQL_USER) -h $(SQL_HOST) -e 'TRUNCATE Leistungsdaten;' $(SQL_DB)

$(SD_TEST_TARGETS): %: %.out %.in
	$(evaluate-test)

$(GO_TEST_TARGETS): %: %.out %.in
	$(evaluate-test)

# run tests
$(SD_TEST_OUTFILES): %.out: %.lynx %.sql
	$(LYNX) -cmd_script=$*.lynx $(URL)
	$(MYSQL) -u $(SQL_USER) -h $(SQL_HOST) -e $(shell $(CAT) $*.sql) $(SQL_DB) > $@

$(GO_TEST_OUTFILES): %.out: %.lynx $(GO_DIR)/preis.sql stammdaten/lieschen_mueller
	$(LYNX) -cmd_script=$*.lynx $(URL)/erfassung/rechnungserfassung.pl?frau_id=2
	$(MYSQL) -u $(SQL_USER) -h $(SQL_HOST) -e $(shell $(CAT) $(GO_DIR)/preis.sql) $(SQL_DB) > $@


clean:
	$(do-clean)

