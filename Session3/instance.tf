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
                sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
                sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
                sudo yum upgrade
                sudo yum install jenkins java-1.8.0-openjdk-devel -y
                sudo systemctl daemon-reload
                sudo systemctl start jenkins
                sudo systemctl enable jenkins
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