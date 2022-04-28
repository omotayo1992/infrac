
# terraform {
#   backend "s3" {
#     bucket  = "statebubket-1"
#     key     = "mystate1"
#     region  = "us-east-1"
#     profile = "terraform-class"
#     dynamodb_table = "statelock"
#   }
# }

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.region
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
    terraformcloud = "t3.medium"
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