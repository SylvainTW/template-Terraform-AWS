# ---
# This file specifies the values of the variables for the development environment.
# Each variable defined in root variables.tf should have a corresponding value here.
# Ensure that all necessary variables have values assigned to them to avoid issues during the Terraform apply process.

# Example:
# example_variable = "value-prod"
# ---

# --- Specific TAGS ---
env            = "prod"
aws_account_id = "1234569800"

# --- Location ---
aws_region = "eu-west-3"

# ------------------------------------------------------
# ---------------------- VPC ---------------------------
# ------------------------------------------------------
vpc_cidr            = "10.0.0.0/16"
vpc_azs             = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
vpc_public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]