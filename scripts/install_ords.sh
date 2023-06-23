#!/bin/bash
#PASSWORD=${1:-secret}

unzip -o /files/ords-21.4.2.062.1806.zip -d /opt/oracle/ords

sed -i -E 's:Passw0rds:'$PASSWORD':g' /scripts/ords_unlock_account.sql
sqlplus -S sys/$PASSWORD@XE as sysdba @/scripts/ords_unlock_account.sql

sed -i -E 's:Passw0rds:'$PASSWORD':g' /scripts/ords_params.properties
cp -rf /scripts/ords_params.properties /opt/oracle/ords/params
cd /opt/oracle/ords
mkdir config
#echo -e 'export PATH="$PATH:/opt/oracle/ords/bin"' >> ~/.bash_profile
java -jar ords.war configdir /opt/oracle/ords/config
cp -rf /scripts/defaults.xml /opt/oracle/ords/config/ords/
printf sys\\n$PASSWORD\\n$PASSWORD\\n1\\n$PASSWORD\\n$PASSWORD\\n1\\n | java -jar ords.war


# solution for the problem with timezone
#dpkg-reconfigure tzdata
echo "America/Sao_Paulo" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

cp -rf /opt/oracle/ords/ords.war /tomcat/webapps/
cp -rf /opt/oracle/apex/images /tomcat/webapps/i
