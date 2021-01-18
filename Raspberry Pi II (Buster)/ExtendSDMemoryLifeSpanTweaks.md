## Disable All Logging

Since logging has been done constantly by the system, it could reduce the Life span of underlying storage (SD Card/USB Drive) through constant write operations.
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

After moving the directories, you may need to change the ownership of the new mountes, so that it will work properly
e.g.

    sudo chown -R pi:root /media/SDD/var/log
    sudo chmod -R a+rw /media/SDD/var/log


## Disable Journaling on the Filesystem

        # Enable writeback mode. Provides the best ext4 performance.
        tune2fs -o journal_data_writeback /dev/sdd1
        
        # Delete journal option
        tune2fs -O ^has_journal /dev/sdd1
        
        #Checkfiles system
        e2fsck -f /dev/sdd1

Will Decrease Read/Writes to the file system

[Reference](https://my-techno-arena.blogspot.com/2014/11/high-performing-linux-file-system-with.html?m=0)

[Reference](https://raspberrypi.stackexchange.com/questions/169/how-can-i-extend-the-life-of-my-sd-card)
