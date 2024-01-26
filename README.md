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

you need to change directory to ansible's working directory:
```
cd ansible
```

and then you can proceed to create file `inventory.ini`

```
[idcloudhost]
00.000.00.000
```

### Check Inventory
you need to check if inventory has been setted up correctly using :
```
ansible-inventory -i inventory.ini --list
```

### Ping Host Server
you need to check if ansible has been connected to your server using:
```
ansible idcloudhost -m ping -i inventory.ini -u user --ask-pass
```

### Hello World
using hello world playbook you can test ansible automation
```
ansible-playbook -i inventory.ini helloworld/helloworld.yaml -u user --ask-pass
```

### PostgreSQL Database Management
1. install postgresql using `postgresql/install.yaml` playbook
you can see flag -b or --become added in following command, this because apt requiring sudo to install packages
```
ansible-playbook -i inventory.ini postgresql/install.yaml -u user --ask-pass -b
```


