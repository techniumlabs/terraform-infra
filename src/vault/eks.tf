module "vault_cluster" {
  source       = "terraform-aws-modules/eks/aws"
  version      = "6.0.1"
  cluster_name = var.name_prefix
  subnets      = tolist(data.aws_subnet_ids.tier2_subnets.ids)
  vpc_id       = var.vpc

  workers_additional_policies = [aws_iam_policy.vault_server_policy.arn]

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

  tags = merge(
    {
      "environment" = var.env
      "owner"       = var.team_name
    },
    var.tags,
  )

}
