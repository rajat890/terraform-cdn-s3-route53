variable "servers" {
  type = map
  default = {
    "server1" = "10.0.0.1"
    "server2" = "10.0.0.2"
    "server3" = "10.0.0.3"
  }
}

resource "aws_instance" "example_instance" {
  for_each = var.servers

  ami           = "ami-0123456789abcdef0"
  instance_type = "t2.micro"
  private_ip    = each.value
}
