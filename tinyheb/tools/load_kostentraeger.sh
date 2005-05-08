#! /bin/sh

cd /home/baum/entwicklung/perl/hebamme/tools/kostentraeger/;
KK=$(ls *.txt);
echo "KK:" $KK

mysql -e "use Hebamme;delete from Krankenkassen;"
for i in $KK ; do
    /home/baum/entwicklung/perl/hebamme/tools/kostentraeger.pl $i > /tmp/$i.sql;
    mysql --local-infile=1 -e "
    use Hebamme;
    load data local infile '/tmp/$i.sql' into table Krankenkassen;
    "
    echo $i "geladen";
#    rm /tmp/$i.sql;
done


