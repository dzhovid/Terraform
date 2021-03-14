resource "aws_instance" "web" {
  ami             = "ami-038f1ca1bd58a5790"
  instance_type   = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_1.id]
#   security_groups = [aws_security_groups.sg_1.id]
  subnet_id       = aws_subnet.public-subnet_1.id
  key_name        = "my_laptop_key"
  tags = {
    Name = "my_ec2"
  }
}