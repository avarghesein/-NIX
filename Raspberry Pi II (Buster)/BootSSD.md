#### Clone SD Card to SSD (Use clonezilla, Disk To Disk Option)

#### Update Partition UUID and Part UUID of Partitions in the SSD to Unique values

[Ref: use fdisk](https://askubuntu.com/questions/1250224/how-to-change-partuuid)

#### Update cmdline.txt in the boot partition of SD Card, to point to the rootfs partition in the SSD
  
    By putting the Part UUID of RootFS Partition of SSD

#### Connect both SD Card and SSD (through Powered USB Hub) to RaspberryPi2 and boot the system


#### Increase the SWAP file size to a much larger size (say 8GB - 16GB)

Without worrying about read/writes reduces the life span of storage, as now the Swap file resides in your Solid State Drive (not SD Card) !

[Ref: Manage SwapFile](https://nebl.io/neblio-university/enabling-increasing-raspberry-pi-swap/)
