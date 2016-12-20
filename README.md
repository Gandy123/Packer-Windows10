# Packer-Windows10
Just another packer build to create windows10x64 vagrant box using VirualBox provider.

The main purpose is to autiomate windows box creation, download updates and minimize disk usage as much as possible. 
The project is heavily inspired by [this repository](https://github.com/luciusbono/Packer-Windows10)
and an excelent [article](http://www.hurryupandwait.io/blog/creating-windows-base-images-for-virtualbox-and-hyper-v-using-packer-boxstarter-and-vagrant)

The build does the following:
* using existing windows10 iso
* install windows updates (using scripts/install_windows_updates.ps1). The script is called in Autounattend.xml file while packer installing windows. I've tried to call it withing packer provision but failed
* enable winrm (using scripts/setup_winrm.ps1). The script is also called in Autounattend.xml. It seems that for now this is a most convinient way to enable packer connection with a setup machine
* restart windows through packer provisioner
* install chocolatey
* install nodejs
* install windows server 2003 resource kit tools - I'm using ntrights from this package to allow services run as a user during further vagrant provisioning
* restart windows
* install guestadditions
* restart windows
* enable rdp - to enable vagrant rdp command
* enable uac - to allow vm.synced_folder for vagrant
* disable hibernate
* setup timezone
* perform windows cleanup
  * cleanup WinSxS based on [this article](https://blogs.technet.microsoft.com/askpfeplat/2015/02/09/how-to-reduce-the-size-of-the-winsxs-directory-and-free-up-disk-space-on-windows-server-2012-r2-and-windows-8-1-or-do-we-even-need-to/)
  * remove temporary directories
  * optimize c:
  * use sdelete to optimize vdi size based on [this article](http://superuser.com/questions/529149/how-to-compact-virtualboxs-vdi-file-size)

##Requirements
* window10 iso file. It can be downloaded from microsoft site, but rather tricky to find. I'm using this [repository](https://github.com/boxcutter/windows) as a reference. There are a lot of packer files there with direct donwload links.
* Packer 0.12.0
* Vagrant 1.8.6
* Oracle VM Virtual Box 5.1.4
* Git

