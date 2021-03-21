resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.public_subnet.id

  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = true 

  tags = {
    Name = "${var.prefix}-web_server"
  }
}