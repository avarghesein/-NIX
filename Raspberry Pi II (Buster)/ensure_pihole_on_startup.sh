#!/bin/sh -e
#
#add to /etc/rc.local, e.g. bash /home/pi/ensure_pihole_on_startup.sh >> /home/pi/ensure_pihole_on_startup.log

echo ">>Starting Script Instance..."

container_name="PiHole"

container=$(docker ps | grep $container_name)

if [ "$container" ]
then
	echo Container running.
	exit 0
else
	echo Container not running.
fi

c_exists=$(docker container ls -al | grep $container_name)

if [ -z "$c_exists" ]
then
	echo Container Not Exists, Creating...
	
	docker run --detach \
	--name $container_name \
	--hostname "$container_name-RPi2" \
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
	
	sleep 15
	
fi

c_running=$(docker container ls -al | grep $container_name | grep "Up")

if [ -z "$c_running" ]
then
	echo Container not up, starting...
	docker container start $container_name
	
	sleep 15
	c_running=$(docker container ls -al | grep $container_name | grep "Up")
	
	if [ -z "$c_running" ]
	then
		echo Container not, starting. removing
		docker container rm $container_name
	else
		echo Container successfully started...
	fi
	
else
	echo Container already running
fi
