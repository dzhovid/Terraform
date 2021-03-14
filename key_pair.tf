resource "aws_key_pair" "my_laptop_key" {
  key_name   = "my_laptop_key"
  public_key = file("~/.ssh/id_rsa.pub")
}