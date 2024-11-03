#!/bin/bash

echo "***_____------\ Welcome to Proxmox Ansible Setup /------______**" 
    read -r -p 'Enter Ansible pub key?: ' key
    if ! [ -z "${key}" ]
    then
        echo "$key" > ~/.ssh/ansible.pub
        echo "Ansible pub setup."
    fi
fi


