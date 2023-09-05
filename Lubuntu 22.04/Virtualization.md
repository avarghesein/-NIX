## Optimizations

[Advanced Settings Reference](https://github.com/avarghesein/-NIX/blob/main/Lubuntu%2020.04/Virtualization/Qemu-KVM/Performance%20Optimization%20-%20Qemu-KVM%20Guests.md)

  ### 1. Configure CPU Affnity and Pinning

      <vcpu placement="static">2</vcpu>
      <iothreads>1</iothreads>
      <cputune>
        <vcpupin vcpu="0" cpuset="2"/>
        <vcpupin vcpu="1" cpuset="3"/>
        <emulatorpin cpuset="0-1"/>
        <iothreadpin iothread="1" cpuset="2-3"/>
      </cputune>
        <cpu mode="host-passthrough" check="full" migratable="on">
        <topology sockets="1" dies="1" cores="2" threads="1"/>
        <feature policy="require" name="vmx"/>
      </cpu>


  ### 2. CPU/System Tweaks for Windows Guests to Reduce CPU/System Usage

      <features>
        <acpi/>
        <apic/>
        <hyperv mode="custom">
          <relaxed state="on"/>
          <vapic state="on"/>
          <spinlocks state="on" retries="8191"/>
          <vpindex state="on"/>
          <synic state="on"/>
          <stimer state="on"/>
          <reset state="on"/>
        </hyperv>
      </features>
      <clock offset="localtime">
        <timer name="rtc" tickpolicy="catchup"/>
        <timer name="pit" tickpolicy="delay"/>
        <timer name="hpet" present="no"/>
        <timer name="hypervclock" present="yes"/>
      </clock>
  
  ### 3. VirtioFS Mounting in Windows10 Guest

  #### Host
  Add VirtioFS Device in VM Settings (Virtual Machine Manager)

    <filesystem type="mount" accessmode="passthrough">
      <driver type="virtiofs"/>
      <source dir="/media/CACHE/VIRTUALzDATA/KVM/WIN7-VPC"/>
      <target dir="WIN7-VPC"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x09" function="0x0"/>
    </filesystem>
    
    <memoryBacking>
      <source type="memfd"/>
      <access mode="shared"/>
    </memoryBacking>

  #### Guest
  1. Install WinFSP
  2. Install [Virtio Win Drivers for Windows Guests](https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso).
  3. Setup the VirtioFS Service to Start at System Boot
     
  [Reference](https://virtio-fs.gitlab.io/howto-windows.html)


 ### 4. VirtioFS Mounting in Ubuntu Guest

  #### Host
  Add VirtioFS Device in VM Settings (Virtual Machine Manager)
  
  NB: virtio-9p driver with "mapped" accessmode, will be most reliable in terms of file/folder permission settings with guest
  (specifically chown commands from guest), compared to "passthrough" mode or virtiofs driver with "passthrough" mode (though 
  the latter is much faster).

    <filesystem type="mount" accessmode="mapped">
        <driver type="path" wrpolicy="immediate"/>
        <source dir="/media/DATA/VIRTUALzDATA/KVM/LINUX-VPC"/>
        <target dir="VPC-DATA"/>
        <address type="pci" domain="0x0000" bus="0x00" slot="0x0d" function="0x0"/>
    </filesystem>
    
    <memoryBacking>
      <source type="memfd"/>
      <access mode="shared"/>
    </memoryBacking>

  #### Guest
  1. Load the following modules through /etc/modules

    loop
    virtio
    9p
    9pnet
    9pnet_virtio
     
  2. In /etc/fstab, mount the VirtioFS mount using 9p driver

    VPC-DATA    /media/VPC-DATA    9p    trans=virtio,rw,version=9p2000.L    0    0

  Or through command line

    sudo mount -t 9p -otrans=virtio,rw,version=9p2000.L  VPC-DATA /media/VPC-DATA

  
