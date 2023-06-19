#below is the configuration for backend storing tf file
terraform {
  backend "s3" {
    bucket = "tf-state-file-terraform"
    key    = "vpc-1/terraform.tfstate"
    region = "us-east-1"
  }
}
