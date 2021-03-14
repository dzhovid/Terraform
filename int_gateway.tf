resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_ig"
    Department = "Commerce"
    Created_by = "DD"
  }
}