terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# main aws region
provider "aws" {
  region = var.aws_region
}
