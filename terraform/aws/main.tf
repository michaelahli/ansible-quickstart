terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }
  }
}

provider "aws" {
  region     = var.credentials.region
  access_key = var.credentials.access_key
  secret_key = var.credentials.secret_key
}

resource "aws_instance" "ansible" {
  ami = var.ansible.ami
  instance_type = "t3.micro"
  tags = {
    Name = "ansbible"
  }
}

output "public_ip" {
  value = ["${aws_instance.ansible.*.public_ip}"]
}

