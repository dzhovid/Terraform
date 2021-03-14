resource "aws_subnet" "public-subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.cidr_block_subnet
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "public-subnet_1"
  }
}