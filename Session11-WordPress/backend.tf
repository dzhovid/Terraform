terraform {
  backend "s3" {
    bucket = "rutland-david-for-terraform-backend-bucket"
    key    = "tfstate/session11-wordpress.tfstate"
    region = "us-east-1"
  }
}