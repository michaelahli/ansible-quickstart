variable "credentials" {
  type = object({
    region     = string
    access_key = string
    secret_key = string
    public_key = string
  })
}

variable "ansible" {
  type = object({
    ami = string
  })
}
