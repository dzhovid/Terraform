resource "aws_subnet" "public-subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.2.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet_1"
  }
}