resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.2.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "my_vpc"
    Department = "Commerce"
    Created_by = "DD"
  }
}