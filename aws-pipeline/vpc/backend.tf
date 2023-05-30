#below is the configuration for backend storing tf file
terraform {
  backend "s3" {
    bucket = "tf-state-file-terraform"
    key    = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}
