#creating a VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = var.project_name
  }
}

#create internet gateway and attach to vpc
resource "aws_internet_gateway" "internet_gateway" {
 vpc_id = aws_vpc.main.id
 tags = {
   Name = "${var.project_name}-igw"
 }
}

#create a route table for internet access
resource "aws_route_table" "route_table" {
 vpc_id = aws_vpc.main.id
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.internet_gateway.id
 }
 tags = {
   Name = "${var.project_name}-rt"
 }
}

#use data source to get all availability zones in the region
data "aws_availability_zones" "available_zones" {}

#create public subnet in az1
resource "aws_subnet" "public_subnet_1" {
 vpc_id = aws_vpc.main.id
 cidr_block = var.public_subnet_cidr_az1
 availability_zone = data.aws_availability_zones.available_zones.names[0]
 map_public_ip_on_launch = true
 tags = {
   Name = "${var.project_name}-public-subnet-1"
 }
}

#create public subnet in az2
resource "aws_subnet" "public_subnet_2" {
 vpc_id = aws_vpc.main.id
 cidr_block = var.public_subnet_cidr_az2
 availability_zone = data.aws_availability_zones.available_zones.names[1]
 map_public_ip_on_launch = true
 tags = {
   Name = "${var.project_name}-public-subnet-2"
 }
}

#associate route table with public subnets
resource "aws_route_table_association" "public_subnet_1_association" {
 subnet_id = aws_subnet.public_subnet_1.id
 route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
 subnet_id = aws_subnet.public_subnet_2.id
 route_table_id = aws_route_table.route_table.id
}

#create private subnets in az1 and az2
resource "aws_subnet" "private_subnet_1" {
 vpc_id = aws_vpc.main.id
 cidr_block = var.private_subnet_cidr_az1
 availability_zone = data.aws_availability_zones.available_zones.names[0]
 map_public_ip_on_launch = false
 tags = {
   Name = "${var.project_name}-private-subnet-1"
 }
}

resource "aws_subnet" "private_subnet_2" {
 vpc_id = aws_vpc.main.id
 cidr_block = var.private_subnet_cidr_az2
 availability_zone = data.aws_availability_zones.available_zones.names[1]
 map_public_ip_on_launch = false
 tags = {
   Name = "${var.project_name}-private-subnet-2"
 }
}


