resource "aws_key_pair" "my_laptop_key" {
  key_name   = var.key_name
  public_key = file(var.ssh_key_path)
}