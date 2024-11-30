
# Vaultwarden using Ansible

## Installation

Install the role from Ansible Galaxy:

```bash
ansible-galaxy role search --guerzon
ansible-galaxy role install guerzon.vaultwarden
```

Run the playbook:

```yaml
---
- hosts: all
  vars:
    domain: "https://vaultwarden.sreafterhours.io"
    rocket_port: 8080
    data_folder: "/srv/data"
  roles:
    - guerzon.vaultwarden
```
