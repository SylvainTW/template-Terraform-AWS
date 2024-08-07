# ---
# This file is used to define the main resources necessary for your infrastructure, such as VPCs, subnets, security groups, etc.
# Ensure all resource values are parameterized using variables to maintain flexibility and reusability.
# Define resources by referencing variables declared in the variables.tf file.
# Example resources are provided below for guidance.
# # Define a VPC
# resource "aws_vpc" "main" {
#   cidr_block = var.vpc_cidr
#   tags = {
#     Name = var.vpc_name
#   }
# }
# ---

# ------------------------------------------------------
# ---------------------- VPC ---------------------------
# ------------------------------------------------------
module "vpc" {
  source = "./modules/vpc"
  # source = "terraform-aws-modules/vpc/aws"
  
  name = "vpc-${var.env}"
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

}