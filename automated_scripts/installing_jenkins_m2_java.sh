#!/bin/bash
yum install updates -y
#Installing OpenJDK 
echo =============================================================================
echo INSTALLING JAVA
echo ==============================================================================
yum install java-11-openjdk -y
yum insatll wget -y

#Installing MAVEN
echo =============================================================================
echo INSTALLING MAVEN
echo ==============================================================================
cd /opt
# downloading maven version 3.6.2
wget https://www-eu.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
tar -xvzf apache-maven-3.6.3-bin.tar.gz
mv apache-maven-3.6.3 maven

#Installing Jenkins
echo =============================================================================
echo INSTALLING Jenkins
echo ==============================================================================


sudo wget http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo -O /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
yum -y install jenkins
echo -------------------------------------------------------------------------------------------------
echo  EXPORTING ENVIORNMENTAL VARIABLES
echo ------------------------------------------------------------------------------------------------
#echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-11.0.12.0.7-0.el8_4.x86_64" >>~/.bash_profile
echo "export M2_HOME=/opt/maven" >>~/.bash_profile
echo "export M2=/opt/maven/bin" >>~/.bash_profile
echo -----------------------------------------------------------------------------------------------
echo EXOPRTATION ENDED
echo -----------------------------------------------------------------------------------------------

service jenkins start

### Remove trailing \r character that causes the error if you editing this file on windows
#sed -i 's/\r$//'installing_jenkins_m2_java.sh

