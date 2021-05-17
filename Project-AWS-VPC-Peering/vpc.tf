resource "aws_vpc" "my_vpc" {
  cidr_block       = var.cidr_block_vpc
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = "${var.prefix} my_vpc"
    Department = "Commerce"
    Created_by = "DD"
  }
}