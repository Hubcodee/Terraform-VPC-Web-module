#VPC MOD
resource "aws_route_table" "vpc_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw1.id

  }

  tags = {
    Name = "vpc_main_route"
  }
}
resource "aws_main_route_table_association" "vpc_route_association" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.vpc_route_table.id
}
resource "aws_vpc" "main" {
  cidr_block = var.cidr_vpc
  tags = {
    Name = "VPC1"
  }
}
resource "aws_subnet" "subnet1" {
  availability_zone       = "us-east-1a"
  cidr_block              = var.cidr_subnet1
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id
  tags = {
    Name = "demo-subnet1"
  }
}
resource "aws_subnet" "subnet2" {
  availability_zone       = "us-east-1b"
  cidr_block              = var.cidr_subnet2
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id
  tags = {
    Name = "demo-subnet2"
  }
}
resource "aws_internet_gateway" "gw1" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main_IG"
  }
}
resource "aws_route_table" "route_table_1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw1.id

  }

  tags = {
    Name = "rt-1"
  }
}
resource "aws_route_table" "route_table_2" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.VPC1_nat.id
  }
  tags = {
    Name = "rt-2"
  }
}
resource "aws_route_table_association" "subnet1-rt" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table_1.id
}
resource "aws_route_table_association" "subnet2-rt" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table_2.id
}
resource "aws_eip" "natgateway_ip" {
  vpc = true
}
resource "aws_nat_gateway" "VPC1_nat" {
  allocation_id = aws_eip.natgateway_ip.id
  subnet_id     = aws_subnet.subnet1.id


  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.gw1]
}
