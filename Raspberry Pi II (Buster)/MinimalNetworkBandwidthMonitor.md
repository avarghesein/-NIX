## Use Darkstat, with Persistance

    sudo apt install darkstat
  

A sample config file, which contains history persistance: (/etc/darkstat/init.cfg)


    START_DARKSTAT=yes
    INTERFACE="-i eth0"
    DIR="/var/lib/darkstat"
    PORT="-p 777"
    BINDIP="-b 192.168.1.5"
    LOCAL="-l 192.168.1.0/255.255.255.0"
    DAYLOG="--daylog darkstat.log"
    DB="--import darkstat.db --export darkstat.db"


[Reference: Persistance](https://www.mail-archive.com/debian-bugs-dist@lists.debian.org/msg781866.html)
[Reference: IP Setup](https://www.unixmen.com/darkstat-web-based-network-statistics-gatherer-2/)
[Reference: More Settings](https://www.ctrl.blog/entry/fedora-darkstat.html)
