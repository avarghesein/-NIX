#### 1. Update Wifi Router (192.168.1.1), to Relay DHCP requests to RaspberryPi (192.168.1.5) using Enable DHCP Relay Option

#### 2. In Pi, Install dnsmasq ([Disable DNS](https://yulistic.gitlab.io/2018/03/configuring-dnsmasq-only-for-dhcp-server-in-ubuntu-pc/), if you already serving the same by PiHole)

#### 3. Update dnsmasq config to provide both Pi and Wifi router IPs, as multiple default gateways

### NB: This will make the clients to failover to the Router, if Pi is not available for some reason.

    dhcp-option=3,192.168.1.5,192.168.1.1

#### 4. Similarly update the DNS Option (provide both Pi and Router IPs for failover)

    dhcp-option=6,192.168.1.5,192.168.1.1,192.168.1.41
    
