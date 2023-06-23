#!/bin/bash

cd /files
tar -xzf apache-tomcat-9.0.76.tar.gz
mv /files/apache-tomcat-9.0.76 /tomcat
sed -i -e 's/password="Passw0rds"/password="'$PASSWORD'"/g' /scripts/tomcat-users.xml
mv /scripts/tomcat-users.xml /tomcat/conf
mv /scripts/context.xml /tomcat/webapps/manager/META-INF
mv /scripts/tomcat9 /etc/init.d/tomcat
chmod 755 /etc/init.d/tomcat
update-rc.d tomcat defaults  80 01
