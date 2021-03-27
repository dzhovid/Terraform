resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.cidr_block_public_subnet
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "${var.prefix}-public-subnet"
  }
}