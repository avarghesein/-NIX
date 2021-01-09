## Use [x11Docker](https://github.com/mviereck/x11docker)

Install 'xephyr' on host, to take advantage of Seamless Desktop Integration with 'nxagent'

    sudo apt-get install xserver-xephyr

TIPS:

By default x11Docker [always thrash changes](https://github.com/mviereck/x11docker/issues/311), when the container is shutoff.
The way around would be, create a new image out of the running container, before shutting down the container, using 'dockercommit'

    docker commit $(docker ps | grep "user" | cut -d " " -f 1) user/lxqt:version1
  
Then next time, use the newly built image with a CMD (to avoid recursive issue mentioned [here](https://github.com/mviereck/x11docker/issues/146))

    sudo x11docker --desktop --nxagent --fullscreen user/lxqt:version1 --user user  --home "startlxqt"
 
Common commands

    docker image rm user/lxqt:version1
    docker container rm id
    docker image list
    docker container list
