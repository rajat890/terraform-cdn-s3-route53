resource "aws_vpc" "tools_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name           = var.vpc_name
    Classification = "Tools"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.tools_vpc.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Public-Subnet-${var.vpc_name}"
  }
}

resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.tools_vpc.id
  cidr_block              = var.private_subnet1_cidr_block
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Private-Subnet-${var.vpc_name}"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.tools_vpc.id
  cidr_block              = var.private_subnet2_cidr_block
  availability_zone       = "us-east-1b"

  tags = {
    Name = "Private-Subnet-${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tools_vpc.id

  tags = {
    Name = "Internet-Gateway-${var.vpc_name}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "NAT-Gateway-${var.vpc_name}"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "NAT-EIP-${var.vpc_name}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.tools_vpc.id

  tags = {
    Name = "Public-RT-${var.vpc_name}"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_vpc.tools_vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

