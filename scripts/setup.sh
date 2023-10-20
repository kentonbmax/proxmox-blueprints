#!/bin/bash

base_url=https://github.com/kentonbmax/proxmox-IaC/tree/main/scripts
# Set the current date
current_date=$(date +%Y-%m-%d)
 
# Print the current date
echo "The current date is: $current_date"


# configure ansible?
read -r -p 'Get latest scripts? (y|n): ' scrips
if [[ $scrips == 'y' ]]
then
    wget "$base_url/proxmox-setup.sh"
    wget "$base_url/cloud-template.sh"
    wget "$base_url/setup-ansible-image.sh"
fi

chmod +x *.sh

source "proxmox-setup.sh"
source "cloud-template.sh"