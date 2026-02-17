output "region" {
  value = var.region
}

output "project_name" {
  value = var.project_name
}

output "vpc_cidr" {
  value = var.vpc_cidr  
}

output "public_subnet_cidr_az1" {
  value = var.public_subnet_cidr_az1
}

output "public_subnet_cidr_az2" {
  value = var.public_subnet_cidr_az2
}

output "private_subnet_cidr_az1" {
  value = var.private_subnet_cidr_az1
}

output "private_subnet_cidr_az2" {
  value = var.private_subnet_cidr_az2
}

output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}