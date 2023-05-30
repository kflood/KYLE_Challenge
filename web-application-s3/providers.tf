terraform {
  required_version = "~> 1.4.6"

  backend "s3" {
    bucket = "challenge-webapp-s3-state"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}