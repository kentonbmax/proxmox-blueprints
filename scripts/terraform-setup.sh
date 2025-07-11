#!/bin/bash

echo "Setting up terraform role."
# Terraform/Ansible user
pveum role modify TerraformProv -privs "Datastore.AllocateSpace Datastore.AllocateTemplate Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"
pveum user add terraform@pve
pveum aclmod / -user terraform@pve -role TerraformProv
pveum aclmod /vms -user terraform@pve -role PVEAdmin
pveum acl modify / -user terraform@pve -role PVESDNUser

pveum user token add terraform@pve tftoken --privsep=0