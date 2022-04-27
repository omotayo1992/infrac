
terraform {
  backend "s3" {
    bucket  = "statebubket-1"
    key     = "mystate1"
    region  = "us-east-1"
    profile = "terraform-class"
  }
}




provider "aws" {
  region  = "us-east-1"
  profile = "terraform-class"
}


resource "aws_instance" "class1" {
  ami = var.ami_id

  for_each = {
    prod           = "t3.small"
    test           = "t2.nano"
    preprod        = "t3.medium"
    sandbox        = "t2.large"
    qa             = "t2.micro"
    Development    = "t2.micro"
    toluinstance   = "t2.nano"
    loladeinstance = "t3.medium"
  }

  instance_type = each.value
  key_name      = "A4L"

  tags = {
    Name = each.key
  }
}


variable "ami_id" {
  default = "ami-03ededff12e34e59e"
}