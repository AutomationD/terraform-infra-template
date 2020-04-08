variable "env" {}

variable "prefix" {}

variable "aws_profile" {}

variable "aws_region" {
  default = "us-east-1"
}

variable "ssh_public_key" {
  type = string
}

variable "ec2_key_pair_name" {}
