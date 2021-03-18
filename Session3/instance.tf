data "aws_subnet" "existing_subnet" {
  id = var.subnet_id
}

resource "aws_instance" "web" {
  ami                    = var.ami[var.region]
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_1.id]
  subnet_id              = data.aws_subnet.existing_subnet.id
  key_name               = var.key_name
  user_data = <<-EOF
                 #!/bin/bash
                 sudo yum update -y && sudo yum install -y docker
                 sudo systemctl start docker
                 sudo usermod -aG docker ec2-user
                 docker run -p 8080:80 nginx
              EOF

  root_block_device {
    volume_size           = 16
    volume_type           = "gp2"
    delete_on_termination = true
    tags = {
      Name = "Root Volume"
    }
  }

  tags = {
    Name = "${var.prefix}-My_ec2"
  }

}

resource "aws_ebs_volume" "extra_ebs_volume" {

  availability_zone = "us-east-1f"
  size              = 20
  type              = "gp2"

  tags = {
    Name = "extra ebs volume"
  }

}

resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdh" #"/dev/xvdh"
  volume_id   = aws_ebs_volume.extra_ebs_volume.id
  instance_id = aws_instance.web.id
}