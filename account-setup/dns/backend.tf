terraform {
  backend "s3" {
    bucket               = "terraform-state"
    key                  = "account-setup/dns"
    encrypt              = true
    region               = "ap-southeast-2"
    workspace_key_prefix = "environment"
    dynamodb_table       = "terraform_state"
  }
}
