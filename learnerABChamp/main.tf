# Create a VPC
resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
}

# Create two subnets in this VPC
resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.subnet1
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  
}

resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = var.subnet2
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  
}

# Create internet gateway to attach to the VPC 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
  
}

# Create route table for the subnets in the VPC with destination as the gateway for traffic from internet
resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = aws_vpc.myvpc.cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
}
