terraform {
  backend "s3" {
    bucket               = "techniumlabs-prod-terraform-state"
    key                  = "eks"
    encrypt              = true
    region               = "us-east-1"
    workspace_key_prefix = "200-eks-app-cluster"
    dynamodb_table       = "terraform_state"
  }
}
