# Structure defines the vms that get created. 
# Currently it represents a cluster with 1 system node and 2 worker nodes.
locals {
  vms = [
    {
      name     = "vm"
      cores     = 4
      memory    = 8192
      disk_size = "35G"
    }
  ]
}

variable "proxmox_host" {
  default = "pve"
}

# The name of your template
variable "proxmox_template_name" {
  default = "ubuntu2404-ansible"
}

# the storage you want to use. Probably not local. 
variable "proxmox_storage" {
  default = "local-lvm"
}


resource "random_id" "hash" {
  byte_length = 4
  keepers = {
    # Generate a new id when this value changes
    trigger = "${timestamp()}"
  }
}

# resource is formatted to be "[type]" "[entity_name]" so in this case
# we are looking to create a proxmox_vm_qemu entity named test_server
resource "proxmox_vm_qemu" "vms" {
  for_each = {
    for node in local.vms : node.name => node
  }

  name = "${terraform.workspace}-${random_id.hash.hex}" #count.index starts at 0, so + 1 means this VM will be named test-vm-1 in proxmox
  # this now reaches out to the vars file. I could've also used this var above in the pm_api_url setting but wanted to spell it out up there. target_node is different than api_url. target_node is which node hosts the template and thus also which node will host the new VM. it can be different than the host you use to communicate with the API. the variable contains the contents "prox-1u"
  target_node = var.proxmox_host
  clone       = var.proxmox_template_name
  full_clone  = true # clone will not be tied to template 
  agent       = 1    # guest agent needed to get ip address
  os_type     = "ubuntu"
  balloon     = 0
  bios        = "seabios"
  cores       = each.value.cores
  sockets     = 1
  cpu         = "host"
  memory      = each.value.memory
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"
  disk {
    slot    = 0
    size    = each.value.disk_size
    type    = "scsi"
    storage = var.proxmox_storage
    ssd     = 1
  }

  # Network hardware
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  timeouts {
    create = "6m"
    delete = "6m"
  }
}

output "vm_ip_addresses" {
  value = {
    for vm_name, vm in proxmox_vm_qemu.vms :
    vm_name => vm.default_ipv4_address
  }
}
