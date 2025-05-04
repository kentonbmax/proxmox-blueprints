# Plex Setup

## Pre-Requisites

1. ### Required Environment Variables

export NAS_IP=<you ip nas>

2. ### Add host.ini

```

[plexservers]
remote_vm ansible_host=<your vm Ip> ansible_user=ansible ansible_ssh_private_key_file=~/.ssh/ansible

```

3. ### Python Ansible Enviornment
[Activate Virtual Environment](../../ansible/README.md)

4. ### Run playbook
> From the plex folder
`ansible-playbook -i hosts.ini main.yaml`