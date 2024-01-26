variable "credentials" {
  type = object({
    auth_token = string
  })
}

variable "ansible_vm" {
  type = object({
    username           = string
    initial_password   = string
    billing_account_id = number
  })
}
