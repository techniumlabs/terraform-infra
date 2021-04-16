# Setup our providers so that we have deterministic dependecy resolution.
terraform {
  required_version = ">= 0.12.0"
}

# Setup our providers so that we have deterministic dependecy resolution.
provider "aws" {
  region  = var.region
  version = "~> 2.28.1"
}

provider "random" {
  version = "~> 2.1"
}

provider "local" {
  version = "~> 1.3"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}
