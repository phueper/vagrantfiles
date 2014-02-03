# -*- mode: ruby -*-
# vi: set ft=ruby :
# vi: set shiftwidth=2 tabstop=2 expandtab :
#
# Cookbook Name:: weblogic12
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
#we need maven, since i want to install the 
#weblogic server using wls-maven-plugin
package "maven" do
	action :install
end

execute "unzip maven plugin" do
  user "vagrant"
  group "vagrant"
  cwd "/home/vagrant"
  creates "/home/vagrant/wls-maven-plugin.jar.pack"
  command "unzip -j /vagrant/wls12_install/wls1212_dev.zip \"*wlserver/server/lib/wls-maven-plugin*\" \"*wlserver/server/lib/pom.xml\""
end

execute "unpack maven plugin" do
  user "vagrant"
  group "vagrant"
  cwd "/home/vagrant"
  creates "/home/vagrant/wls-maven-plugin.jar"
  command "unpack200 wls-maven-plugin.jar.pack wls-maven-plugin.jar"
end

execute "install maven plugin" do
  user "vagrant"
  group "vagrant"
  cwd "/home/vagrant"
  command "mvn install:install-file -Dfile=wls-maven-plugin.jar -DpomFile=pom.xml"
end

execute "install wls12" do
  user "vagrant"
  group "vagrant"
  cwd "/home/vagrant"
  creates "/home/vagrant/weblog12/wls12120"
  command "mvn -f/vagrant/wls12_install/pom.xml com.oracle.weblogic:wls-maven-plugin:install | tee mvn_wls_install.out.txt "
end

execute "create-domain wls12" do
  user "vagrant"
  group "vagrant"
  cwd "/home/vagrant"
  creates "/home/vagrant/weblog12/mydomain"
  command "mvn -f/vagrant/wls12_install/pom.xml com.oracle.weblogic:wls-maven-plugin:create-domain | tee mvn_wls_create-domain.out.txt"
end

#setDomainEnv has wrong JAVA_HOME
execute "fix JAVA_HOME" do
  user "vagrant"
  group "vagrant"
  cwd "/home/vagrant"
  command "sed -e 's/java-6-openjdk-amd64/java-6-openjdk-amd64\\/jre/g' -i weblogic12/mydomain/bin/setDomainEnv.sh 2>&1 | tee sed_JAVA_HOME.out.txt"
end

execute "fix permissions" do
  user "vagrant"
  group "vagrant"
  cwd "/home/vagrant"
  command "find weblogic12 -iname \"*.sh\" | xargs chmod u+x | tee chmod_ux_sh.out.txt"
end

log "wls12 installed in /home/vagrant/weblogic12, run /home/vagrant/weblogic12/mydomain/startWeblogic.sh to start"
