## Use Cubic to create Custom Live CD for Ubuntu.

Install packages to customize

For accessing internet inside chroot, use below commands on terminal

    mkdir /run/systemd/resolve/;
    echo "nameserver 192.168.1.1
    search network" | tee /run/systemd/resolve/resolv.conf;
    ln -sr /run/systemd/resolve/resolv.conf /run/systemd/resolve/stub-resolv.conf;

[Ref](https://askubuntu.com/questions/741753/how-to-use-cubic-to-create-a-custom-ubuntu-live-cd-image)
