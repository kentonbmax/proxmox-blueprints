<figure>
  <img
  src="assets/proxmos.png"
  alt="ProxMox Blueprints">
  <figcaption>MDN Logo</figcaption>
</figure>

# Proxmox-IaC
Create ProxMox VM templates from Cloud Images and use terraform to replicate. 

# Goals
- Infrastructure as Code
- Build more, rely less on UI.
- Ease of use. 

# Hardware
- Dell Optiplex 5060 and a 5050
- Dell 7810T - The dual cpu setup and ability to accept 2400 DDR4 ram makes this a prime choice for ProxMox Hypervisor
- Z6 G4 - xeon gold

## Getting Started

### Pre-Requisits

### Setup Script
* Configure Proxmox Low Power Mode
* Add Ansible pub key
* Setup Terraform Token
* Create a VM Template
> ----------------------------------------------------------------------------
The scripts in the Scripts folder are designed to run from the proxmox shell.

1. Grab your local ansible ssh public key. Typically, `~/.ssh/ansible.pub`.
1. Download setup.sh:
   `wget https://raw.githubusercontent.com/kentonbmax/proxmox-blueprints/main/scripts/setup.sh`
1. Give permission `chmod +x *.sh`
1. Run `./setup.sh`   
   
## References and motivations
- [Inject Keys](https://www.cyberciti.biz/faq/how-to-add-ssh-public-key-to-qcow2-linux-cloud-images-using-virt-sysprep/)
- [Proxmox Templates](https://pve.proxmox.com/wiki/VM_Templates_and_Clones)
- [ansible cloud image](https://ronamosa.io/docs/engineer/LAB/proxmox-cloudinit/)

## Other Work
[Learn Typescript Node Templates](https://learntnt.com)

## Future

* ansible roles   
   * vm template
* Create iso file with semver to download all your isos. 



