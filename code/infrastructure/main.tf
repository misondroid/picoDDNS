terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "picoddns-infrastructure"
    key = "dev/terraform.tfstate"
    region = "ap-northeast-1"
    profile = "default"
  }
}

provider "aws" {
  region = "ap-northeast-1"
  profile = "default"
}