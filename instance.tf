resource "aws_instance" "web" {
  ami             = var.ami
  instance_type   = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_1.id]
#   security_groups = [aws_security_groups.sg_1.id]
  subnet_id       = aws_subnet.public-subnet_1.id
  key_name        = "my_laptop_key"
  
  tags = {
    Name = "${var.prefix} my_ec2"
  }
}