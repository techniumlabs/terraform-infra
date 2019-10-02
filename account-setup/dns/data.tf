data "aws_subnet_ids" "selected" {
  vpc_id = var.vpc

  tags = {
    tier = "tier2"
  }
}
