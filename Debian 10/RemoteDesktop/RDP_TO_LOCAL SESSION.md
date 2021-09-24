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

    [LOCAL-SESSION]
    param=x11vnc
    param=-noxdamage 
    param=-display
    parasm=:0
    param=-safer
    param=-once

[Reference](https://github.com/neutrinolabs/xrdp/issues/960)

## Setup x11vnc to run with Login Screen (lightdm)

Create /etc/systemd/system/RDP-VNC.service, with below content

    [Unit]
    Description=RDP-VNC
    After=display-manager.service

    [Service]
    Type=simple
    User=lightdm
    ExecStart=/usr/bin/x11vnc -display :0 -forever -loop -noxdamage -repeat -rfbport 5900 -safer -shared -xkb                   
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
