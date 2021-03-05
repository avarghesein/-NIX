## Transparent Network (Similar to MACVLAN)

Containers will be in the same Host LAN, and could get IP from Local DHCP Servers, or could have Static IP.

    docker network create -d transparent --subnet=192.168.1.0/24 --gateway=192.168.1.1 hostnet
    docker inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' <ContainerName>
   
Inside Container: (Set a Static IP)

    netsh interface ipv4 set address name="Ethernet" static 192.168.1.100 255.255.255.0 192.168.1.1
   
Windows Network Device ID's are of Format:

[Reference](https://forum.golangbridge.org/t/soved-gopacket-pcap-and-windows-device-names/15856/2)

[Search for "Ethernet" in HKLM:SYSTEM\CurrentControlSet\Control\Network\{4d36e972-e325-11ce-bfc1-08002be10318}](https://stackoverflow.com/questions/29913516/how-to-get-meaningful-network-interface-names-instead-of-guids-with-netifaces-un)

    "\\Device\\NPF_{1FE9112F-3223-4936-B74C-44A48D13B0BD}"

[L2 Bridges](https://techcommunity.microsoft.com/t5/networking-blog/l2bridge-container-networking/ba-p/1180923)
