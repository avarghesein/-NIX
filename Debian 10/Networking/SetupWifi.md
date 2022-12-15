## Add Wifi Interface to /etc/network/interfaces file

If you need to configure multiple access points, configure [mapping](https://unix.stackexchange.com/questions/367277/configure-wireless-interface-for-multiple-locations)

There is an existing Bug in Debian Buster, which may cause the [wpa_supplicant based configuration fail](https://github.com/mfruba/kernel/issues/1)

We could use the below configuration, to make a wifi-dongle work.

    allow-hotplug wlan0
    iface wlan0 inet dhcp
            wpa-ssid "Your-SSID"
            wpa-psk You-PSK

## Add Bridging and Other Configuration to /etc/rc.local file

    #!/bin/sh -e
    #exit 0

    set +e   # Don't exit on error status

    wlan=`ifconfig | grep wlan0`

    [ "$wlan" ] && baseAddress=`ifconfig wlan0 | grep -Po "inet addr:\K([^ ]+)(?=\.[\d]{1,3})"` 
    [ -z "$baseAddress" ] &&  baseAddress=`ifconfig br0 | grep -Po "inet addr:\K([^ ]+)(?=\.[\d]{1,3})"` 
    [ -z "$baseAddress" ] &&  baseAddress=`ifconfig eth0 | grep -Po "inet addr:\K([^ ]+)(?=\.[\d]{1,3})"` 
    [ -z "$baseAddress" ] &&  baseAddress="192.168.1"
    defGateway="$baseAddress.1"
    defGateway1="$baseAddress.1"
    defGateway2="$baseAddress.5"
    ipAddress="$baseAddress.3"
    vboxIpAddress="$baseAddress.250"
    ipAddressSpace="$baseAddress.0/24"

    sudo brctl addbr br0 setfd 1 stp on
    sudo ifconfig eth0 0.0.0.0 down
    sudo brctl addif br0 eth0

    sudo ifconfig eth0 up
    sudo ifconfig br0 $ipAddress netmask 255.255.255.0 hw ether `ifconfig eth0 | grep -Po "HWaddr \K(.{17,17})"` up

    [ -z "$wlan" ] && sudo route add default gw $defGateway

    sudo ip route flush dev eth0
    [ "$wlan" ] && sudo ip link set wlan0 up

    sudo /sbin/iptables -P FORWARD ACCEPT
    sudo /sbin/iptables --append FORWARD --in-interface br0 -j ACCEPT
    [ "$wlan" ] && sudo /sbin/iptables --table nat -A POSTROUTING -s 192.168.1.0/24 -o wlan0 -j MASQUERADE

    sudo systemctl restart smbd
    sudo systemctl restart libvirtd

    exit 0
