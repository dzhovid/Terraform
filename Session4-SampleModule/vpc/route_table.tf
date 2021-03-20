resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.cidr_block_route_table
    gateway_id = aws_internet_gateway.my_ig.id
  }
  
  tags = {
    Name = "${var.prefix}-my_route-table"
  }
}

resource "aws_route_table_association" "table_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.my_route_table.id
}