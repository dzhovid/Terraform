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

  connection {
		type        = "ssh"
		host        = self.public_ip
		user        = "ec2-user"
		private_key = file("~/.ssh/id_rsa")
		# Default timeout is 5 minutes
		timeout     = "4m"
	}

    # provisioner "file" {
	# 	source      = "./instance-ip.txt"
	# 	destination = "/home/ec2-user/instance-ip.txt"
	# }
   
  provisioner "remote-exec" {
		inline = [
			"echo 'Hello World'"
		]
	}

	provisioner "local-exec" {
        command = <<EOT
           export ANSIBLE_HOST_KEY_CHECKING=False
           ansible-playbook -u ec2-user -i '${self.public_ip},' --private-key ~/.ssh/id_rsa  /d/SprintQA DEVOPS/Terraform/Session10-Terraform Ansible/provision.yml
        EOT
}

}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file(var.ssh_key_path)
}

