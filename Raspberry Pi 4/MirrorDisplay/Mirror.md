## Update boot/config.txt

    dtoverlay=vc4-kms-v3d
    max_framebuffers=2
    hdmi_force_hotplug:0=1
    hdmi_force_hotplug:1=1
    hdmi_drive=2
    hdmi_ignore_edid=0xa5000080
    disable_overscan=1

[Reference](https://forums.raspberrypi.com/viewtopic.php?t=311989)

[Sample Config](https://gist.github.com/donrestarone/5edfee56f2da086bc173c25b3d6fb225)

[Multiple Framebuffers](https://forums.raspberrypi.com/viewtopic.php?t=256469)


## Update ~/.profile

    xrandr --newmode "1360x768" 84.75  1360 1432 1568 1776  768 771 781 798 -hsync +vsync
    xrandr --addmode HDMI-1 1360x768
    xrandr --addmode HDMI-2 1360x768
    xrandr --output HDMI-1 --mode 1360x768
    xrandr --output HDMI-2 --mode 1360x768
    xrandr --output HDMI-2 --same-as HDMI-1
