# Terraform ProxMox

## Cloning VMs with Terraform

### Pre-Requisits 
1. Add [token and permissions](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs) through ProxMox UI
1. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Create your VM's
1. From tf directory run `terrafrorm workspace new <some state identifier>` --> this will manage your different clusters in this example by creating a different state file. 
1. From tf directory run `terraform init`
1. Run `terraform apply` review the plan and enter "yes" to create. 
1. Grab a beverage... This takes a few minutes. 
1. 