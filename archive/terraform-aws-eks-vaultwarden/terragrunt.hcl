remote_state {
    backend = "s3"
    generate = {
        path = "state.tf"
        if_exists = "overwrite_terragrunt"
    }

    config = {
        profile = "terraform@guerzon"
        assume_role = {
          role_arn = "arn:aws:iam::<YOUR-AWS-ACCOUNT-ID>:role/TerraformRole"
        }
        bucket = "vaultwarden-tf"
        key = "${path_relative_to_include()}/terraform.tfstate"
        region = "ap-southeast-1"
        encrypt = true
        dynamodb_table = "vaultwarden-tf-locktable"
    }
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
provider "aws" {
  region  = "ap-southeast-1"
  profile = "terraform@guerzon"
  assume_role {
    session_name = "vaultwarden-demo"
    role_arn = "arn:aws:iam::<YOUR-AWS-ACCOUNT-ID>:role/TerraformRole"
  }
}
EOF
}