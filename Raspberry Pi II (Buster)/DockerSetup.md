[Setup Reference](https://medium.com/@mattvonrohr/installing-docker-on-raspberry-pi-4-buster-afde6b0af42)

## Running a Container

    docker run --detach \
    --name PiHole \
    --hostname "PiHole-RPi2" \
    --restart always \
    --volume /etc/localtime:/etc/localtime:ro \
    --volume /home/pi/pihole/pihole:/etc/pihole \
    --volume /home/pi/pihole/dnsmasq.d:/etc/dnsmasq.d \
    --cap-add NET_ADMIN \
    --dns=127.0.0.1 \
    --dns=192.168.1.1 \
    --env "DNS1=192.168.1.1" \
    --env "DNS2=no" \
    --env "WEBPASSWORD=<pass>" \
    --env "TZ=Asia/Calcutta" \
    -p 443:443 -p 80:80 -p 53:53 -p 53:53/udp pihole/pihole:v5.0-armhf
