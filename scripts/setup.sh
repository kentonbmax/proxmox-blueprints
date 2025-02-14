#!/bin/bash

override=main
if [ -n "$branch" ]; then
    override=$branch
fi

base_url=https://raw.githubusercontent.com/kentonbmax/proxmox-blueprints/$override/scripts
echo "***Using branch $branch"
# Set the current date
current_date=$(date +%Y-%m-%d)

# Print the current date
echo "The current date is: $current_date"

# pull latest scripts?
read -r -p 'Run with Ansible? (y|n): ' scripts
if [[ $scripts == 'y' ]]
then
    # grab public key
    echo "--- --- --- --- --- --- --- --- ---"
    echo "If you want to run ansible on your vms etc. create a new pub private key on your host"
    echo "--- --- --- --- --- --- --- --- ---"
    read -r -p 'Enter Ansible pub key?: ' key
    if ! [ -z "${key}" ]
    then
        echo "$key" > ~/.ssh/ansible.pub
        echo "Ansible pub setup."
    fi
fi

wget "$base_url/proxmox-setup.sh"
wget "$base_url/cloud-template.sh"
wget "$base_url/ansible-image.sh"
wget "$base_url/terraform-setup.sh"

chmod +x *.sh

# setup proxmox?
read -r -p 'Setup Terrafrom role and a token? (y|n): ' tfsetup
if [[ $tfsetup == 'y' ]]
then
    source "terraform-setup.sh"
fi

# setup proxmox?
read -r -p 'Setup Proxmox? Note - Restart required for powerstate! (y|n): ' setup
if [[ $setup == 'y' ]]
then
    source "proxmox-setup.sh"
fi

# setup cloud image for TF and Ansible?
read -r -p 'Setup Ubuntu Cloud Image Template? (y|n): ' image
if [[ $image == 'y' ]]
then
    source "cloud-template.sh"
fi
