resource "aws_route_table" "r" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = var.cidr_block_route
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.prefix}-route_table"
  }
}

resource "aws_route_table_association" "route_associate" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.r.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.prefix}-private"
  }
}

resource "aws_route_table_association" "private1" {
  route_table_id = aws_route_table.private.id

  subnet_id = aws_subnet.private_subnet1.id
}

resource "aws_route_table_association" "private2" {
  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private_subnet2.id
}