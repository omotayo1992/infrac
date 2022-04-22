provider "aws" {
  region  = "us-east-1"
  profile = "terraform-class"
}


resource "aws_instance" "class1" {
  ami = var.ami_id
  # count         = var.instance_count 

  for_each = {
    prod        = "t3.small"
    test        = "t2.nano"
    preprod     = "t3.medium"
    sandbox     = "t2.large"
    qa          = "t2.micro"
    Development = "t3.medium"
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

# variable "instance_count" {
#   default = 5
# }

# variable "instance_type" {
#   default = each.value
# }

# variable "name" {
#   default = each.key
# }
