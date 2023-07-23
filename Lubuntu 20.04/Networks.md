
## Customize Network and IP Settings

config file /etc/netplan/01-network-manager-all.yaml

    network:
      version: 2
      renderer: NetworkManager
      
      ethernets:
        eth0:
          dhcp4: false
          dhcp6: false
          #mtu: 9000
          mtu: 1500
          
      bridges:
        br0:
          interfaces: [ eth0 ]
          addresses: [192.168.1.3/24]
          
          #gateway4: 192.168.1.5          
          #gateway4:  # unset, since we configure routes below (https://netplan.io/examples/#using-multiple-addresses-with-multiple-gateways)
          routes:
            #- to: 0.0.0.0/0
            #  via: 192.168.1.5
            #  metric: 100
              
            - to: 0.0.0.0/0
              via: 192.168.1.1
              metric: 100
            
          #mtu: 60000
          mtu: 1500
          nameservers:
            addresses: [192.168.1.1]
            #addresses: [192.168.1.41,192.168.1.5,192.168.1.1]
          parameters:
            stp: true
            forward-delay: 4
          dhcp4: no
          dhcp6: no

