#!/bin/bash
echo "using no subscription repos~!"
deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription 
# Install guest agent
apt update
apt install qemu-guest-agent cpufrequtils

# todo role need storage access?

# setup powerstate
# check for existing powerstate
read -r -p 'Set powerstate default is ondemand(ondemand|performance|powersave): ' pstate
if [[ -z "{$pstate}" ||  =~ ^\(powersave|performance|ondemand\) ]]
then
    echo "powerstate must be a valid value (ondemand|performance|powersave)"
    exit 0
else
    echo "@reboot  root  echo "$pstate" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor" >> /etc/crontab
fi

# set hault timer
echo 50000 > /sys/module/kvm/parameter/halt_poll_ns

# enable io thread. 
-drive if=none,id=drive0,file=$blk_dev,format=raw,cache=none,aio=native \

-device virtio-blk-pci,num-queues=4,drive=drive0 \

# intel xeon 3rd gen or newer
echo 8 > /sys/devices/system/node/node0/hugepages/hugepages-1048576kB/nr_hugepages

# handle large pages
mkdir /dev/hugepage1G

mount -t hugetlbfs -o pagesize=1G none /dev/hugepage1G

numactl -N 0 -m 0 qemu-system-x86_64 --enable-kvm -M q35 -smp 4 -m 4G \

-mem-path /dev/hugepage1G -hda vm.img -vnc :2
