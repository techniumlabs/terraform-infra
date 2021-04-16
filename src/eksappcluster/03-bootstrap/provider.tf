# Setup our providers so that we have deterministic dependecy resolution.
terraform {
  required_version = ">= 0.12.0"
}

# Setup our providers so that we have deterministic dependecy resolution.
provider "aws" {
  region  = var.region
  version = "~> 2.66.0"
  profile = var.aws_profile
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

provider "vault" {
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.11"
}
