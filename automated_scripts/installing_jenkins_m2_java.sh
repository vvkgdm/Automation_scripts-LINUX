#!/bin/bash
yum install updates -y
#Installing OpenJDK 
yum -y install java-1.8.0-openjdk

#Installing MAVEN
cd /opt
# downloading maven version 3.6.0
wget http://mirrors.estointernet.in/apache/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz
tar -xvzf apache-maven-3.6.1-bin.tar.gz

#Installing Jenkins

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins
service jenkins start
