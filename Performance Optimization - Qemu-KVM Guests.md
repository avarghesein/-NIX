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
