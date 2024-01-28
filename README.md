# Ansible Quickstart

## Installation

### Ansible
we need to install ansible via pip (Python Package Manager):
```
pip install ansible
```

## Manage server deployed in idcloudhost provider

We use terraform to automate managing our server, you can do it manually or use any preferred provisioning tools or API.

### Variables
you need to create file terraform.tfvars in `terraform/terraform.tfvars` as following example:
```
credentials = {
  auth_token = "supersecret"
}

ansible_vm = {
  username           = "user"
  initial_password   = "supersecret"
  billing_account_id = 123456789
}
```

### Instance Creation
In order to create the instance:
```
terraform -chdir=terraform/ init
terraform -chdir=terraform/ plan
terraform -chdir=terraform/ apply --auto-approve
```

### Host IP
created instance's public ip can be seen on file terraform state at `terraform/terraform.tfstate`:
```
{
    ...
    resources: [
        {
            "name": "ansible_ip",
            "instances": [
               {
                    "attributes": {
                        "address": "00.000.00.000",
                        ....
                    }
               } 
            ],
            ...
        },
        {...}
    ]
}
```

### Instance Removal
In order to delete the instance after usage
```
terraform -chdir=terraform/ destroy --auto-approve
```

## Working with ansible

### Preparation

create file `hosts` at the root directory

```
cp hosts.example hosts
```

### Check Inventory
you need to check if inventory has been setted up correctly using :
```
ansible-inventory -i hosts --list
```

### Ping Host Server
you need to check if ansible has been connected to your server using:
```
ansible idcloudhost -m ping -i hosts --ask-pass
```

### Hello World
using hello world playbook you can test ansible automation
```
ansible-playbook -i hosts playbooks/helloworld/helloworld.yaml --ask-pass
```

### PostgreSQL Database Management
1. install postgresql using `postgresql/install.yaml` playbook
```
ansible-playbook -i hosts playbooks/postgresql/install.yaml --ask-pass
```

2. create test database using `postgresql/database.yaml` playbook
```
ansible-playbook -i hosts playbooks/postgresql/database.yaml --ask-pass
```

3. create test table using `postgresql/table.yaml` playbook
```
ansible-playbook -i hosts playbooks/postgresql/table.yaml --ask-pass
```

