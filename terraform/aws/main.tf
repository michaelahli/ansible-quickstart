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

resource "aws_security_group" "ansible_security" {
  name        = "ansible_security"
  description = "Allow inbound SSH traffic"
}

resource "aws_security_group_rule" "ssh_ingress" {
  security_group_id = aws_security_group.ansible_security.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] 
}

resource "aws_security_group_rule" "outgoing_http" {
  security_group_id = aws_security_group.ansible_security.id
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "outgoing_https" {
  security_group_id = aws_security_group.ansible_security.id
  type              = "egress"
  from_port         = 443
  to_port           = 443
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
  vpc_security_group_ids = [aws_security_group.ansible_security.id]
  key_name = aws_key_pair.ansible_key.key_name
}

output "public_ip" {
  value = ["${aws_instance.ansible.*.public_ip}"]
}

