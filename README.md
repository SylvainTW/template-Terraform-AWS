# Terraform Project

This project deploys infrastructure using Terraform.

## Prerequisites

- Terraform v1.5.0+
- AWS CLI configured :  Begin by configuring AWS CLI with your user credentials. Next, create a profile that allows assuming the SysMaster role for advanced operations.

## Running Terraform Locally

To run Terraform locally, follow these steps to configure the AWS CLI and assume the necessary IAM role:

1. **Configure AWS CLI with your credentials:**

First, set up your AWS CLI with your user credentials. Run the following command and follow the prompts:

```sh
aws configure
```

You will be asked to provide your AWS Access Key ID, Secret Access Key, default region name, and output format. Enter the necessary details as prompted.

2. **Update your AWS CLI configuration to assume a role:**

Next, update your AWS CLI configuration file to specify the role you want to assume. Open the configuration file in your preferred text editor:

```sh
vim ~/.aws/config
```

Add the following configuration for your profile, replacing the role_arn and region values as needed:

```sh
[profile default]
role_arn = arn:aws:iam::992382631026:role/SysMaster
source_profile = default
region = eu-west-3
output = json
```

3. **Update the trust relationship for the role in the AWS Console:**

In the AWS Management Console, navigate to the IAM role you specified (SysMaster) within the account (Account Prod). Update the trust relationship to allow your IAM user to assume this role. Here’s an example policy snippet to add to the trust relationship:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:user/<YOUR_USER_NAME>"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

Replace <YOUR_AWS_ACCOUNT_ID> and <YOUR_USER_NAME> with your actual AWS account ID and IAM user name.

Following these steps ensures that your local Terraform executions use temporary credentials with the necessary permissions, improving security and avoiding the use of long-term access keys.

## Backend Configuration

Before running Terraform, configure the [backend](./backend) by specifying the appropriate backend configuration file:

```sh
# For staging environment
terraform init -backend-config=backend/staging.tfbackend

# For production environment
terraform init -backend-config=backend/prod.tfbackend

# For preproduction environment
terraform init -backend-config=backend/preprod.tfbackend
```

## Usage

### For the development environment, use the development backend and [variable](./vars/dev.tfvars) file with this command :

```sh
# Initialize Terraform with the backend configuration
terraform init -backend-config=backend/staging.tfbackend

# Plan the infrastructure changes
terraform plan -var-file=vars/staging.tfvars

# Apply the changes
terraform apply -var-file=vars/staging.tfvars
```

### For the production environment, use the production backend and [variable](./vars/prod.tfvars) file:

```sh
# Initialize Terraform with the backend configuration
terraform init -backend-config=backend/prod.tfbackend

# Plan the infrastructure changes
terraform plan -var-file=vars/prod.tfvars

# Apply the changes
terraform apply -var-file=vars/prod.tfvars
```

### For the preproduction environment, use the production backend and [variable](./vars/prod.tfvars) file:

```sh
# Initialize Terraform with the backend configuration
terraform init -backend-config=backend/preprod.tfbackend

# Plan the infrastructure changes
terraform plan -var-file=vars/preprod.tfvars

# Apply the changes
terraform apply -var-file=vars/preprod.tfvars
```

## File Structure

### README.md

- Description: This document explains the project, prerequisites, how to use the Terraform files, and basic commands for initialization and deployment.
- To do: Write a detailed project description, configuration instructions, and example Terraform commands.

### main.tf

- Description: This is the main configuration file where modules are declared.
- To do: Add the main module declarations to avoid code duplication and promote reusability. Modules should encapsulate the logic for different parts of your infrastructure (e.g., VPC, EC2 instances).

Example:

```hcl
module "vpc" {
  source = "./modules/vpc"
  ...
}

module "ec2" {
  source = "./modules/ec2"
  ...
}
```

By using modules, you ensure that your infrastructure code is **DRY** (Don't Repeat Yourself) and **maintainable**. Each module can be configured and reused across different environments, reducing redundancy and potential errors.

### provider.tf

- Description: This file defines the providers (AWS, Azure, GCP, etc.) that Terraform will use.
- To do: Configure the providers with regions and authentication details.

### variables.tf

- Description: This file defines all the input variables used in the Terraform configuration.
- To do: Declare variables with their types, descriptions, and default values if necessary.

```hcl
variable "env" {
  type        = string
  description = "The environment for the Terraform deployment (e.g., dev, prod)"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy resources in"
}
```
