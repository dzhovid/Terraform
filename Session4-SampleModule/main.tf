provider "aws" {
  region = var.region
}

module "myapp-vpc" {
  # source = "github.com/dzhovid/Terraform/vpc"
  source = "./vpc"
  cidr_block_vpc         = var.cidr_block_vpc
  cidr_block_subnet      = var.cidr_block_subnet
  prefix                 = var.prefix
  cidr_block_route_table = var.cidr_block_route_table
}

module "myapp-web-server" {
  # source = "github.com/dzhovid/Terraform/web-server"
  source = "./web-server"
  key_name            = var.key_name
  ssh_key_path        = var.ssh_key_path
  security_group_name = var.security_group_name
  prefix              = var.prefix
  ami                 = var.ami
  instance_type       = var.instance_type
  vpc_id              = module.myapp-vpc.my_vpc.id
  subnet              = module.myapp-vpc.subnet.id
}

