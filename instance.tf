data "aws_ami" "latest_amazon_linux_image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
# the above part states data source and filters latest AMI of Linux machine. instead you can just provide AMI as a variable.

resource "aws_instance" "web" {
  # ami             = var.ami
  ami             = data.aws_ami.latest_amazon_linux_image.id
  instance_type   = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_1.id]
#   security_groups = [aws_security_groups.sg_1.id]
  subnet_id       = aws_subnet.public-subnet_1.id
  key_name        = "my_laptop_key"
  
  tags = {
    Name = "${var.prefix} my_ec2"
  }

#application of some operations on boot of instance (like USER DATA)
connection {
		type        = "ssh"
		host        = self.public_ip
		user        = "ec2-user"
		private_key = file("~/.ssh/id_rsa")
		# Default timeout is 5 minutes
		timeout     = "4m"
	}
	provisioner "file" {
		content     = "Hello there"
		destination = "/home/ec2-user/devops.txt"
	}
  provisioner "file" {
		source      = "./instance-ip.txt"
		destination = "/home/ec2-user/instance-ip.txt"
	}
	provisioner "local-exec" {
		command = "echo ${self.public_ip} > instance-ip1.txt"
	}
	provisioner "remote-exec" {
		inline = [
			"touch /home/ec2-user/devops-remote-exec.txt",
      "sudo yum install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd"
		]
	}
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo",
  #     "sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key",
  #     "sudo yum upgrade",
  #     "sudo yum install jenkins java-1.8.0-openjdk-devel -y",
  #     "sudo systemctl daemon-reload",
  #     "sudo systemctl start jenkins",
  #     "sudo systemctl enable jenkins"
  #   ]
  # }
}