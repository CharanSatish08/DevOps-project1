provider "aws" {
  region = var.region
}

#create VPC
module "vpc" {
  source = "../Modules"
  region = var.region
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr_az1 = var.public_subnet_cidr_az1
  public_subnet_cidr_az2 = var.public_subnet_cidr_az2
  private_subnet_cidr_az1 = var.private_subnet_cidr_az1
  private_subnet_cidr_az2 = var.private_subnet_cidr_az2
}