#!/bin/bash

exec >> >(tee -ai /docker_log.txt)
exec 2>&1
ls /opt/oracle/product/21c/dbhomeXE/network/admin/
# # Update hostname
sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /opt/oracle/homes/OraDBHome21cXE/network/admin/listener.ora
sed -i -E "s/HOST = [^)]+/HOST = $HOSTNAME/g" /opt/oracle/homes/OraDBHome21cXE/network/admin/tnsnames.ora
sed -i -E "s/PORT = [^)]+/PORT = 1521/g" /opt/oracle/homes/OraDBHome21cXE/network/admin/listener.ora
#
/etc/init.d/oracle-xe-21c start
/etc/init.d/tomcat start
/etc/init.d/ssh start

##
## Workaround for graceful shutdown. ....ing oracle... ‿( ́ ̵ _-`)‿
##
while [ "$END" == '' ]; do
	sleep 1
	trap "/etc/init.d/oracle-xe-21c stop && END=1" INT TERM
done
;
