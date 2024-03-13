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
you need to create file terraform.tfvars in `terraform/:provider/terraform.tfvars` as following example:
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
terraform -chdir=terraform/:provider/ init
terraform -chdir=terraform/:provider/ plan
terraform -chdir=terraform/:provider/ apply --auto-approve
```

### Host IP
created instance's public ip can be seen as an execution output. 

### Instance Removal
In order to delete the instance after usage
```
terraform -chdir=terraform/:provider/ destroy --auto-approve
```

## Working with ansible

### Preparation

configure hosts and variables with real instance ip
```
cp hosts.example hosts
cp group_vars/aws.yaml.example group_vars/aws.yaml
cp group_vars/idcloudhost.yaml.example group_vars/idcloudhost.yaml
```

### Check Inventory
you need to check if inventory has been setted up correctly using :
```
ansible-inventory -i hosts --list
```

### Ping Host Server
you need to check if ansible has been connected to your server using:
```
ansible idcloudhost -m ping -i hosts
```

### Hello World
using hello world playbook you can test ansible automation
```
ansible-playbook -i hosts playbooks/helloworld/helloworld.yaml
```

### PostgreSQL Database Management
1. install postgresql using `postgresql/install.yaml` playbook
```
ansible-playbook -i hosts playbooks/postgresql/install.yaml
```

2. create test database using `postgresql/database.yaml` playbook
```
cp playbooks/postgresql/vars.example.yaml playbooks/postgresql/vars.yaml
ansible-playbook -i hosts playbooks/postgresql/database.yaml
```

3. create test table using `postgresql/table.yaml` playbook
```
ansible-playbook -i hosts playbooks/postgresql/table.yaml
```

