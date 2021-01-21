## Use Darkstat, with Persistance

    sudo apt install darkstat
  

A sample config file, which contains history persistance: (/etc/darkstat/init.cfg)


    START_DARKSTAT=yes
    INTERFACE="-i eth0"
    DIR="/var/lib/darkstat"
    PORT="-p 777"
    BINDIP="-b 192.168.1.5"
    LOCAL="-l 192.168.1.0/255.255.255.0"
    DAYLOG="--daylog darkstat.log"
    DB="--import darkstat.db --export darkstat.db"
    
    FILTER="not (src net 192.168.1 and dst net 192.168.1) and not (src 192.168.1.5 or dst 192.168.1.5)"


**NOTE:**  Make a special note on Filters. The first 'not' filter is to ignore all packets/size which are destined inside LAN only, which effectively counts only the incoming/outgoing packets to Intertnet/Router.

The second 'not' filter is very important to avoid double bandwidth usage reports. i.e, Without the second 'not' filter every packet destined to internet or coming from internet will be counted twice (Due to the NAT IP rule mentioned below), as every outgoing packet will first reach Pi (counted once), and Pi will forward the same packet again to router through the same eth0 interface (counted twice). This happens for incoming packets from internet as it will first reach Pi (counted once) and then to the final original device (counted twice). With the second 'not' filter, we effectively ignore all such packets targetted towards Pi, and eliminates double bandwidth usage reports. The given IP is the IP of eth0 interface Of PI (192.168.1.5)

[Reference: Persistance](https://www.mail-archive.com/debian-bugs-dist@lists.debian.org/msg781866.html)

[Reference: IP Setup](https://www.unixmen.com/darkstat-web-based-network-statistics-gatherer-2/)

[Reference: More Settings](https://www.ctrl.blog/entry/fedora-darkstat.html)


Now update IP Table Rules, to route every traffic throug Pi (Pi as the gateway)

    sudo /sbin/iptables -P FORWARD ACCEPT
    sudo /sbin/iptables --table nat -A POSTROUTING -s "192.168.1.0/24" -o eth0 -j MASQUERADE
        
Note: Source Address NAT is necessary, so that response packets from Router (which are coming from Internet), will always go through Pi's Network interface, before reaching original source device, which initiated the internet traffic.

If we omit, Source NAT, incoming packets will be directly delivered to the Original Device by the Router, bypassing Pi's Network Interface. Which makes the Bandwidth calculation out of sync.

Since the NAT rule is being applied on the same Subnet and Same interface, packets will be counted twice, which could be eliminated by setting the SRC/DST Filter for **DarkStat**.
