terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.63.0"
    }
  }
}
provider "aws" {
    region = "us-west-1"
}
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
data "aws_key_pair" "search_for_key_pair" {}
resource "aws_instance" "VM" {
  count = 3
  instance_type = var.ec2_type
  ami = data.aws_ami.ubuntu.id
  key_name = data.aws_key_pair.search_for_key_pair.key_name
tags = {
  Name = "testVMs-10"
}
}

variable "ec2_type" {
  default = "t2.micro"
}
