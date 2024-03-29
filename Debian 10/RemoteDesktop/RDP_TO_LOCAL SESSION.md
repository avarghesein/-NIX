# Option1 (Use x11vnc with XRDP)

## Install xrdp

## Install x11vnc

    sudo apt install x11vnc

## Piggyback xrdp to x11vnc

Edit /etc/xrdp/xrdp.ini, and add the below lines.

    [RDP-LOCAL]
    name=LOCAL-SESSION
    lib=libvnc.so
    ip=127.0.0.1
    port=5900
    username=ask
    password=ask

[Reference](https://github.com/neutrinolabs/xrdp/issues/960)

## Setup x11vnc to run with Login Screen (lightdm)

Create /etc/systemd/system/RDP-VNC.service, with below content

    [Unit]
    Description=RDP-VNC
    After=display-manager.service

    [Service]
    Type=simple
    User=lightdm
    ExecStart=/usr/bin/x11vnc -display :0 -forever -loop -noxdamage -repeat -rfbport 5900 -safer -shared -xkb -solid "darkblue" -speeds lan -overlay -localhost     
    Restart=always
    RestartSec=3

    [Install]
    WantedBy=graphical.target


[Reference](https://unix.stackexchange.com/questions/653221/how-can-i-set-up-x11vnc-to-start-on-boot-with-lightdm)

Now reload systemd daemon, and enable the service.

    sudo systemctl daemon-reload
    sudo systemctl enable RDP-VNC.service
    sudo systemctl start RDP-VNC.service
    sudo systemctl status RDP-VNC.service
    sudo systemctl restart xrdp

[x11vnc How To](https://wiki.archlinux.org/title/x11vnc#Lightdm)

[x11vnc commandline reference](https://linux.die.net/man/1/x11vnc)

# Option2 (Use xpra with XRDP)

## Install xpra

[Reference](https://github.com/Xpra-org/xpra/blob/master/docs/Usage/README.md)

## Start XPRA server from the Local Desktop Session

        xpra shadow --no-clipboard
   
   [Reference](https://github.com/Xpra-org/xpra/issues/823)
   
## From Within Remote XRDP Session (2nd Session), Connect to XPRA Server on Display:0 (Local Desktop Session)

        xpra attach :0
   
   NOTE: Use SHIFT+F11 for Toggling Full Screen
  
   [Reference](https://github.com/Xpra-org/xpra/issues/972)
