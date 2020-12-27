# Creating an External Snapshot

## Through Virsh
Below samples create three snapshots and 3 seperate external image files.
The last one is used for the running VM to make the changes.

    virsh snapshot-create-as WIN10-VPC-TEMPLATE --name 1_WIN10_PRO_X64_2020H2_CUSTOM --disk-only --atomic
    virsh snapshot-create-as WIN10-VPC-TEMPLATE --name 2_WIN10_PRO_X64_2020H2_BASESOFT --disk-only --atomic

## Through Qemu commands
Or we could directly use 'Qemu-image' commands

    qemu-img create -f qcow2 -b ./2_WIN10_PRO_X64_2020H2_BASESOFT ./3_WIN10_PRO_X64_2020H2_WIN10-VPC

Update your VM libvirt XML to reflect the same

    <disk type="file" device="disk">
      <driver name="qemu" type="qcow2" cache="unsafe" io="threads"/>
      <source file="/media/Virtualx/KVM/ABRAHAM-VPC/3_WIN10_PRO_X64_2020H2_WIN10-VPC"/>
      <backingStore type="file">
        <format type="qcow2"/>
        <source file="/media/Virtualx/KVM/DiskTemplates/WIN10/2_WIN10_PRO_X64_2020H2_BASESOFT"/>
        <backingStore type="file">
          <format type="qcow2"/>
          <source file="/media/Virtualx/KVM/DiskTemplates/WIN10/1_WIN10_PRO_X64_2020H2_CUSTOM"/>
          <backingStore type="file">
            <format type="qcow2"/>
            <source file="/media/Virtualx/KVM/DiskTemplates/WIN10/0_WIN10_PRO_X64_2020H2_BASE.qcow2"/>
            <backingStore/>
          </backingStore>
        </backingStore>
      </backingStore>
      <target dev="vda" bus="virtio"/>
      <address type="pci" domain="0x0000" bus="0x00" slot="0x03" function="0x0"/>
    </disk>
    
[Reference](https://superuser.com/questions/1210773/how-do-i-revert-to-latest-external-snapshot-in-kvm)

If we've moved the backing file, update the snapshot to point to the new parent location:

    qemu-img rebase -f qcow2 -u -b ./WIN10_PRO_X64_2020H2_BASE.qcow2  ./WIN10_PRO_X64_2020H2_CUSTOM

# Key LibVirt folders, where the XML files resides

    /etc/libvirt/qemu
    /var/lib/libvirt/qemu/snapshot

# Below are the key Qemu commands to manage disk and snapshots

[Reference](https://blog.programster.org/qemu-img-cheatsheet)

[Reference](http://www.azertech.net/content/kvm-qemu-qcow2-qemu-img-and-snapshots)

# Sample commands

    qemu-img create -c -f qcow2 ./0_DATA_WIN10_PRO_X64_2020H2.img 100G
    qemu-img convert -c -O qcow2 WIN10-VPC.qcow2 WIN10-VPC-CMPT.qcow2
    qemu-img info --backing-chain ./WIN10_PRO_X64_2020H2_CUSTOM 
    qemu-img snapshot -l WIN7-VPC-DATA-2.qcow2 
    qemu-img snapshot -d "01_BeforeSoftwareInstall" WIN7-VPC-DATA-2.qcow2
    qemu-img rebase -f qcow2 -u -b ./WIN10_PRO_X64_2020H2_BASE.qcow2  ./WIN10_PRO_X64_2020H2_CUSTOM




