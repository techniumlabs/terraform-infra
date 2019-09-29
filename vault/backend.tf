terraform {
  backend "s3" {
    bucket  = "terraform-state"
    key     = "vault"
    encrypt = true
    region  = "ap-southeast-2"

    dynamodb_table = "terraform_state"
  }
}
