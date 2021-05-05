## Make Pi to [Boot from SSD](https://github.com/avarghesein/-NIX/blob/main/Raspberry%20Pi%20II%20(Buster)/BootSSD.md)

Have enough storage, to keep your media files

## Setup Jellyfin (Fully OpenSource)

Run as [Docker Container](https://jellyfin.org/docs/general/administration/installing.html).

    docker run -d \
     --name jellyfin \
     --user 1003:1003 \
     --net=host \
     --mount type=bind,source=/media/SDD/jellyfin/config,target=/config \
     --mount type=bind,source=/media/SDD/jellyfin/cache,target=/cache \
     --mount type=bind,source=/media/SDD/MediaBox,target=/media \
     --restart=unless-stopped \
     jellyfin/jellyfin

Access at: http://<IP>:8096/

## Setup Plex Media Server

[Setup Link](https://www.ionos.com/digitalguide/server/configuration/raspberry-pi-plex/)

[Setup Instructions](https://pimylifeup.com/raspberry-pi-plex-server/)

[Debian 10 Tweaks Required](https://askubuntu.com/questions/766485/how-to-set-up-plexmediaserver-in-ubuntu-16-04/770661#770661)

