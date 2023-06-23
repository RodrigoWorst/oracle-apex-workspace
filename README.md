Oracle Workspace
============================

# This repo is a update from araczkowski/oracle-apex-ords

Oracle Express Edition 21c Release on Ubuntu 14.04.1 LTS with APEX 21.2 and ORDS 21.4 on Tomcat 9
# Option 1. Own docker image, with custom password

#### Get the image code from github:

    git clone --depth=1 https://github.com/rodrigoworst/oracle-apex-workspace.git <own-image-name>
    cd <own-image-name>

#### Building your own image, with custom password:

    docker build -t <own-image-name> --build-arg PASSWORD=<custom-password> .

#### Run the container based on your own image with 8080, 1521, 22 ports opened:

    docker run -d --name <own-container-name> -p 49160:22 -p 8080:8080 -p 1521:1521 <own-image-name>

# Option 2. Get the prebuilt image from docker hub

#### Installation:

    docker pull rodrigoworst/oracle-apex-workspace

#### Run the container based on prebuilt image from docker with 8080, 1521, 22 ports opened:

    docker run -d --name <own-container-name> -p 49160:22 -p 8080:8080 -p 1521:1521 rodrigoworst/oracle-apex-workspace

#### Password for SYS & SYSTEM & Tomcat ADMIN:

        Passw0rds


# Connect to server in container (Option 1. / Option 2.)

##### Connect via ssh to server with following setting:

    ssh root@localhost -p 49160
    password: <custom-password> / Passw0rds

##### Connect database with following setting:

    hostname: localhost
    port: 1521
    sid: xe
    username: system
    password: <custom-password> / Passw0rds


##### Connect to Tomcat Manager with following settings:

    http://localhost:8080/manager
    user: ADMIN
    password: <custom-password> / Passw0rds

##### Connect to Oracle Application Express web management console via ORDS with following settings:

    1.On the linux client, enter the apex installation directory:
		
		cd opt/oracle/apex
	
	2.Open a database connection using SQLPLUS:
		
		sqlplus sys as sysdba
		password: <custom-password> / Passw0rds
	
	3.Run:
		
		ALTER SESSION SET CONTAINER=XEPDB1;
	
	4.Run the script. Enter the username (default ADMIN), Email(optional) and Password(format: Password123!)
	
		@apxchpwd.sql
	
	5.Open the browser and login:
	
		http://localhost:8080/ords/apex
		workspace: INTERNAL
		user: <Username> / ADMIN
		password: <custom-password>
