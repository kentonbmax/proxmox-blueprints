# Terraform ProxMox

## Cloning VMs with Terraform

### Pre-Requisits 
1. Add [token and permissions](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs) through ProxMox UI - Note permissions must be added to the token directly. 
1. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
1. There are 3 inputs to this Terraform Example. To use as Environment variables pre-pend with "TF_VAR_"
  1. proxmox_host --> pve
  1. proxmox_template_name --> ubuntu2204-ansible
  1. proxmox_storage --> local-lvm


### Create your VM's
1. From tf directory run `terrafrorm workspace new <some state identifier>` --> this will manage your different clusters in this example by creating a different state file. 
1. From tf directory run `terraform init`
1. Run `terraform apply` review the plan and enter "yes" to create. 
1. Grab a beverage... This takes a few minutes. 