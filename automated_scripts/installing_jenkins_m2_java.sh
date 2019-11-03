#!/bin/bash
yum install updates -y
#Installing OpenJDK 
yum -y install java-1.8.0-openjdk

#Installing MAVEN

mkdir /opt/maven
cd /opt/maven
# downloading maven version 3.6.0
wget http://mirrors.estointernet.in/apache/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz
tar -xvzf apache-maven-3.6.1-bin.tar.gz

#Installing Jenkins
echo JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.212.b04-1.el8_0.x86_64
M2=/opt/maven
M2_HOME=/opt/maven/bin
PATH=$PATH:$JAVA_HOME:M2:M2_HOME >> ~/.bash_profile
yum -y install wget
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins
service jenkins start
