#!/bin/bash
cd /files

# cat jdk1.7.0_79.zip-a* > jdk1.7.0_79.zip
# rm -f jdk1.7.0_79.zip-a*
#unzip jdk1.7.0_79.zip
#mv jdk1.7.0_79 /usr/local/java

tar -xzf jdk-11.0.18_linux-x64_bin.tar.gz --no-same-owner --no-same-permissions
mv jdk-11.0.18 /usr/local/java
echo 'JAVA_HOME=/usr/local/java' >> /etc/profile
echo 'PATH=$PATH:$HOME/bin:$JAVA_HOME/bin' >> /etc/profile
echo 'export JAVA_HOME' >> /etc/profile
echo 'export PATH' >> /etc/profile
update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/bin/java" 1
source /etc/profile
