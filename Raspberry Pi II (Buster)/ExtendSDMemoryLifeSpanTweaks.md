## The Simpler Way (Use Solid State Drive)

[Raspberry Pi2: How To Boot From SSD](https://github.com/avarghesein/-NIX/blob/main/Raspberry%20Pi%20II%20(Buster)/BootSSD.md)

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

## Enable File System Check After Every Boot.

This will take care of any file system corruption and repair of the same, if Pi has rebooted without a notice.

Force file system check and repair, through [Kernel command line](https://raspberrypi.stackexchange.com/questions/61723/raspberry-pi-3-and-raspbian-jessie-how-to-run-fsck-at-boot).

        fsck.mode=force fsck.repair=yes 
  
e.g.

        console=serial0,115200 console=tty1 root=PARTUUID=6c586e13-02 rootfstype=ext4 elevator=deadline fsck.mode=force fsck.repair=yes rootwait

[Enable File System check on drives](https://www.linuxuprising.com/2019/05/how-to-force-fsck-filesystem.html) in /etc/fstab/ with a number greater than 0. 
The number specifies the order in which the drives have to be checked. e.g.

        PARTUUID=6c586e13-01  /boot           vfat    defaults          0       1
        PARTUUID=6c586e13-02  /               ext4    defaults,noatime,nodiratime 0 2
        #/dev/sda1
        UUID=fba8440e-278f-4624-9080-9d090080e9ce  /media/SDD  ext4  defaults,data=writeback,noatime,nodiratime 0 3


Finally enable auto file system check through command line:

        sudo tune2fs -c 1 /dev/sda1
