provider "aws" {
  region = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = var.name
  cidr = var.cidr

  azs             = var.azs
  private_subnets = var.private_subnets
  database_subnets = var.database_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az

  create_igw = var.create_igw
  
  public_dedicated_network_acl = var.public_dedicated_network_acl
  private_dedicated_network_acl = var.private_dedicated_network_acl
  database_dedicated_network_acl = var.database_dedicated_network_acl

  tags = {
    Terraform = "true"
    Environment = var.env
  }
}