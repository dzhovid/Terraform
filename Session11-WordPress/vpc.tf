resource "aws_vpc" "my_vpc" {

  cidr_block       = var.cidr_block_vpc 
  instance_tenancy = var.instance_tenancy

  tags = {
    Name = "${var.prefix} main_vpc"
  }

}
resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.public_subnet.id
  allocation_id = aws_eip.eip.id

  tags = {
    Name = "${var.prefix}-nat"
  }
}

resource "aws_eip" "eip" {

  vpc = true

  tags = {
    Name = "${var.prefix}-nat-ip"
  }
}


