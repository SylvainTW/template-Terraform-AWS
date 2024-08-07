# Deployment Scripts

This directory contains scripts to manage the Terraform deployment process for different environments (prod, preprod, and staging). These scripts help to initialize, plan, and apply Terraform configurations using aws-vault for secure AWS credential management.

## Prerequisites

1. AWS Vault: Ensure aws-vault is installed and configured.
2. Terraform: Ensure Terraform is installed.


## Configuration

1. Environment Configuration: Update the config.sh file to set the AWS Vault user.
``config.sh``

```sh
AWS_VAULT_USER="your-aws-vault-user"
```

2. Backend and Variable Files: Ensure the backend configuration files (.tfbackend) and variable files (.tfvars) are correctly set up in their respective directories.


## Usage

### Step 1: Navigate to the Project Root

Open a terminal and navigate to the root directory of your project:

```sh
cd path/to/project/root
```

### Step 2: Execute the Deployment Script

Run the deployment script with the desired environment as an argument (prod, preprod, or staging).

```sh
./deploy-terraform/deploy.sh <environment>
```

Replace <environment> with prod, preprod, or staging.

### Example

To deploy to the production environment, use:

```sh
./deploy/deploy.sh prod
```

### Script Details

``deploy.sh``

The deploy.sh script performs the following actions:

1. Load Configuration: Sources the config.sh file to load the AWS Vault user.
2. Check Environment Argument: Ensures that a valid environment argument is provided (prod, preprod, or staging).
3. Set Paths: Defines the paths for backend and variable files based on the environment.
4. Remove Existing Terraform Directory: Deletes the existing .terraform directory if it exists
5. Initialize Terraform: Initializes Terraform with the backend configuration.
6. Plan Terraform Changes: Plans the Terraform changes using the specified variable file.
7. Apply Terraform Changes: Applies the Terraform changes using the specified variable file.