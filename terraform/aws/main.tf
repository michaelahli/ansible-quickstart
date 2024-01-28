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

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow inbound SSH traffic"
}

resource "aws_security_group_rule" "ssh_ingress" {
  security_group_id = aws_security_group.allow_ssh.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] 
}

resource "aws_key_pair" "ansible_key" {
  key_name   = "ansible_key"
  public_key = var.credentials.public_key 
}

resource "aws_instance" "ansible" {
  ami = var.ansible.ami
  instance_type = "t3.micro"
  tags = {
    Name = "ansible"
  }
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name = aws_key_pair.ansible_key.key_name
}

output "public_ip" {
  value = ["${aws_instance.ansible.*.public_ip}"]
}

