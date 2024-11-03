#!/bin/bash


echo "***_____------\ Welcome to Proxmox Setup /------______**" 
echo "**** Updating proxmox and install dependencies"

apt update
apt install --assume-yes qemu-utils 
apt install --assume-yes --no-install-recommends --no-install-suggests libguestfs-tools 

# ask for pub key
read -r -p 'Enter ssh pub key?: ' key
if ! [ -z "${key}" ]
then
    echo "$key" > ~/.ssh/rsa.pub
fi

# Storage type
# we might be on different storage types
read -r -p 'Storage Type? (local-zfs|local-lvm|enter_yours): ' storage_type
echo 'You set storage type: ' $storage_type

# Terraform Role
read -r -p 'Setup Terrafrom role and a token? (y|n): ' tfsetup
if [[ $tfsetup == 'y' ]]
then
    # Setup Terraform role
    echo "**** Setting up terraform role. ****"
    # Terraform/Ansible user
    pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt"
    pveum user add terraform@pve
    pveum aclmod / -user terraform@pve -role TerraformProv
    pveum aclmod /vms -user terraform@pve -role PVEAdmin
    pveum acl modify / -user terraform@pve -role PVESDNUser
fi

if if [[ $tfsetup == 'y' ]]
then
    echo "**** Grab your token and user"
    pveum user token add terraform@pve tftoken --privsep=0
fi



