ubuntu_websphere8.5
==================

Ubuntu/WebSphere 8.5 Virtual Machine creation using vagrant and chef-solo

you need to download WAS8.5 Developer 
(https://www14.software.ibm.com/webapp/iwm/web/reg/download.do?source=swerpws-wasdevim85&S_PKG=500023135&S_TACT=109J84JW&S_CMP=1550-0-119757&lang=en_US&cp=UTF-8&dlmethod=http) 
and copy to was8_5_install

the chef script expects the file to be:

was8_5_install/DEVELOPERSILAN.agent.installer.linux.gtk.x86_64.zip

The download requires an IBM ID, also for the installer this ID is needed. The chef install scripts source the user from the file was8_5_install/ibm_user.sh

The file needs to look like this and must be created before running vagrant up:

IBM_USER=<your ibm user id>
export IBM_USER
IBM_PWD=<your ibm user id password as cleartext>
export IBM_PWD

