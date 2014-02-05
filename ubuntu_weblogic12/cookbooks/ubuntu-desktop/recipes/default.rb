#
# Cookbook Name:: ubuntu-desktop
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
#apt-get update first
#
execute "apt-get-update" do
	command "apt-get update"
	ignore_failure true
	action :run
end

package "ubuntu-desktop" do
	action :install
end
