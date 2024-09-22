# Lab

Public repository for my personal lab environment.

Workstation: RHEL 9.4

Servers:

- kubeadm master node (Ubuntu 20.04)
- kubeadm worker node (Ubuntu 20.04)
- Vaultwarden (RHEL 9.4)
- Database (RHEL 9.4)

## Workstation

```bash
sudo dnf install python3.11
sudo dnf remove ansible-core
...
echo "alias p=poetry" >> ~/.zshrc
echo "alias prun='poetry run'" >> ~/.zshrc
echo "alias pshell='poetry shell'" >> ~/.zshrc
source ~/.zshrc
```

## Ansible
