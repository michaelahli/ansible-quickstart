terraform {
  required_providers {
    idcloudhost = {
      version = "0.1.3"
      source  = "bapung/idcloudhost"
    }
  }
}

provider "idcloudhost" {
  auth_token = var.credentials.auth_token
}

resource "idcloudhost_vm" "ansible" {
  name               = "ansible"
  os_name            = "ubuntu"
  os_version         = "20.04"
  disks              = 20
  vcpu               = 2
  memory             = 2048
  username           = var.ansible_vm.username
  initial_password   = var.ansible_vm.initial_password
  billing_account_id = var.ansible_vm.billing_account_id
  backup             = false
}

resource "idcloudhost_floating_ip" "ansible_ip" {
  name               = "ansible_ip"
  billing_account_id = var.ansible_vm.billing_account_id
  assigned_to        = idcloudhost_vm.ansible.uuid
}
