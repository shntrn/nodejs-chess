provider "aws" {
  region = "eu-central-1"
}

terraform {
  backend "s3" {
    bucket = "nodejs-chess-terraform-state"
    key    = "nodejschess/1st/terraform.tfstate"
    region = "eu-central-1"
  }
}