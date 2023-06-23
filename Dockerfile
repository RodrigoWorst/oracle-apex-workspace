FROM ubuntu:14.04

MAINTAINER Rodrigo Worst <rodrigobworst@live.com>

ARG PASSWORD
ENV PASSWORD ${PASSWORD:-Passw0rds}

# get rid of the message: "debconf: unable to initialize frontend: Dialog"
ENV ORACLE_HOME /opt/oracle/product/21c/dbhomeXE
ENV PATH $ORACLE_HOME/bin:$PATH
ENV ORACLE_SID=XE

EXPOSE 22 1521 8080

# all installation files
COPY scripts /scripts

# ! to speed up the build process - only to tests the build process !!!
COPY files /files
# ! to speed up the build process - only to tests the build process !!!

# start the installation
RUN /scripts/install_main.sh


# ENTRYPOINT
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
