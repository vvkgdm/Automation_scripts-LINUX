#!/bin/bash
yum install updates -y
#Installing OpenJDK 
echo =============================================================================
echo INSTALLING JAVA
echo ==============================================================================
yum -y install java-1.8.0-openjdk

#Installing MAVEN
echo =============================================================================
echo INSTALLING MAVEN
echo ==============================================================================
cd /opt
# downloading maven version 3.6.2
wget http://mirrors.estointernet.in/apache/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz
tar -xvzf apache-maven-3.6.2-bin.tar.gz
mv apache-maven-3.6.2 maven

#Installing Jenkins
echo =============================================================================
echo INSTALLING Jenkins
echo ==============================================================================


sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins
echo -------------------------------------------------------------------------------------------------
echo  EXPORTING ENVIORNMENTAL VARIABLES
echo ------------------------------------------------------------------------------------------------
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-0.amzn2.0.1.x86_64" >>~/.bash_profile
echo "export M2_HOME=/opt/maven" >>~/.bash_profile
echo "export M2=/opt/maven/bin" >>~/.bash profile
echo -----------------------------------------------------------------------------------------------
echo EXOPRTATION ENDED
echo -----------------------------------------------------------------------------------------------

service jenkins start

### Remove trailing \r character that causes the error if you editing this file on windows
#sed -i 's/\r$//'installing_jenkins_m2_java.sh

