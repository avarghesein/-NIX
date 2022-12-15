    #!/bin/sh -e
    #
    # rc.local
    #
    # This script is executed at the end of each multiuser runlevel.
    # Make sure that the script will "exit 0" on success or any other
    # value on error.
    #
    # In order to enable or disable this script just change the execution
    # bits.
    #
    # By default this script does nothing.

    #exit 0

    set +e   # Don't exit on error status

    #baseAddress=`ifconfig wlan0 | grep -Po "inet addr:\K([^ ]+)(?=\.[\d]{1,3})"` 
    #[ -z "$baseAddress" ] &&  baseAddress=`ifconfig br0 | grep -Po "inet addr:\K([^ ]+)(?=\.[\d]{1,3})"` 
    [ -z "$baseAddress" ] &&  baseAddress=`ifconfig eth0 | grep -Po "inet addr:\K([^ ]+)(?=\.[\d]{1,3})"` 
    [ -z "$baseAddress" ] &&  baseAddress="192.168.1"
    defGateway="$baseAddress.1"
    defGateway1="$baseAddress.1"
    defGateway2="$baseAddress.5"
    ipAddress="$baseAddress.3"
    vboxIpAddress="$baseAddress.250"
    ipAddressSpace="$baseAddress.0/24"

    #sudo brctl addbr br0 setfd 1 stp on
    #sudo ifconfig eth0 0.0.0.0 down
    #sudo brctl addif br0 eth0

    #sudo vboxmanage hostonlyif ipconfig vboxnet0 --ip $vboxIpAddress --netmask 255.255.255.0
    #sudo ifconfig vboxnet0 0.0.0.0 down
    #sudo brctl addif br0 vboxnet0

    sudo ifconfig eth0 up
    #sudo ifconfig vboxnet0 up
    #sudo ifconfig br0 $ipAddress netmask 255.255.255.0 hw ether `ifconfig eth0 | grep -Po "HWaddr \K(.{17,17})"` up

    ##sudo route add default gw $defGateway
    sudo route del default gw $defGateway1
    sudo route del default gw $defGateway2
    #sudo route add -net default gw $defGateway2 netmask 0.0.0.0 dev br0 metric 101
    #sudo route add -net default gw $defGateway1 netmask 0.0.0.0 dev br0 metric 100

    ##MAC VLAN for Docker to be on LAN
    sudo ip link add mac0 address 3a:ba:58:81:aa:ba link eth0 type macvlan mode bridge
    sudo ip addr add 192.168.1.40/24 dev mac0
    sudo ifconfig mac0 up
    ##IP VLAN for Docker to be on LAN
    #sudo ip link add mac0 link eth0 type ipvlan mode l2
    #sudo ip addr add 192.168.1.40/24 dev mac0
    #sudo ifconfig mac0 up

    sudo ip route flush dev eth0

    #sudo route add -net default gw $defGateway2 netmask 0.0.0.0 dev mac0 metric 101
    sudo route add -net default gw $defGateway1 netmask 0.0.0.0 dev mac0 metric 100

    sudo /sbin/iptables -P FORWARD ACCEPT
    sudo /sbin/iptables --append FORWARD --in-interface mac0 -j ACCEPT

    sudo systemctl restart smbd
    sudo systemctl restart libvirtd

    exit 0
