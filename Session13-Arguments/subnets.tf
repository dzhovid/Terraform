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
# variable "cidr_block_public" {
#   default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
# }
# variable "cidr_block_private" {
#   default = ["10.0.4.0/24", "10.0.5.0/24"]
# }

# resource "aws_subnet" "public_subnet" {
#   for_each = toset(var.cidr_block_public)
#   vpc_id = aws_vpc.my_vpc.id
#   cidr_block = each.value
#   map_public_ip_on_launch = true
#   tags = {
#     "Name" = "${each.key}-public_subnet"
#   }
# }

# resource "aws_subnet" "private_subnet" {
#   for_each = toset(var.cidr_block_private)
#   vpc_id = aws_vpc.my_vpc.id
#   cidr_block = each.value
#   map_public_ip_on_launch = false
#   tags = {
#     "Name" = "${each.key}-private_subnet"
#   }
# }