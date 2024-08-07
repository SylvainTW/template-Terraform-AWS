# AWS CloudFormation Templates for Terraform Setup

This directory contains CloudFormation templates to set up the necessary AWS infrastructure for managing Terraform state and operations. The templates create IAM roles, an S3 bucket for storing Terraform state, and a DynamoDB table for state locking.

## Templates

### backend-in-shared-account.yaml

This template creates the following resources:
- An S3 bucket for Terraform state.
- A DynamoDB table for Terraform state locking.
- IAM roles for Terraform execution and backend operations.

#### Parameters

- **S3BucketName**: The name of the S3 bucket for Terraform state. Default is `bucket-tfstate-kelkun`.
- **DynamoDBTableName**: The name of the DynamoDB table for Terraform state locking. Default is `terraform-lock-table`.
- **Region**: The AWS region where resources will be created. Default is `eu-west-3`.
- **RoleName**: The name of the IAM role for Terraform execution. Default is `terraform-execution`.
- **BackendRoleName**: The name of the IAM role for backend operations. Default is `terraform-backend`.
- **TrustedAccountId**: The AWS Account ID that can assume these roles.
- **TrustedRole**: The name of the trusted IAM role allowed to assume these roles. Default is `SysMaster`.

#### Resources Created

- **S3Bucket**: An S3 bucket with server-side encryption and versioning enabled.
- **DynamoDBTable**: A DynamoDB table with on-demand billing mode and deletion protection.
- **IAMRole**: An IAM role with a policy that allows all actions.
- **TerraformBackendRole**: An IAM role with a policy that grants permissions to access the S3 bucket and DynamoDB table.

#### Outputs

- **S3BucketNameOutput**: The name of the S3 bucket.
- **DynamoDBTableNameOutput**: The name of the DynamoDB table.
- **IAMRoleArn**: The ARN of the Terraform execution role.
- **TerraformBackendRole**: The ARN of the Terraform backend role.

### role-terraform-execution.yaml

This template creates an IAM role specifically for Terraform execution.

#### Parameters

- **RoleName**: The name of the IAM role to be created. Default is `terraform-execution`.
- **TrustedAccountId**: The AWS Account ID that can assume this role.
- **TrustedRole**: The name of the trusted IAM role allowed to assume this role. Default is `SysMaster`.

#### Resources Created

- **IAMRole**: An IAM role with a policy that allows all actions.

#### Outputs

- **IAMRoleArn**: The ARN of the IAM role.

#### Deployment Instructions

The `role-terraform-execution.yaml` template needs to be deployed in each AWS account where Terraform will be run. This ensures that the Terraform execution role is available in each environment (e.g., production, staging, development) where Terraform operations are performed.

**Steps for Deployment in Each Account:**

1. **Prepare the CloudFormation Template:**
   - Make sure the `role-terraform-execution.yaml` file is configured with the correct parameters for each account.

2. **Deploy Using AWS CLI:**
   ```sh
   aws cloudformation create-stack --stack-name terraform-execution-role-setup \
       --template-body file://role-terraform-execution.yaml \
       --parameters ParameterKey=RoleName,ParameterValue=terraform-execution \
                    ParameterKey=TrustedAccountId,ParameterValue=<YourAWSAccountID> \
                    ParameterKey=TrustedRole,ParameterValue=SysMaster \
       --capabilities CAPABILITY_NAMED_IAM
   ```

3. **Deploy Using AWS Management Console:**
   - Open the AWS Management Console.
   - Navigate to the CloudFormation service.
   - Click on "Create stack" and select "With new resources (standard)".
   - Upload the `role-terraform-execution.yaml` file and follow the prompts to create the stack.

4. **Verify the Role Creation:**
   ```sh
   aws cloudformation describe-stacks --stack-name terraform-execution-role-setup
   ```

### Step 3: Verify the Stack Creation

After deploying the templates, verify the creation of the resources in the AWS Management Console or by using the AWS CLI.

```sh
aws cloudformation describe-stacks --stack-name terraform-backend-setup
aws cloudformation describe-stacks --stack-name terraform-execution-role-setup
```

### Step 4: Clean Up (Optional)

Once the setup is complete, you may delete the local CloudFormation template files if they are no longer needed.

```sh
rm backend-in-shared-account.yaml
rm role-terraform-execution.yaml
```

By following these steps, you can set up the necessary AWS infrastructure to manage your Terraform state securely and efficiently across multiple environments.
