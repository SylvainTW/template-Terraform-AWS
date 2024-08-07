# ---
# This file declares the input variables for the Terraform configuration.
# Each variable should have a type, a description, and optionally a default value.
# This helps in understanding the purpose of each variable and ensures that all

# In the ./vars/${env}.tfvars files, specify the actual values for these variables
# based on the environment (e.g., development, production).

# Example of declaring a variable:
# variable "example_variable" {
#   type        = string
#   description = "This is an example variable used for demonstration purposes."
#   default     = "example_value"  # Default value, if applicable
# }

# Example content for ./vars/dev.tfvars:
# example_variable = "value-dev"

# Example content for ./vars/prod.tfvars:
# example_variable = "value-prod"
# ---

variable "aws_account_id" {
  type        = string
  default     = ""
  description = "add AWS account id for role to assume"
}

variable "aws_region" {
  type        = string
  default     = "eu-west-3"
  description = "AWS region to use"
}

variable "env" {
  type        = string
  default     = "prod"
  description = "Specifies the environment for which infrastructure will be deployed.(Dev,Prod,Test,ect..)"
}

# ------------------------------------------------------
# ---------------------- VPC ---------------------------
# ------------------------------------------------------
variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC."
}

variable "vpc_azs" {
  type        = list(string)
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  description = "Availability Zones for the VPC subnets. Specify at least two zones for high availability."
}

variable "vpc_private_subnets" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  description = "CIDR blocks for private subnets within the VPC."
}

variable "vpc_public_subnets" {
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  description = "CIDR blocks for public subnets within the VPC."
}