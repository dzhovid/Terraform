terraform {
  backend "s3" {
    bucket = "rutland-david-for-terraform-backend-bucket"
    key    = "tfstate/session5-1.tfstate"
    region = "us-east-1"
  }
}