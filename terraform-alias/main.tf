resource "aws_instance" "example_instance" {
  provider              = aws.uswest1
  ami           = "ami-051ed863837a0b1b6"
  instance_type         = "t2.micro"
}

resource "aws_s3_bucket" "example_bucket" {
  provider = aws.useast1
  bucket   = "rajat-multiple-alias-testing"

}
