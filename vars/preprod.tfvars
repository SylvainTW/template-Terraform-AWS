# ---
# This file specifies the values of the variables for the development environment.
# Each variable defined in root variables.tf should have a corresponding value here.
# Ensure that all necessary variables have values assigned to them to avoid issues during the Terraform apply process.

# Example:
# example_variable = "value-preprod"
# ---

# --- Specific TAGS ---
env            = "preprod"
aws_account_id = "1234569800"

# --- Location ---
aws_region = "eu-west-3"

# ------------------------------------------------------
# ---------------------- VPC ---------------------------
# ------------------------------------------------------
vpc_cidr            = "10.1.0.0/16"
vpc_azs             = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
vpc_private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
vpc_public_subnets  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]