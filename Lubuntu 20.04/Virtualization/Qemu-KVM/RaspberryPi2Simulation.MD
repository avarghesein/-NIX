## Simulate Raspberry Pi2 environment with Qemu.

Working Command:

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
