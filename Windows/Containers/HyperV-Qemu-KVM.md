## Enable HyperV and Containers with Windows10 Guest

The key parameters would be synic, stimer, cpu-feature-hypervisor, **cpu-feature-vmx**, clock-hpet (performance), clock-hypervclock

    <os>
      <type arch="x86_64" machine="pc-i440fx-4.2">hvm</type>
      <boot dev="hd"/>
    </os>
    <features>
      <acpi/>
      <apic/>
      <hyperv>
        <relaxed state="on"/>
        <spinlocks state="on" retries="8191"/>
        <vpindex state="on"/>
        <synic state="on"/>
        <stimer state="on"/>
      </hyperv>
    </features>
    <cpu mode="host-passthrough" check="full">
      <feature policy="disable" name="hypervisor"/>
      <feature policy="require" name="vmx"/>
    </cpu>
    <clock offset="localtime">
      <timer name="rtc" tickpolicy="catchup"/>
      <timer name="pit" tickpolicy="delay"/>
      <timer name="hpet" present="yes"/>
      <timer name="hypervclock" present="yes"/>
    </clock>
 
 References:
 
 [Intel KVM nested Hyper-V virtualization in a Windows 10](https://www.reddit.com/r/VFIO/comments/inrlxc/intel_kvm_nested_hyperv_virtualization_in_a/)
 
 [Win10 guests high KVM host CPU usage](https://unix.stackexchange.com/questions/534155/win10-guests-high-kvm-host-cpu-usage)
 
 [High KVM/QEMU CPU utilization when Windows 10 guest is idle](https://www.reddit.com/r/VFIO/comments/80p1q7/high_kvmqemu_cpu_utilization_when_windows_10/)
