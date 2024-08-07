# Vars Directory

The vars directory contains variable definition files that specify the values for the input variables defined in variables.tf.

These files are used to configure different environments such as development, testing, and production. By separating these values into different files, you can easily switch between configurations without modifying the main Terraform scripts.

## File Descriptions

### develop.tfvars

- Description: This file contains variable definitions for the development environment.
- To do: Specify values for variables that are specific to the development environment. These values will override the default values defined in variables.tf.

Example:

```hcl
env            = "develop"
region         = "eu-west-1"
vpc_name       = "vpc-develop"
cidr           = "10.0.0.0/16"
vpc_azs        = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
vpc_public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
```

### prod.tfvars

- Description: This file contains variable definitions for the production environment.
- To do: Specify values for variables that are specific to the production environment. These values will override the default values defined in variables.tf.

Example:

```hcl
env            = "prod"
region         = "eu-west-1"
vpc_name       = "vpc-prod"
cidr           = "10.0.0.0/16"
vpc_azs        = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
vpc_public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
```

### test.tfvars

- Description: This file contains variable definitions for the testing environment.
- To do: Specify values for variables that are specific to the testing environment. These values will override the default values defined in variables.tf.

Example:

```hcl
env            = "test"
region         = "eu-west-1"
vpc_name       = "vpc-test"
cidr           = "10.0.0.0/16"
vpc_azs        = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
vpc_public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
```

## Usage

To use a specific environment configuration, pass the corresponding .tfvars file when running Terraform commands. For example, to use the development environment configuration:

```sh
terraform init -backend-config=backend/develop.tfbackend
terraform plan -var-file=vars/develop.tfvars
terraform apply -var-file=vars/develop.tfvars
```

This approach allows you to manage multiple environments efficiently, ensuring that each environment has its own specific configuration without modifying the core Terraform code.
