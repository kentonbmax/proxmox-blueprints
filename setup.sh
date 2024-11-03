#!/bin/bash

echo "***_____------\ Welcome to Proxmox Ansible Setup /------______**" 
    read -r -p 'Enter Ansible pub key?: ' key
    if ! [ -z "${key}" ]
    then
        echo "$key" > ~/.ssh/ansible.pub
        echo "Ansible pub setup."
    fi
fi


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



