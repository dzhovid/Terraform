terraform {
  backend "s3" {
    bucket = "rutland-david-for-terraform-backend-bucket"
    key    = "tfstate/session10.tfstate"
    region = "us-east-1"
  }
}