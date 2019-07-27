# Gaia

Ovirt setup.

# Install CentOs7 minimal

Create boot medium from minimal install ISO.

Boot target host through UEFI.

Run through the Anaconda installer (GUI), you'll need a mouse because keyboard highlighting
makes it hard to properly navigate.  
This can be automated through an AutoStart configuration, and later through TheForeman.

Update system package list before continuing.
```bash
yum clean all
yum update
yum upgrade -y
reboot
```

# Disk setup

There are 3 disks available; 1 Boot SSD + 2x WD Reds for storage

Create an LVM FS on the Boot SSD. The entire disk can be automatically partitioned because
there is currently no reason to put VM related stuff onto it.

The storage disks will be put into a VDev (mirror) for ZFS to handle storage.

Setup ZFS and configuration tools
```bash
# Install the ZFS release package matching your CentOs version
yum install -y http://download.zfsonlinux.org/epel/zfs-release.el7_6.noarch.rpm
# Change the integration type to KMOD
# (https://github.com/zfsonlinux/zfs/wiki/RHEL-and-CentOS#kabi-tracking-kmod)
# -> Disable the repo ZFS
# -> Enable the repo ZFS-KMOD
vi /etc/yum.repos.d/zfs.repo
# Install zfs and tools
yum install -y zfs nfs-utils mdadm gdisk
```

Locate and prepare the disks you want to put into a pool.
```bash
# List available drives
ls -lh /dev/disk/by-id/

# Erase REPURPOSED drives before they are put into a RAID
mdadm --misc --zero-superblock /dev/<disk>
# If that doesn't work, try the partitions or the next command
zpool labelclear /dev/<device>

# Build partitions onto these disks to be used as VDev.
# Building RAIDS on RAW drives isn't desired because replacing faulted drives becomes an issue
# due to small total size differences. New drives must be equal or larger than the failed
# replaced disk, so leave like 100MB unallocated space at the end of the drive.
# 
# * Build GPT partitions that are equally sized accross all drives;
# * Start partition at first free and aligned sector;
# * (Logical sector size 512b) Subtract about 204796 sectors for a partition size where the `
#       free space equals 3.6TB;
# * Partition types should be 'Linux Raid' or 'FD00';
# * Label your partitions, which makes managing them simpler. Use, for example, zfsdata1 
gdisk /dev/<disk>
``` 

Create a Mirror VDev from both devices. This happens at creation of the desired ZPool.
```bash
modprobe zfs
# Use the partition labels for creating your pools to avoid remounting issues!
ls -lh /dev/disk/by-partlabel
# Create a pool called zfspool1 from 
# 1 Vdev that is a logical device of 2 mirrored hard drive partitions
zpool create -o ashift=12 zfspool1 mirror <partition_label> <partition_label>
# Free lunch; Enable compression on the pool
zfs set compression=on zfspool1
# Disable recording access times
zfs set atime=off zfspool1

# NOTE; Without explicitly setting a mountpoint option there is one created at root ('/')
# with the name provided to the pool.
zpool status -v
```

Create ZPool datasets
```bash
zfs create zfspool1/isos
zfs create zfspool1/host_engine
zfs create zfspool1/host_storage
```

# OVirt (SELF-HOSTED) install

[OVirt Self-Hosted engine docs]: https://www.ovirt.org/documentation/self-hosted/Self-Hosted_Engine_Guide.html
[RH Self-Hosted engine docs]: https://access.redhat.com/documentation/en-us/red_hat_virtualization/4.2/html-single/self-hosted_engine_guide/index

Setup OVirt tools

```bash
yum install -y http://resources.ovirt.org/pub/yum-repo/ovirt-release43.rpm
yum update
yum install -y ovirt-engine-appliance cockpit-ovirt-dashboard

systemctl enable cockpit.socket 
systemctl start cockpit.socket
# Port must be allowed through the firewall
firewall-cmd --add-port=9090/tcp
```

Further installation happens through Cockpit, a web-GUI, to complete installation of the OVirt engine
in VM.  
Browse to `https://<FQDN>:9090/`. 