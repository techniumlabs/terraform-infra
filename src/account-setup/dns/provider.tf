# Setup our providers so that we have deterministic dependecy resolution.
terraform {
  required_version = ">= 0.12.0"
}

# Setup our providers so that we have deterministic dependecy resolution.
provider "aws" {
  region  = var.region
  version = "~> 2.28.1"
}
