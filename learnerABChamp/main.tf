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
    cidr_block = "0.0.0.0/0"
    #This means we are routing table from the internet
    gateway_id = aws_internet_gateway.igw.id
    #this means the routed internet traffic will have this gateway as the destination for any traffic to the VPC
  }
}

# Create route table association for subnets to associates the desired subnets in the VPC the route must consider
resource "aws_route_table_association" "rt1a" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.myrt.id

}

resource "aws_route_table_association" "rt1b" {
  subnet_id = aws_subnet.subnet2.id
  route_table_id = aws_route_table.myrt.id

}