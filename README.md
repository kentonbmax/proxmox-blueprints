# proxmox-IaC
Proxmox examples using Terraform and Ansible

## Getting Started
1. Transfer the contents of the script to your proxmox using the following:
   `wget https://raw.githubusercontent.com/kentonbmax/proxmox-IaC/main/scripts/cloud-template.sh`
   `wget https://raw.githubusercontent.com/kentonbmax/proxmox-IaC/main/scripts/setup-ansible-image.sh`
1. Give permission `chmod +x *.sh`
1. (Optional) Running Ansible
   1. Create in the home directory a 4096 rsa key for ssh in a file named ansbile `ssh-keygen -t rsa -b 4096`
1. Run `./cloud-template.sh`


## References and motivations
- [Inject Keys](https://www.cyberciti.biz/faq/how-to-add-ssh-public-key-to-qcow2-linux-cloud-images-using-virt-sysprep/)
- [Proxmox Templates](https://pve.proxmox.com/wiki/VM_Templates_and_Clones)

## Other Work
[Learn Typescript Node Templates](https://pve.proxmox.com/wiki/VM_Templates_and_Clones)
