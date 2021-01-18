## Disable All Logging

Since logging has been done constantly by the system, it could reduce the Life span through constant write operations.
Disabling the same, could greatly improve the Life Span of SD Card and improve system performance

    sudo service rsyslog stop
    sudo systemctl disable rsyslog
    sudo systemctl stop syslog.socket
    sudo systemctl disable syslog.socket

[Reference](https://stackoverflow.com/questions/17358499/linux-how-to-disable-all-log)

[Reference](https://askubuntu.com/questions/861546/disable-all-logging-in-ubuntu-server)


## Move & Mount Major System/Install Directories to a Seperte External USB Drive

Sample entries from /etc/fstab

    #/dev/sda7
    UUID=fba8ff0e-278f-4624-9080-9d090080e9ff  /media/SDD  ext4  defaults,data=writeback,noatime,nodiratime 0 0

    /media/SDD/TMP /tmp    none    bind    0    0
    /media/SDD/var/cache /var/cache   none    bind    0    0
    /media/SDD/home /home    none    bind    0    0
    /media/SDD/var/log /var/log    none    bind    0    0
    /media/SDD/var/lib/docker /var/lib/docker    none    bind    0    0
    /media/SDD/var/lib/ntopng /var/lib/ntopng   none    bind    0    0
    /media/SDD/var/lib/vnstat /var/lib/vnstat   none    bind    0    0
    /media/SDD/var/lib/mysql /var/lib/mysql   none    bind    0    0
