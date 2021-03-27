data "template_file" "phpconfig" {
  template = file("d:/SprintQA-DEVOPS/Terraform/Session11-WordPress/files/conf.wp-config.php")

  vars = {
    db_port = aws_db_instance.db.port
    db_host = aws_db_instance.db.address
    db_user = var.username
    db_pass = var.password
    db_name = var.name
  }
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.public_subnet.id

  depends_on = [
    aws_db_instance.db
  ]
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = true 
#   user_data = <<-EOF
#                  #!/bin/bash
#                   sudo echo "127.0.0.1 `hostname`" >> /etc/hosts
#                   sudo apt-get update -y
#                   sudo apt-get install mysql-client -y
#                   sudo apt-get install apache2 apache2-utils -y
#                   sudo apt-get install php5 -y
#                   sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-gd php5-xmlrp -y
#                   sudo apt-get install php5-mysqlnd-ms -y
#                   sudo service apache2 restart
#                   sudo wget -c http://wordpress.org/wordpress-5.1.1.tar.gz
#                   sudo tar -xzvf wordpress-5.1.1.tar.gz
#                   sleep 120
#                   sudo mkdir -p /var/www/html/
#                   sudo rsync -av wordpress/* /var/www/html/
#                   sudo chown -R www-data:www-data /var/www/html/
#                   sudo chmod -R 755 /var/www/html/
#                   sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
#                   sudo service apache2 restart
#                   sleep 120
# EOF

  tags = {
    Name = "${var.prefix}-web_server"
  }

   connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = file("~/.ssh/id_rsa")
      timeout     = "4m"
    }

  provisioner "file" {
    source      = "files/userdata.sh"
    destination = "/tmp/userdata.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/userdata.sh",
      "/tmp/userdata.sh",
    ]
  }
  provisioner "file" {
    content     = data.template_file.phpconfig.rendered
    destination = "/tmp/wp-config.php"
  }
  
  provisioner "remote-exec" {
		inline = [
			"echo 'Hello World'",
      "sudo cp /tmp/wp-config.php /var/www/html/"
		]
	} 

   timeouts {
    create = "20m"
  }
}