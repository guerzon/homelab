
# Deploy Vaultwarden in AWS EKS using Terraform, Terragrunt, and Helm

## Setup

1. Login to IAM and create account.

2. Setup and create S3 buckets for the state.

    ```bash
    aws s3api create-bucket \
      --bucket vaultwarden-tf \
      --create-bucket-configuration LocationConstraint=ap-southeast-1 \
      --region ap-southeast-1

    aws s3api put-bucket-versioning \
      --bucket vaultwarden-tf \
      --versioning-configuration Status=Enabled \
      --region ap-southeast-1

    aws dynamodb create-table \
      --table-name vaultwarden-tf-locktable \
      --attribute-definitions AttributeName=LockID,AttributeType=S \
      --key-schema AttributeName=LockID,KeyType=HASH \
      --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
      --table-class STANDARD \
      --region ap-southeast-1
    ```

3. Create IAM role that can be assumed by a user, setup an IAM policy, and a group.

    ```bash
    # Create a trust policy document
    cat << EOF > trustpolicyiam.json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "sts:AssumeRole",
                "Principal": {
                    "AWS": "<YOUR-AWS-ACCOUNT-ID>"
                },
                "Condition": {}
            }
        ]
    }
    EOF
    
    # Create the role and attach the trust policy file that allows users     in the specified account to assume the role.
    aws iam create-role \
      --role-name TerraformRole \
      --assume-role-policy-document file://${PWD}/trustpolicyiam.json
    
    # For this demo, attach the AdministratorAccess AWS-managed policy     to the role
    aws iam attach-role-policy \
      --role-name TerraformRole \
      --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
    ```

4. Create the IAM policy that allows users to assume the TerraformRole IAM role.

    ```bash
    # Create the policy json document
    cat << EOF > terraformpolicy.json
    {
     "Version": "2012-10-17",
     "Statement": [
      {
       "Effect": "Allow",
       "Action": "sts:AssumeRole",
       "Resource": "arn:aws:iam::<YOUR-AWS-ACCOUNT-ID>:role/TerraformRole"
      }
     ]
    }
    EOF
    
    # Create the policy
    aws iam create-policy \
        --policy-name TerraformPolicy \
        --policy-document file://terraformpolicy.json
    ```

5. Instead of attaching a policy directly to users, create a group.

    ```bash
    aws iam create-group \
      --group-name devops

    # Attach the policy to the group
    aws iam attach-group-policy \
      --group-name devops \
      --policy-arn arn:aws:iam::<YOUR-AWS-ACCOUNT-ID>:policy/TerraformPolicy
    ```

6. Finally, create an IAM user for terraform:

    ```bash
    aws iam create-user \
      --user-name terraform

    # Add the user to the devops group
    aws iam add-user-to-group \
      --user-name terraform \
      --group-name devops

    # Create access keys for the terraform user
    aws iam create-access-key \
      --user-name terraform

    aws configure --profile terraform@contosoorg
    ```

7. Configure credentials for the aws cli:

    ```bash
    cat << EOF >> ~/.aws/config
    [profile terraformIAM]
    source_profile = terraform@contosoorg
    role_arn = arn:aws:iam::<YOUR-AWS-ACCOUNT-ID>:role/TerraformRole
    EOF
    export AWS_PROFILE=terraformIAM
    ```

## Running Terragrunt

```bash
cd test/
terragrunt run-all init
terragrunt run-all [plan|apply]
```

## Kubernetes

```bash
aws eks update-kubeconfig \
  --name vaultwarden-test-eks \
  --region ap-southeast-1
```

### Helm

```bash
helm template -n vault \
  vaultwarden-release vaultwarden/vaultwarden \
  -f values-eks.yaml

kubectl create ns vault

helm upgrade -i -n vault \
  vaultwarden-release vaultwarden/vaultwarden \
  -f values-eks.yaml
```
