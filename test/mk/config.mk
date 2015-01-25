REVERT := vboxmanage controlvm TinyhebTest poweroff; \
          vboxmanage snapshot TinyhebTest restore tinyheb_1.6.3_fixed; \
		  vboxmanage startvm TinyhebTest --type headless
URL := http://192.168.1.9/tinyheb/
SQL_DB := PRD_Hebamme
SQL_USER := testuser
SQL_HOST := 192.168.1.9
