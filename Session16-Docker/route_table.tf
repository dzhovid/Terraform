resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.cidr_block_route_table
    gateway_id = aws_internet_gateway.my_ig.id
  }

  tags = {
    Name = "${var.prefix} route_table"
  }
}