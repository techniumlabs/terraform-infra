module "eks_cluster" {
  source                          = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v13.2.1"
  cluster_name                    = "${var.appname}-${var.cluster_name}"
  cluster_version                 = var.cluster_version
  subnets                         = tolist(data.aws_subnet_ids.tier2.ids)
  vpc_id                          = var.vpc
  cluster_create_security_group   = false
  cluster_security_group_id       = aws_security_group.cluster.id
  cluster_endpoint_public_access  = false
  cluster_endpoint_private_access = true
  write_kubeconfig                = false
  manage_aws_auth                 = true

  workers_additional_policies = length(var.worker_policies) > 0 ? var.worker_policies : []

  workers_group_defaults = {
    tags = [
      {
        key                 = "cluster"
        value               = var.cluster_name
        propagate_at_launch = true
      },
      {
        key                 = "environment"
        value               = var.env
        propagate_at_launch = true
      },
      {
        key                 = "owner"
        value               = var.team_name
        propagate_at_launch = true
      },
      {
        key                 = "k8s.io/cluster-autoscaler/${var.appname}-${var.cluster_name}"
        value               = "owned"
        propagate_at_launch = true
      },
      {
        key                 = "k8s.io/cluster-autoscaler/enabled"
        value               = "TRUE"
        propagate_at_launch = true
      }
    ]
  }
  worker_groups = [
    {
      instance_type        = var.instance_type
      asg_min_size         = 1
      asg_desired_capacity = 1
      asg_max_size         = 5
      root_volume_type     = "gp3"
      autoscaling_enabled  = true
    }
  ]

  tags = merge(
    {
      "environment" = var.env
      "owner"       = var.team_name
      "cluster"     = var.cluster_name
    },
    var.tags,
  )
}

resource "aws_iam_role_policy_attachment" "workers_autoscaling" {
  policy_arn = aws_iam_policy.worker_autoscaling.arn
  role       = module.eks_cluster.worker_iam_role_name
}

resource "aws_iam_policy" "worker_autoscaling" {
  name_prefix = "${var.appname}-${var.cluster_name}-eks-worker-autoscaling-${module.eks_cluster.cluster_id}"
  description = "EKS worker node autoscaling policy for cluster ${module.eks_cluster.cluster_id}"
  policy      = data.aws_iam_policy_document.worker_autoscaling.json
}

data "aws_iam_policy_document" "worker_autoscaling" {
  statement {
    sid    = "eksWorkerAutoscalingAll"
    effect = "Allow"

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "ec2:DescribeLaunchTemplateVersions",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "eksWorkerAutoscalingOwn"
    effect = "Allow"

    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "autoscaling:UpdateAutoScalingGroup",
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/kubernetes.io/cluster/${module.eks_cluster.cluster_id}"
      values   = ["owned"]
    }

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/k8s.io/cluster-autoscaler/enabled"
      values   = ["true"]
    }
  }
}
