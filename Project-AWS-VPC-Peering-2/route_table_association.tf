resource "aws_route_table_association" "table_association" {
  subnet_id      = aws_subnet.public-subnet_1.id
  route_table_id = aws_route_table.my_route_table.id
}