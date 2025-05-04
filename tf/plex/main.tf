# Structure defines the vms that get created. 
# Currently it represents a cluster with 1 system node and 2 worker nodes.
locals {
  vms = [
    {
      name      = "plex"
      cores     =  3
      memory    = 5120
      disk_size = "28G"
    }
  ]
}

variable "proxmox_host" {
  default = "pve"
}

# The name of your template
variable "proxmox_template_name" {
  default = "ubuntu2204-ansible"
}

# the storage you want to use. Probably not local. 
variable "proxmox_storage" {
  default = "local-lvm"
}

# resource is formatted to be "[type]" "[entity_name]" so in this case
# we are looking to create a proxmox_vm_qemu entity named test_server
resource "proxmox_vm_qemu" "ubuntu2204-ansible" {
  for_each = {
    for node in local.vms : node.name => node
  }

  name = "${terraform.workspace}-${each.value.name}" #count.index starts at 0, so + 1 means this VM will be named test-vm-1 in proxmox
  # this now reaches out to the vars file. I could've also used this var above in the pm_api_url setting but wanted to spell it out up there. target_node is different than api_url. target_node is which node hosts the template and thus also which node will host the new VM. it can be different than the host you use to communicate with the API. the variable contains the contents "prox-1u"
  target_node = var.proxmox_host
  clone       = var.proxmox_template_name
  autostart   = true
  full_clone  = true # clone will not be tied to template 
  agent       = 1    # guest agent needed to get ip address
  os_type     = "ubuntu" # this is the os type of the template. I think this is the same as the os_type in the template
  balloon     = 0
  bios        = "seabios"
  cores       = each.value.cores
  sockets     = 1
  cpu_type    = "host"
  memory      = each.value.memory
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"
  ipconfig0   = "ip=dhcp"  

  # Disk configuration
  disk {
    slot     = "scsi0"
    size     = each.value.disk_size
    type     = "disk"
    storage  = var.proxmox_storage
  }

  disk {
    slot     = "ide2"
    type     = "cloudinit"
    storage  = "local-lvm"
  }

  vga {
    type = "serial0"
  }

  # Network hardware
  network {
    id     = 0
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