resource "aws_instance" "example_instance" {
  count         = 3
  ami           = "ami-0123456789abcdef0"
  instance_type = "t2.micro"
}

#aws_instance.example_instance[0] refers to the first EC2 instance.
#aws_instance.example_instance[1] refers to the second EC2 instance.
#aws_instance.example_instance[2] refers to the third EC2 instance.

#output "second_instance_public_ip" {
#  value = aws_instance.example_instance[1].public_ip
#}

#resource "aws_instance" "example_instance" {
#  count         = 3
#  ami           = "ami-0123456789abcdef0"
#  instance_type = "t2.micro"
#  tags = {
#    Name = "instance-${count.index}"
#  }
#}
