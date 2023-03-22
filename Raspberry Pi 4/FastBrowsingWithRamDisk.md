## Create RamDisk

Have the entires in /etc/fstab

    tmpfs /tmp tmpfs defaults,noatime,nodev,nosuid,size=100M,mode=0777 0 0
    tmpfs /media/ramdisk tmpfs defaults,noatime,nodev,nosuid,size=1000M,mode=0777 0 0

## Move Browser's (Vivaldi/Chrome) Profile and Cache folders to RamDisk

  1. Create /media/ramdisk mountpoint
  
  3. Copy Browser's profile/cache folders to RamDisk
  
    sudo rsync -ap -P /home/<user>/.cache /media/ramdisk/home/<user>/.cache
    
  4. Simlink Browser'r profile/cache folders to RamDisk
  
    mv /home/<user>/.cache /home/<user>/.cache_bkup
    sudo ln -s /media/ramdisk/home/<user>/.cache /home/<user>/.cache
  
  5. Put the Cache folder to RamDisk through Browser's Commandline
  
    Exec=/usr/bin/vivaldi-stable %U --disk-cache-dir="/media/ramdisk/"

## Persist RamDisk To Disk

Setup SystemD service, which will start on System Boot, to copy Persistant files to RamDisk.
During Shutdown, the service will copy RamDisk contents back to Persistant Disk.

[Reference](https://docs.observium.org/persistent_ramdisk/)

[Reference](https://linuxhint.com/ramdisk_ubuntu_1804/)

    ## sudo nano /lib/systemd/system/ramdisk-sync.service
    
    [Unit]
    Description=RamdiskSync
    Before=umount.target

    [Service]
    Type=oneshot
    User=abraham
    RemainAfterExit=yes
    ExecStartPre=sudo chown -Rf abraham /media/ramdisk/
    ExecStart=sudo rsync -arp -P /media/ramdisk-backup/ /media/ramdisk/
    ExecStop=sudo rsync -avrp -P --delete --recursive --force /media/ramdisk/ /media/ramdisk-backup/
    ExecReload=sudo rsync -avrp -P --delete --recursive --force /media/ramdisk/ /media/ramdisk-backup/
    ExecStopPost=sudo chown -Rf abraham /media/ramdisk-backup/

    [Install]
    WantedBy=multi-user.target

Enable, start, reload and check the status of the service

    sudo systemctl daemon-reload
    sudo systemctl enable ramdisk-sync.service
    sudo systemctl start ramdisk-sync
    sudo systemctl reload ramdisk-sync
    sudo systemctl status ramdisk-sync

Keep Persist RamDisk to Disk in every one hour through crontab entry

    1 * * * * <user>        sudo rm -rf /media/ramdisk-backup-2; sudo mv /media/ramdisk-backup /media/ramdisk-backup-2;sudo systemctl reload ramdisk-sync; 


## Keep any other Folders/Files to RamDisk, which require faster access
