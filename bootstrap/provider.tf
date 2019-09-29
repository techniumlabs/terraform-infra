# Setup our providers so that we have deterministic dependecy resolution.
provider "aws" {
  region  = "${var.region}"
  version = "~> 2.25"
}
