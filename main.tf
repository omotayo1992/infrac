provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

variable "access_key" {}
variable "secret_key" {}
variable "region" {}

terraform {
  cloud {
    organization = "Visual-greatness-llc"

    workspaces {
      name = "infrac"
    }
  }
}


resource "aws_instance" "class1" {
  ami             = "ami-0022f774911c1d690"
  instance_type   = "t2.micro"
  key_name        = "A4L"
  security_groups = [aws_security_group.allow_access.id]

  tags = {
    Name = "Jenkins-server"
  }
}

resource "aws_security_group" "allow_access" {
  name        = "allow_access"
  description = "Allow access inbound traffic"
  vpc_id      = "vpc-3a069347"

  ingress {
    description = "ssh from public"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http from public"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}