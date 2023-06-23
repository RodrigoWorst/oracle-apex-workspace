#!/bin/bash

mv /scripts/chkconfig /sbin/chkconfig
apt-get update && apt-get install -y -q libaio1 net-tools bc
ln -s /usr/bin/awk /bin/awk && mkdir /var/lock/subsys
chmod 755 /sbin/chkconfig

echo 'Install alien and create a deb file'
sudo apt-get install alien -y
cd files
sudo alien --scripts oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
echo 'Install the Oracle Database'
dpkg --install /files/oracle-database-xe-21c_1.0-2_amd64.deb

printf 8888\\n1521\\n$PASSWORD\\n$PASSWORD\\ny\\n | /etc/init.d/oracle-xe-21c configure
echo 'export ORACLE_HOME=/opt/oracle/product/21c/dbhomeXE' >> /etc/bash.bashrc
echo 'export PATH=$ORACLE_HOME/bin:$PATH' >> /etc/bash.bashrc
echo 'export ORACLE_SID=XE' >> /etc/bash.bashrc

#echo '********************'
#echo 'COPY ORACLE CLIENT AND SQLPLUS'
#cp instantclient-basic-linux.x64-21.10.0.0.0dbru.zip /opt/oracle/
#cp instantclient-sqlplus-linux.x64-21.10.0.0.0dbru.zip /opt/oracle/
#unzip instantclient-basic-linux.x64-21.10.0.0.0dbru.zip
#unzip instantclient-sqlplus-linux.x64-21.10.0.0.0dbru.zip
#export LD_LIBRARY_PATH=/opt/oracle/instantclient_21_10:$LD_LIBRARY_PATH
#export PATH=/opt/oracle/instantclient_21_10:$PATH

# clean
apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
rm -rf /files/oracle-database-xe*
