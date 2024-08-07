terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.57.0"
    }
  }

  backend "s3" {}
}
provider "aws" {
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/terraform-execution"
  }

  default_tags {
    tags = {
      Terraform = "true"
      Env       = var.env
      Owner     = "TEAMWORK"
    }
  }
}