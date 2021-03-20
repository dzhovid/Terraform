terraform {
  backend "s3" {
    bucket = "rutland-david-for-terraform-backend-bucket"
    key    = "tfstate/module-session.tfstate"
    region = "us-east-1"
  }
}