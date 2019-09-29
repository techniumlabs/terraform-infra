module "vault_cluster" {
  source       = "terraform-aws-modules/eks/aws"
  version      = "6.0.1"
  cluster_name = var.name_prefix
  subnets      = tolist(data.aws_subnet_ids.tier2_subnets.ids)
  vpc_id       = var.vpc

  worker_groups = [
    {
      instance_type        = var.instance_type
      asg_min_size         = 3
      asg_desired_capacity = 3
      asg_max_size         = 5
      tags = [{
        key                 = "owner"
        value               = var.team_name
        propagate_at_launch = true
      }]
    }
  ]

  tags = {
    environment = var.env
    owner       = var.team_name
    group       = "vault"
  }
}
