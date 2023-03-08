image=https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img

# no clobber
wget -nc $image

value=$(basename $image)

qemu-img resize $value 20g
# configure ansible?
read -r -p 'Setup for Asible? (y|n): ' ansb
if [[ $ansb == 'y' ]]
then
    source "setup-ansible-image.sh"
fi

# we might be on different storage types
read -r -p 'Storage Type? (zfs|lvm): ' storage_type
echo 'You set storage type: ' $storage_type

full_storage=local-$storage_type

# Create the VM
qm create 9001 --memory 2048 --name ubuntu2204-ansible --net0 virtio,bridge=vmbr0
qm importdisk 9001 $value $full_storage
# Configure the VM
qm set 9001 --scsihw virtio-scsi-pci --scsi0 $full_storage:vm-9001-disk-0
qm set 9001 --ide2 $full_storage:cloudinit
qm set 9001 --boot c --bootdisk scsi0
qm set 9001 --serial0 socket --vga serial0
qm set 9001 --agent enabled=1
