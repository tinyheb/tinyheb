use PRD_Hebamme;

update Parms set VALUE = 'BKK <le@bkk-bv.de>' where name='MAIL104027544';
update Leistungsart set DAUER=180 where POSNR=6;
update Leistungsart set FUERZEIT='E60' where POSNR=7;
update Leistungsart set FUERZEIT='E60' where POSNR=8;
update Leistungsart set SONNTAG='' where POSNR=15;
update Leistungsart set SAMSTAG='' where POSNR=15;
update Leistungsart set NACHT='' where POSNR=15;
update Leistungsart set FUERZEIT='E60' where POSNR=40;
update Parms set VALUE ='AOK RZ Lahr <da@dta.aok.de>' where name='MAIL108018007';
update Parms set VALUE = 'TSystems <dav01@b2b.mailorbit.de>' where name = 'MAIL109905003';
update Parms set VALUE ='AOK Sachsen <da@dta.aok.de>' where name='MAIL107299005';
update Parms set VALUE ='AOK RZ Niedersachsen <da@dta.aok.de>' where name='MAIL102110939';
update Parms set VALUE ='AOK Bremen <da@dta.aok.de>' where name='MAIL103119199';
update Parms set VALUE ='AOK Magdeburg <da@dta.aok.de>' where name='MAIL101097008';
update Parms set VALUE ='AOK Berlin <da@dta.aok.de>' where name='MAIL109519005';
update Parms set VALUE ='AOK Westfalen-Lippe <da@dta.aok.de>' where name='MAIL103411401';
update Parms set VALUE ='AOK Schleswig-Holstein <da@dta.aok.de>' where name='MAIL101317004';
update Parms set VALUE ='AOK Hamburg <da@dta.aok.de>' where name='MAIL101519213';
update Parms set VALUE ='AOK Mecklenburg-Vorpommern <da@dta.aok.de>' where name='MAIL100395611';

