#!/bin/bash

# Install guest agent
apt update
apt install qemu-guest-agent

# Terraform/Ansible user
pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt"
pveum user add terraform@pve
pveum aclmod / -user terraform@pve -role TerraformProv
pveum aclmod /vms -user terraform@pve -role PVEAdmin

pveum user token add terraform@pve tftoken --privsep=0
# todo role need storage access?

# Set Power State
echo "@reboot  root  echo "powersave" | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor" >> /etc/crontab
