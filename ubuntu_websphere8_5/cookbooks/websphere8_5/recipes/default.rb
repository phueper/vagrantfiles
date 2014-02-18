#
# Cookbook Name:: websphere8_5
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
#
execute "disable dash" do
	user "root"
	command "debconf-set-selections /vagrant/was8_5_install/dash_debconf ; dpkg-reconfigure -f noninteractive dash"
end

execute "unzip installer" do
  user "vagrant"
  group "vagrant"
  cwd "/home/vagrant"
  creates "/home/vagrant/was_8.5_install/userinstc"
  command "mkdir /home/vagrant/was_8.5_install/; cd /home/vagrant/was_8.5_install/; unzip /vagrant/was8_5_install/DEVELOPERSILAN.agent.installer.linux.gtk.x86_64.zip"
end

execute "saveCredential" do
  user "vagrant"
  group "vagrant"
  cwd "/home/vagrant/was_8.5_install"
  command ". /vagrant/was8_5_install/ibm_user.sh; tools/imutilsc saveCredential -userName ${IBM_USER} -userPassword ${IBM_PWD} -url http://www.ibm.com/software/repositorymanager/V85WASDeveloperILANL/repository.config"
end

execute "userinstc WAS8.5" do
  user "vagrant"
  group "vagrant"
  cwd "/home/vagrant/was_8.5_install"
  creates "/home/vagrant/IBM/WebSphere/AppServer/bin/manageprofiles.sh"
  command "./userinstc -log userinstc.log.out.txt -s -sP -acceptLicense -input /vagrant/was8_5_install/userinst.record_file 2>&1 | tee userinstc.out.txt"
end

execute "create WAS8 profile" do
  user "vagrant"
  group "vagrant"
  cwd "/home/vagrant"
  command "./IBM/WebSphere/AppServer/bin/manageprofiles.sh -create -templatePath /home/vagrant/IBM/WebSphere/AppServer/profileTemplates/default/ -profileName rplan-profile -profilePath /home/vagrant/IBM/WebSphere/AppServer/profiles/rplan-profile/ -applyPerfTuningSetting development"
end

