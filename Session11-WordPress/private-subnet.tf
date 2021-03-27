resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.cidr_block_private_subnet1
  map_public_ip_on_launch = false
  availability_zone = "us-east-1b"

  tags = {
    Name = "${var.prefix}-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.cidr_block_private_subnet2
  map_public_ip_on_launch = false
  availability_zone = "us-east-1c"
  tags = {
    Name = "${var.prefix}-private-subnet-2"
  }
}