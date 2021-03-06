# Environment Setup

1. Expand the SD Card to the entire free space (use [raspi-config](http://cagewebdev.com/raspberry-pi-expanding-the-root-partition-of-the-sd-card/) )

2. Its better to use a second USB drive with enough capacity, for occupying major applicaions/Historic Flow Data. Use 'BIND' mounts

Sample entries from /etc/fstab

    UUID=fba8440e-278f-4624-9080-9d090080e9ce  /media/SDD  ext4  defaults,data=writeback,noatime,nodiratime 0 3

    /media/SDD/TMP /tmp    none    bind    0    0
    /media/SDD/var/cache /var/cache   none    bind    0    0
    /media/SDD/home /home    none    bind    0    0
    /media/SDD/var/log /var/log    none    bind    0    0
    /media/SDD/var/lib/docker /var/lib/docker    none    bind    0    0

    /media/SDD/var/lib/darkstat /var/lib/darkstat   none    bind    0    0
    /media/SDD/var/lib/ntopng /var/lib/ntopng   none    bind    0    0
    /media/SDD/var/lib/vnstat /var/lib/vnstat   none    bind    0    0
    /media/SDD/var/lib/mysql /var/lib/mysql   none    bind    0    0

    # a swapfile is not a swap partition, no line here
    #   use  dphys-swapfile swap[on|off]  for that



3. Use 'ncdu' to monitor disk space

Run the program using 

    sudo ncdu /

# Simple Network Monitoring (Using ['vnstat'](https://www.cyberciti.biz/faq/ubuntu-install-vnstat-console-network-traffic-monitor/) Or WhiteStat)

    sudo apt install vnstat
  
  [Use this](https://github.com/vergoh/vnstat/issues/131) guideline, if vnstat fails to create database to store historic flow data.

**NOTE**: If we need a bareminimum Network Bandwidth Monitor (WebUI with IP based tracking and Persistance of History), Use [WhiteStat](https://github.com/avarghesein/-NIX/blob/main/Raspberry%20Pi%20II%20(Buster)/MinimalNetworkBandwidthMonitor.md)

# Detailed Network Monitoring (Tracking IP Flows, Using 'ntopng')

## Prerequisite: 

Make all your [network traffic go through Pi's Network Interface](https://raspberrypi.stackexchange.com/questions/7487/pi-as-a-vpn-router-for-local-machines). 

The most simpler setup would be, make Pi, as the Default Gateway
(By updating settings on the router), and Make Pi forward all internet traffic back to Router through IP Forward Rules and Source NAT, using:

    sudo /sbin/iptables -P FORWARD ACCEPT
    sudo /sbin/iptables --table nat -A POSTROUTING -s "192.168.1.0/24" -o eth0 -j MASQUERADE


**Note:** Source Address NAT is necessary, so that response packets from Router (which are coming from Internet), will always go through Pi's Network interface, before reaching original source device, which initiated the internet traffic.

If we omit, Source NAT, response packets will be directly delivered to the Original Device by the Router, bypassing Pi's Network Interface. Which makes the Bandwidth calculation out of sync. 

If you've docker intalled, docker will populate the IP tables by it's own by rewriting any custom rules placed. Putting the below in /etc/rc.local will
[circumvent these issues](https://serverfault.com/questions/726918/how-can-add-iptables-rules-after-docker-sets-its-own-rules-on-startup):

    while ! iptables -n --list DOCKER >/dev/null 2>&1
    do
        sleep 5;
    done
    sleep 10;
    
    sudo /sbin/iptables -P FORWARD ACCEPT
    sudo /sbin/iptables --table nat -A POSTROUTING -s "192.168.1.0/24" -o eth0 -j MASQUERADE
 
 Setup the Default Gateway for Pi, as the Router IP and Then [enable IP forwarding](https://linuxconfig.org/how-to-turn-on-off-ip-forwarding-in-linux) 

**Note:** Since Pi has been using the same LAN Subnet (and ethernet interface eth0) for NAT, double bandwidth usage will be reported until, proper NET filter is applied. A possible fix has been mentioned [here](https://github.com/avarghesein/-NIX/blob/main/Raspberry%20Pi%20II%20(Buster)/MinimalNetworkBandwidthMonitor.md).

 ## Setup Packages
 
 **1. Install MySQL (Required to store Flow data history, for monthly analysis)** 
 
 Install MariaDB and [enable root login with no password](https://circuits4you.com/2018/11/28/raspberry-pi-mariadb-mysql-password-login-as-root/)
 
    sudo apt install mariadb-server
 
    
**2. Setup 'ntopng'** 

  Follow [install instructions for Pi](https://packages.ntop.org/)
  
  Check 'ntopng' working properly with 'mysql' server.
 
    sudo systemctl stop ntopng
    sudo ntopng -i eth0 -F "mysql;localhost;ntopng;flows;root;" --community
 
  If this seems working add the above commandline options in (/etc/ntopng/ntopng.conf) and start ntopng

    sudo systemctl enable ntopng
    sudo systemctl restart ntopng


