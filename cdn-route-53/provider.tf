# Terraform Block
terraform {
  required_version = "~> 1.1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.8.0"
    }
  }
}

# provider details
provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}
