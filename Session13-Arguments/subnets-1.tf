# provider "aws" {
#    region = "us-east-1"
# }
# resource "aws_vpc" "my_vpc" {
#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"
#   tags = {
#     Name = "my_vpc"
#   }
# }
# locals {
#   public_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
# }

# locals {
#   private_cidrs = ["10.0.4.0/24", "10.0.5.0/24"]
# }

# resource "aws_subnet" "public_subnet" {
#   for_each = {for index, cidr in local.public_cidrs : index => cidr}
#   vpc_id = aws_vpc.my_vpc.id
#   cidr_block = each.value
#   map_public_ip_on_launch = true
#   tags = {
#     "Name" = "${each.key}-public_subnet"
#   }
# }