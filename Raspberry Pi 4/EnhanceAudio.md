Enhance/boost Audio (both Mic/Speakers) using Pulse Effects and PavuControl

## Add Buster Backports

Add below line to '/etc/apt/sources.list'

    deb http://deb.debian.org/debian buster-backports main

## Add GPG Keys for Buster

    sudo gpg --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC
    sudo gpg --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138    

[Ref](https://jackstromberg.com/2021/07/how-to-add-buster-backports-to-a-raspberry-pi/)

## Update Packages
    
    sudo apt update

## Install Pulse Effects & pavucontrol

    sudo apt install pulseeffects -t buster-backports
    sudo apt-get install pavucontrol


## Make Audio Level (both Output/input) up to 100% 

Open 'alsamixer' and make the changes

    alsamixer
    
## Make Volume Levels (both output/input) up to 153%

Open pavucontrol and make the changes


## Enhance the bass boost/Equalizer Settings

Open pulseeffects and make the changes
