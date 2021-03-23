resource "aws_s3_bucket" "b" {
  bucket = "mybucket-onrutland-david-164"
  acl    = "private"
  force_destroy = true
  tags = {
    Name = "mybucket-onrutland-david-164"
  }
}

