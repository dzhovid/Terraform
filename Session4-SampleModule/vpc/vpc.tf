resource "aws_vpc" "my_vpc" {
  cidr_block       = var.cidr_block_vpc
  instance_tenancy = "default"

  tags = {
    Name = "${var.prefix}-vpc"
  }
}