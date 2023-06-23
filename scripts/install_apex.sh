#!/bin/bash
#PASSWORD=${1:-Passw0rds}

#SQLPLUS=sqlplus
#sys/$PASSWORD@XE as sysdba="sys/$PASSWORD@XE as sysdba"

verify_connection(){
	echo "exit" | sqlplus -L sys/$PASSWORD@XE as sysdba | grep Connected
	if [ $? -eq 0 ];
	then
	   echo "Database Connetion is OK"
	else
	   echo -e "Database Connection Failed. Connection failed with:\n sqlplus -S sys/$PASSWORD@XE as sysdba\n `sqlplus -S sys/$PASSWORD@XE as sysdba` < /dev/null"
	   exit 1
	fi

	if [ "$(ls -A /opt/oracle)" ]; then
		echo "Check Database files folder: OK"
	else
		echo -e "Failed to find database files, run example:\n docker run -it --rm --volumes-from $oracle_db_name:oracle-database --link $oracle_db_name:oracle-database apex_ords install"
		exit 1
	fi
}

disable_http(){
	echo "Turning off DBMS_XDB HTTP port"
	echo "EXEC DBMS_XDB.SETHTTPPORT(0);" | sqlplus -S sys/$PASSWORD@XE as sysdba
}

enable_http(){
	echo "Turning on DBMS_XDB HTTP port"
	echo "EXEC DBMS_XDB.SETHTTPPORT(8888);" | sqlplus -S sys/$PASSWORD@XE as sysdba
}

get_oracle_home(){
	echo "Getting ORACLE_HOME Path"
	ORACLE_HOME=`echo -e "var ORACLEHOME varchar2(200);\n EXEC dbms_system.get_env('ORACLE_HOME', :ORACLEHOME);\n PRINT ORACLEHOME;" | sqlplus -S sys/$PASSWORD@XE as sysdba | grep "/.*/"`
	echo "ORACLE_HOME found: $ORACLE_HOME"
}


apex_upgrade(){
	cd /opt/oracle/apex
	echo "Upgrading apex..."
	printf "ALTER SESSION SET CONTAINER=XEPDB1;"\\n"CREATE TABLESPACE APX_TBS DATAFILE '/opt/oracle/oradata/XE/XEPDB1/apx_tbs01.dbf' SIZE 200M AUTOEXTEND ON MAXSIZE UNLIMITED;"\\n"@apexins APX_TBS APX_TBS TEMP /i/;"\\n | sqlplus -S sys/$PASSWORD@XE as sysdba
}

conf_rest(){
	cd /opt/oracle/apex
	echo "Installing rest..."
	printf "ALTER SESSION SET CONTAINER=XEPDB1;"\\n"@apex_rest_config.sql $PASSWORD $PASSWORD $PASSWORD" | sqlplus -S sys/$PASSWORD@XE as sysdba
}

unzip_apex(){
	echo "Extracting Apex-21.2"
	rm -rf /opt/oracle/apex
	unzip /files/apex_21.2.zip -d /opt/oracle/
}
#verify_connection
echo 'vai zipar o apex'
unzip_apex
echo 'zipou o apex'
echo 'disable http'
disable_http
echo 'apex upgrade'
apex_upgrade
enable_http
conf_rest
