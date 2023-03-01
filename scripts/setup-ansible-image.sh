#!/bin/bash
apt install libguestfs-tools

value=$image
virt-customize -a $value --update
virt-customize -a $value --install qemu-guest-agent
virt-customize -a $value --run-command 'useradd --shell /bin/bash ansible'
virt-customize -a $value --run-command 'mkdir -p /home/ansible/.ssh'
virt-customize -a $value --ssh-inject ansible:file:/root/.ssh/ansible.pub
virt-customize -a $value --run-command 'chown -R ansible:ansible /home/ansible'
virt-customize -a $value --append-line '/etc/sudoers.d/ansible:ansible ALL=(ALL) NOPASSWD: ALL'
virt-customize -a $value --run-command 'chmod 0440 /etc/sudoers.d/ansible'
virt-customize -a $value --run-command 'chown root:root /etc/sudoers.d/ansible'
virt-customize -a $value --run-command '>/etc/machine-id' # important step so your clones get unique mac address / network details.