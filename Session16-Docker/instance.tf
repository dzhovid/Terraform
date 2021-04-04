

resource "aws_instance" "web" {
  ami                    = "ami-013f17f36f8b1fefb"
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_1.id]
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = var.key_name
  user_data = <<-EOF
		     #! /bin/bash
         sudo apt-get update
         sudo apt install apt-transport-https ca-certificates curl software-properties-common
         curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
         sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
         sudo apt update
         apt-cache policy docker-ce
         sudo apt install docker-ce -y 
      EOF       

  tags = {
    Name = "${var.prefix} My_ec2"
  }


}
