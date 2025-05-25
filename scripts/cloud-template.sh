#!/bin/bash

image=https://cloud-images.ubuntu.com/nobel/current/nobel-server-cloudimg-amd64.img

mkdir images

# no clobber
wget -nc -p images $image

value=images/$(basename $image)

echo "setting up $value"

apt install --assume-yes qemu-utils 
apt install --assume-yes --no-install-recommends --no-install-suggests libguestfs-tools 

# resize to something usable
echo 'resizing image to 8gig'
qemu-img resize $value 8g

virt-customize -a $value --update
virt-customize -a $value --install qemu-guest-agent

# configure ansible?
echo "----------------------------------"
echo "Note - you must setup your ansible pub first."
read -r -p 'Setup template with Asible? (y|n): ' ansb
if [[ $ansb == 'y' ]]
then
    source "ansible-image.sh"
fi

# we might be on different storage types
read -r -p 'Storage Type? (local-zfs|local-lvm|enter_yours): ' storage_type
echo 'You set storage type: ' $storage_type

full_storage=$storage_type


# Create the VM
# Reg: https://pve.proxmox.com/pve-docs/qm.1.html
qm create 9001 --memory 2048 --name ubuntu2404-ansible --net0 virtio,bridge=vmbr0
qm importdisk 9001 $value $full_storage
# Configure the VM
qm set 9001 --scsihw virtio-scsi-pci --scsi0 $full_storage:vm-9001-disk-0
qm set 9001 --ide2 $full_storage:cloudinit
qm set 9001 --boot c --bootdisk scsi0
qm set 9001 --serial0 socket --vga serial0

# enable guest agent 1
qm set 9001 --agent 1

# set dhcp
qm set 9001 --ipconfig0 ip=dhcp

qm set 9001 --template true

echo "Setup is complete!" 
echo "You should always test your image before you convert it to a template"