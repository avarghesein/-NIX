#### Clone SD Card to SSD (Use clonezilla, Disk To Disk Option)

#### Update Partition UUID and Part UUID of Partitions in the SSD to Unique values

    [use fdisk](https://askubuntu.com/questions/1250224/how-to-change-partuuid)

#### Update cmdline.txt in the boot partition of SD Card, to point to the rootfs partition in the SSD
  
    By putting the Part UUID of RootFS Partition of SSD

#### Connect both SD Card and SSD to RaspberryPi2 and boot the system
