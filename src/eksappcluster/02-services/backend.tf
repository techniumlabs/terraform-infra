terraform {
  backend "s3" {
    bucket               = "terraform-state"
    key                  = "eks"
    encrypt              = true
    region               = "ap-southeast-2"
    workspace_key_prefix = "platform/apps/eksappcluster/02-services"
    dynamodb_table       = "terraform_state"
    profile              = "dice-mgmt"
  }
}
