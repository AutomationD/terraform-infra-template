provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
  version = "~> 2.40"
}

resource "aws_key_pair" "root" {
  key_name   = var.ec2_key_pair_name
  public_key = var.ssh_public_key
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = "${var.env}-vpc"

  cidr = "10.10.0.0/16"

  azs = [
    "us-east-1a",
  ]
  public_subnets = [
    "10.10.10.0/23",
  ]
  manage_default_network_acl = true

  tags = {
    Terraform = "true"
    Env       = var.env
  }
}

data "aws_ami" "ubuntu_bionic" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}
