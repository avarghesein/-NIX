# Through IPVLAN (L2 Bridging)

Exposing Docker Containers directly on LAN requires setting up IPVLAN on your host network devices (e.g. eth0 or br0)

## Creating a IPVLAN docker network:

    docker network create -d ipvlan --subnet=192.168.1.0/24 --gateway=192.168.1.5 -o ipvlan_mode=l2 -o parent=br0 docker_on_lan

## Back the same using the real IPVLAN network in the Host Device (here host bridge br0 is used).

Keep the below in /etc/rc.local, so that the configuration is applied in each system startup.

    sudo ip link add mac0 link br0 type ipvlan mode l2
    sudo ip addr add 192.168.1.40/24 dev mac0
    sudo ifconfig mac0 up

You may also require below route entry, so that both Host and Containers within IPVLAN could communicate.
Applicable to Debian Buster.
[Reference](https://superuser.com/questions/349253/guest-and-host-cannot-see-each-other-using-linux-kvm-and-macvtap)

    sudo ip route flush dev br0
    sudo route add -net default gw $defGateway1 netmask 0.0.0.0 dev mac0 metric 100

## Now Create containers with IPVLAN and assign addresses from the subnet

Below example shows creating a PiHole container, directly exposed over LAN with IP 192.168.1.41


    docker run --detach \
    --name PiHole-ON-LAN \
    --hostname "PiHole-ON-LAN" \
    --restart always \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /media/Virtualy/DEBIAN-SSD-HOME/docker/user/store/pihole/pihole:/etc/pihole \
    --volume /media/Virtualy/DEBIAN-SSD-HOME/docker/user/store/pihole/dnsmasq.d:/etc/dnsmasq.d \
    --cap-add NET_ADMIN \
    --dns=127.0.0.1 \
    --dns=192.168.1.1 \
    --env "DNS1=192.168.1.1" \
    --env "DNS2=no" \
    --env "WEBPASSWORD=1234567890" \
    --env "TZ=Asia/Calcutta" \
    --network docker_on_lan \
    --ip "192.168.1.41" \
    pihole/pihole:v5.0
    
    
# Through MACVLAN

Exposing Docker Containers directly on LAN requires setting up MACVLAN on your host network devices (e.g. eth0 or br0)

## Creating a MACVLAN docker network:

    docker network create -d macvlan --subnet=192.168.1.0/24 --gateway=192.168.1.5  -o parent=br0 docker_on_lan

## Back the same using the real MACVLAN network in the Host Device (here host bridge br0 is used).

Keep the below in /etc/rc.local, so that the configuration is applied in each system startup.

    sudo ip link add mac0 link br0 type macvlan mode bridge
    sudo ip addr add 192.168.1.40/24 dev mac0
    sudo ifconfig mac0 up


## Now Create containers with MACVLAN and assign addresses from the subnet

Below example shows creating a PiHole container, directly exposed over LAN with IP 192.168.1.41


    docker run --detach \
    --name PiHole-ON-LAN \
    --hostname "PiHole-ON-LAN" \
    --restart always \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /media/Virtualy/UBUNTU-SSD-HOME/docker/user/store/pihole/pihole:/etc/pihole \
    --volume /media/Virtualy/UBUNTU-SSD-HOME/docker/user/store/pihole/dnsmasq.d:/etc/dnsmasq.d \
    --cap-add NET_ADMIN \
    --dns=127.0.0.1 \
    --dns=192.168.1.1 \
    --env "DNS1=192.168.1.1" \
    --env "DNS2=no" \
    --env "WEBPASSWORD=<your pass>" \
    --env "TZ=Asia/Calcutta" \
    --network docker_on_lan \
    --ip "192.168.1.41" \
    --mac-address "02:42:c0:a8:01:d8" \
    pihole/pihole:v5.0


[Reference MacVlan](https://collabnix.com/2-minutes-to-docker-macvlan-networking-a-beginners-guide/)

[Reference PiHole](https://gist.github.com/xirixiz/ecad37bac9a07c2a1204ab4f9a17db3c)
