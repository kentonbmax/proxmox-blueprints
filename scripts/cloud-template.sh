image=https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img

wget $image

imagename=echo $(basename $image)
echo "imagename:: $imagename"
qemu-img resize focal-server-cloudimg-amd64.img 20g
# configure ansible?
read -r -p 'Setup for Asible? (y|n): ' ansb
if $ansb -eq 'y'
then
    sh ./script.sh
fi

# Create the VM
qm create 9001 --memory 2048 --name ubuntu2204-ansible --net0 virtio,bridge=vmbr0
qm importdisk 9001 focal-server-cloudimg-amd64.img local-lvm
# Configure the VM
qm set 9001 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9001-disk-0
qm set 9001 --ide2 local-lvm:cloudinit
qm set 9001 --boot c --bootdisk scsi0
qm set 9001 --serial0 socket --vga serial0
qm set 9001 --agent enabled=1
qm unlock 9001

# Make the Template
qm template 9001