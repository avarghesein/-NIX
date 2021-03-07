## Simulate Raspberry Pi2 environment with Qemu.

Working Command: It uses an existing Bridge on the host and will benefit dynamic DHCP and DNS available in the network.
Network connectvity & Internet access will be avaiable inside the RPi2 simulated machine.

        sudo qemu-system-arm \
        -M versatilepb \
        -cpu arm1176 \
        -m 256 \
        -drive "file=/media/TMP-DSK/RPi2/2019-09-26-raspbian-buster-lite.img,if=none,index=0,media=disk,format=raw,id=disk0" \
        -device "virtio-blk-pci,drive=disk0,disable-modern=on,disable-legacy=off" \
        -net nic,macaddr=00:16:3e:00:00:01 -net bridge,name=br0\
        -dtb /media/TMP-DSK/RPi2/versatile-pb-buster-5.4.51.dtb \
        -kernel /media/TMP-DSK/RPi2/kernel-qemu-5.4.51-buster \
        -append 'root=/dev/vda2 panic=1' \
        -no-reboot -serial stdio

Or use the SD card directly (sdc is your SD Card, connected to your system)

        -drive "file=/media/sdc,...
  
[Qemu RPI Kernel](https://github.com/dhruvvyas90/qemu-rpi-kernel)

[Qemu ARM command Options](https://manpages.debian.org/testing/qemu-system-arm/qemu-system-arm.1.en.html)

[Working Network Card, Use NIC Options](https://www.raspberrypi.org/forums/viewtopic.php?t=163036)

## Booting from an External USB Drive/SSD

DD the SD Card to the new USB/SSD. Update the cmdline.txt in the Boot Partition of SD card to point to the rootfs partition of the new USB/SSD.
Below sample uses Qemu emulator (inside a KVM VM, used for testing purpose) for testing such a change. 

/dev/sda, is the actual SD Card, passed as a USB Host Passthrough Device to the KVM VM. /dev/vdd is the simulated SSD/USB (of 100G size), as a QCow2 image, attached to the KVM VM. Once the test passes, QCow2 image will be DDed to the actual SSD/USB.

    sudo qemu-system-arm \
    -M versatilepb \
    -cpu arm1176 \
    -m 256 \
    -net nic,macaddr=00:16:3e:00:00:01 -net bridge,name=br0\
    -drive "file=/dev/sda,if=none,index=0,media=disk,format=raw,id=disk0" \
    -device "virtio-blk-pci,drive=disk0,disable-modern=on,disable-legacy=off" \
    -drive "file=/dev/vdd,if=none,index=1,media=disk,format=raw,id=disk1" \
    -device "virtio-blk-pci,drive=disk1,disable-modern=on,disable-legacy=off" \
    -dtb /media/TMP-DSK/RPi2/versatile-pb-buster-5.4.51.dtb \
    -kernel /media/TMP-DSK/RPi2/kernel-qemu-5.4.51-buster \
    -append 'root=/dev/vdb2 panic=1' \
    -no-reboot -serial stdio

