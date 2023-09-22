## Ensure User has been in right Groups
## Esnure Display Manager has been unlinked from Pulse Sink During Remote Sessions
e.g. 

    $ UnlinkPulseSinkFromDM.sh "lightdm"
    $ LinkPulseSinkWithRemoteSession.sh "lightdm"
        
[Reference](https://github.com/avarghesein/-NIX/blob/main/Lubuntu%2022.04/BluetoothAudioWithRemoteSession.md)

## Configure XRDP Connect to Local Desktop Session Through X11VNC

Make XRDP to connect to Local Desktop through X11VNC. Refer [this article for implementation](https://github.com/avarghesein/-NIX/blob/main/Debian%2010/RemoteDesktop/RDP_TO_LOCAL%20SESSION.md#setup-x11vnc-to-run-with-login-screen-lightdm)

This will make the User to login to Local Desktop, Which have the privilage to enable Sound Cards in Pulse Audio

NOTE: If you're using RaspberryPi OS 64bit (Bullseye), You've to downgrade "libvnc.so" module to (0.9.12) in XRDP Package.

[download](http://ports.ubuntu.com/pool/universe/x/xrdp/xrdp_0.9.12-1_arm64.deb)

[xrdp package](https://ubuntu.pkgs.org/20.04/ubuntu-universe-arm64/xrdp_0.9.12-1_arm64.deb.html)

[reference](https://github.com/clearlinux/distribution/issues/2447)

## Set Custom Screen Resolution in RDP Sessions

[Reference](https://forums.raspberrypi.com/viewtopic.php?t=284866&start=25)

Sample

    pi@RPi4-HOME:~ $ cvt 1360 768 60
    # 1360x768 59.80 Hz (CVT) hsync: 47.72 kHz; pclk: 84.75 MHz
    Modeline "1360x768_60.00"   84.75  1360 1432 1568 1776  768 771 781 798 -hsync +vsync

Add the same in .profile, startup script

    xrandr --newmode "1360x768"   84.75  1360 1432 1568 1776  768 771 781 798 -hsync +vsync && xrandr --addmode HDMI-1 1360x768 && xrandr --output HDMI-1 --mode "1360x768"
