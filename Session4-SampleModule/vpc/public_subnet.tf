resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.cidr_block_subnet
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.prefix}-public-subnet_1"
  }
}