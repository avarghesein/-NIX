# High Performance Optimization : KVM - QEMU - Virtual Machine

# CPU:

## 1. Host CPU Passthrough

    <cpu mode="host-passthrough" check="full"/>
 
## 2. Adjust CPU clock settings:

To reduce high CPU usage by Qemu:

    <clock offset='localtime'>
        <timer name='hpet' present='yes'/>
        <timer name='hypervclock' present='yes'/>
    </clock>
  
[Reference](https://www.reddit.com/r/VFIO/comments/80p1q7/high_kvmqemu_cpu_utilization_when_windows_10/)

## 3. Enable VCPU Pinning.

To avoid cache misses. We've CoreI5-7400 CPU, 4 Core, 1 Thread per Core. 
Dedicated 2 Core for VM

    <vcpu placement="static">2</vcpu>
    <cputune>
        <vcpupin vcpu="0" cpuset="0"/>
        <vcpupin vcpu="1" cpuset="1"/>
    </cputune>
    
    <cpu mode="host-passthrough" check="full">
        <topology sockets="1" cores="2" threads="1"/>
    </cpu>
       
  
[Reference](https://leduccc.medium.com/improving-the-performance-of-a-windows-10-guest-on-qemu-a5b3f54d9cf5)


# Network:

## 1. Use Virtio with Vhost-net Networking.

vhost makes Guest Virtio driver directly talks to Host Network Driver (vhost)

    <interface type="bridge">
        <model type="virtio"/>
        <driver name="vhost" queues="4"/>
        ...
    </interface>
    
Queue should be equal to the Number of CPU cores available in Host

For this first load vhost driver in host
    
    sudo modprobe vhost-net

To make it permanent add it to /etc/modules

[Reference](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html-single/virtualization_tuning_and_optimization_guide/index#sect-Virtualization_Tuning_Optimization_Guide-Networking-Virtio_and_vhostnet)

## 2. Enable vhost-net zero-copy

Add a new file vhost-net.conf to /etc/modprobe.d with the following content:
    
    options vhost_net  experimental_zcopytx=1


[Reference](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-network_configuration-enabling_vhost_net_zero_copy)

# Drive:

## 1. Use Virtio with (Cache Mode: Unsafe, IO Mode: Threads)

# File System Passthrough: (From HOST to GUEST)

NOTE: Though it should provide near native performance while accessing the file system, current implementation seems slower
compared to SAMBA shares, which is the preffered one for our environment.

## 1. Add Qemu Guest Agent to the VM


    <channel type="unix">
      <source mode="bind" path="/var/lib/libvirt/qemu/channel/target/domain-1-LINUX-VPC/org.qemu.guest_agent.0"/>
      <target type="virtio" name="org.qemu.guest_agent.0" state="connected"/>
      <alias name="channel0"/>
      <address type="virtio-serial" controller="0" bus="0" port="2"/>
    </channel>

## 2. Add the HOST file system and the MAGIC STRING, which will be used by the GUEST

    <filesystem type="mount" accessmode="passthrough">
      <driver type="path" wrpolicy="immediate"/>
      <source dir="/media/Virtualz/SYSTEM"/>
      <target dir="SYSTEM"/>
      <alias name="fs2"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x0c" function="0x0"/>
    </filesystem>

## 3. Add and enable necessasry drivers in GUEST

Add these modules to /etc/modules in host. Load the module throgh modprobe, for the first time

    loop
    virtio
    9p
    9pnet
    9pnet_virtio

## 4. MOUNT the HOST filesystems in GUEST

Mount directly from commandline:

    sudo mount SYSTEM /media/SYSTEM -t 9p -o trans=virtio
    
Add to /etc/fstab, for auto mount

    SYSTEM    /media/SYSTEM    9p    trans=virtio    0    0

[Reference](https://askubuntu.com/questions/1014674/using-file-system-passthrough-with-kvm-guests)
