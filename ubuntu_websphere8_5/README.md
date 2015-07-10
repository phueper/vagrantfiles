ubuntu_websphere8.5
==================

Needed vagrant plugins:

- vagrant-vbguest

Install: vagrant plugin install <plugin-name>

Ubuntu/WebSphere 8.5 Virtual Machine creation using vagrant and ansible

you need to download IBM Installation Manager 1.8.3
and copy to was8_5_install

the scriptis expect the file to be:

was8_5_install/agent.installer.linux.gtk.x86_64_1.8.3000.20150606_0047.zip

if newer versions are available, the scripts and maybe also record files need to be adapted

The download requires an IBM ID, also for the installer this ID is needed. The install scripts source the user from the file was8_5_install/ibm_user.sh

The file needs to look like this and must be created before running vagrant up:

```
IBM_USER=<your ibm user id>
export IBM_USER
IBM_PWD=<your ibm user id password as cleartext>
export IBM_PWD
```


after installation the VM must be restarted (vagrant reload), then Websphere can be started:

- login as user vagrant (default pw: vagrant), e.g. using vagrant ssh
- run: 
```
vagrant@ubuntu-was8:~$ IBM/WebSphere/AppServer/profiles/rplan-profile/bin/startServer.sh server1
```
- access admin console: https://<server_ip>:9043/ibm/console (authentication is disabled, use any username (e.g. admin)


TODO: 

apt-get update; apt-get dist-upgrade
/etc/security/limits.d/90-nofile.conf with
vagrant soft nofile 40000
vagrant hard nofile 40000


