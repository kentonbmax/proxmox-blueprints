    #!/bin/bash

    base_url=https://raw.githubusercontent.com/kentonbmax/proxmox-IaC/main/scripts/
    # Set the current date
    current_date=$(date +%Y-%m-%d)
    
    # Print the current date
    echo "The current date is: $current_date"

    # pull latest scripts?
    read -r -p 'Run with Ansible? (y|n): ' scrips
    if [[ $scrips != 'y' ]]
    then
        # grab public key
        read -r -p 'Enter Ansible pub key?: ' key
        if [ $key -n ]
        then
            echo "$key" > /root/.ssh/ansible.pub
            echo "Ansible pub setup."
            exit 1
        fi
    fi

    wget -nc "$base_url/proxmox-setup.sh"
    wget -nc "$base_url/cloud-template.sh"
    wget -nc "$base_url/setup-ansible-image.sh"

    chmod +x *.sh

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
