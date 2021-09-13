#!/bin/bash

export LIBVIRT_DEFAULT_URI="qemu:///system"
virsh -c qemu:///system;
virsh start WIN10-DEV-VPC
#virt-manager -c qemu:///system --show-domain-console WIN10-DEV-VPC
virt-viewer --spice-disable-effects=wallpaper,animation --spice-color-depth=16 --hotkeys=toggle-fullscreen=ctrl+win+f  -a --domain-name WIN10-DEV-VPC

#Running the script as a Desktop Entry
#Sample Desktop Entry file

#[Desktop Entry]
#Encoding=UTF-8
#Type=Application
#Name=Boot WIN10-DEV-VPC
#Name[en_IN]=Boot WIN10-DEV-VPC
#Exec="/home/abraham/Desktop/Scripts/RunWin10DevVpc.sh"
#Terminal=false 
#Type=Application
#Categories=Application;
