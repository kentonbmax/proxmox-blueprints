<figure>
  <img
  src="assets/proxmos.png"
  alt="ProxMox IaC">
  <figcaption>MDN Logo</figcaption>
</figure>

# Proxmox-IaC
Create ProxMox VM templates from Cloud Images and use terraform to replicate. 

# Goals
- Infrastructure as Code
- Build more, rely less on UI.
- Ease of use. 

## Getting Started
> The scripts in the Scripts folder are designed to run from the proxmox shell.
1. Grab your ansible ssh public key. Put it in a file, `~/.ssh/ansible.pub` on proxmox
1. Transfer the contents of the script to your proxmox using the following:
   `wget https://raw.githubusercontent.com/kentonbmax/proxmox-IaC/main/scripts/cloud-template.sh`
   `wget https://raw.githubusercontent.com/kentonbmax/proxmox-IaC/main/scripts/setup-ansible-image.sh`
1. Give permission `chmod +x *.sh`
1. Run `./cloud-template.sh`
1. (Optional) You will be promted to setup Ansible user
   1. Create in the home directory a 4096 rsa key for ssh in a file named ansbile `ssh-keygen -t rsa -b 4096`
1. GUI - CloudInit tab set networking DHCP = true
1. Right click 9001 and convert to template. 
1. Ready to clone. See [TF Section](tf/README.md)
   1. Add [token and permissions](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs) through ProxMox UI
   
   
## References and motivations
- [Inject Keys](https://www.cyberciti.biz/faq/how-to-add-ssh-public-key-to-qcow2-linux-cloud-images-using-virt-sysprep/)
- [Proxmox Templates](https://pve.proxmox.com/wiki/VM_Templates_and_Clones)
- [ansible cloud image](https://ronamosa.io/docs/engineer/LAB/proxmox-cloudinit/)

## Other Work
[Learn Typescript Node Templates](https://learntnt.com)

