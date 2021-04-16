data "aws_subnet_ids" "tier2_subnets" {
  vpc_id = var.vpc

  tags = {
    tier = "tier2"
  }
}

data "aws_elb_service_account" "elb_sa" {
}
