# ---
# This file specifies the values of the variables for the development environment.
# Each variable defined in root variables.tf should have a corresponding value here.
# Ensure that all necessary variables have values assigned to them to avoid issues during the Terraform apply process.

# Example:
# example_variable = "value-dev"
# ---

# --- Specific TAGS ---
env            = "dev"
aws_account_id = "1234569800"

# --- Location ---
aws_region = "eu-west-3"

# ------------------------------------------------------
# ---------------------- VPC ---------------------------
# ------------------------------------------------------
vpc_cidr            = "10.2.0.0/16"
vpc_azs             = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
vpc_private_subnets = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
vpc_public_subnets  = ["10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24"]