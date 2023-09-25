## Run The Below Script Onetime to ensure
#### 1. User has been Added to Right Groups 
#### 2. Display Manager has been Unlinked from Pulse Audio Sink in Remote Sessions


e.g. For SDDM Display Manager

    $ UnlinkPulseSinkFromDM.sh "sddm"

e.g. For LightDM Display Manager

    $ UnlinkPulseSinkFromDM.sh "lightdm"
    
#### Script: UnlinkPulseSinkFromDM.sh

    #!/bin/bash
    #UnlinkPulseSinkFromDM.sh
    
    sudo usermod -a -G lp,audio,bluetooth,netdev,pulse,pulse-access,xrdp  $USER
    
    displayManager=$1
    
    dm_home=$(grep $displayManager /etc/passwd | cut -d: -f6)
    
    sudo -u $displayManager mkdir -pv $dm_home/.config/pulse/ $dm_home/.config/systemd/user/
    
    sudo test ! -s $dm_home/.config/pulse/client.conf && printf "autospawn = no\ndaemon-binary = /bin/true\n" | \
    sudo -u $displayManager tee $dm_home/.config/pulse/client.conf
    
    sudo -u $displayManager ln -vs /dev/null $dm_home/.config/systemd/user/pulseaudio.socket
    
    sudo reboot

## During Every Remote Session, Run Below 

e.g. For SDDM Display Manager

    $ LinkPulseSinkWithRemoteSession.sh "sddm"

e.g. For LightDM Display Manager

    $ LinkPulseSinkWithRemoteSession.sh "lightdm"

#### Script: LinkPulseSinkWithRemoteSession.sh

    #!/bin/bash
    #LinkPulseSinkWithRemoteSession.sh
    
    source ./ReconnectAirDopes141.sh
    sudo kill -9 $(ps -fC pulseaudio | grep $1 | tr -s " " | cut -d " " -f 2)

#### Now Bluetooth Audio will be Available in Pulse Audio Control

#### [Reference](https://superuser.com/questions/1529322/bluetooth-sink-does-not-show-in-pulseaudio-after-successful-bluetooth-device-con)
