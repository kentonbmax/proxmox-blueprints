# proxmox-IaC
Proxmox examples using Terraform and Ansible

## Getting Started
1. Grab your ansible ssh public key. Put it in a file, `~/.ssh/ansible.pub` on proxmox
1. Transfer the contents of the script to your proxmox using the following:
   `wget https://raw.githubusercontent.com/kentonbmax/proxmox-IaC/main/scripts/cloud-template.sh`
   `wget https://raw.githubusercontent.com/kentonbmax/proxmox-IaC/main/scripts/setup-ansible-image.sh`
1. Give permission `chmod +x *.sh`
1. Run `./cloud-template.sh`

## References and motivations
- [Inject Keys](https://www.cyberciti.biz/faq/how-to-add-ssh-public-key-to-qcow2-linux-cloud-images-using-virt-sysprep/)
- [Proxmox Templates](https://pve.proxmox.com/wiki/VM_Templates_and_Clones)
- [ansible cloud image](https://ronamosa.io/docs/engineer/LAB/proxmox-cloudinit/)

## Other Work
[Learn Typescript Node Templates](https://learntnt.com)