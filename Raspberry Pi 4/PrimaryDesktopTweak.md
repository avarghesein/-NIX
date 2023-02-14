## [Overclock CPU and GPU](https://appuals.com/overclock-raspberry-pi-4-safely/)

Edit /boot/config.txt

    #uncomment to overclock the arm. 700 MHz is the default.
    #arm_freq=800
    arm_freq=1200
    over_voltage=6 #comment if not needed
    gpu_freq=600 #comment if not needed

Watch CPU clock speed and Temperature.

    vcgencmd get_config arm_freq
    watch -n1 vcgencmd measure_clock arm
    watch -n 1 cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
    watch -n1 vcgencmd measure_temp

## [Setup ZRAM](https://haydenjames.io/raspberry-pi-performance-add-zram-kernel-parameters/)

    git clone https://github.com/foundObjects/zram-swap
    cd zram-swap
    sudo ./install.sh

Edit /etc/default/zram-swap

    _zram_fixedsize="500M"

Edit /etc/sysctl.conf 

    vm.vfs_cache_pressure=500
    vm.swappiness=100
    vm.dirty_background_ratio=1
    vm.dirty_ratio=50
