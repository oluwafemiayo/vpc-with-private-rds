terraform {
  required_providers {
    aws = {
      version = "= 4.62.0"
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}