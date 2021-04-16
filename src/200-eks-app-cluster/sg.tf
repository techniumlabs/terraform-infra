resource "aws_security_group" "cluster" {
  name_prefix = "${var.appname}-${var.cluster_name}"
  description = "EKS cluster security group."
  vpc_id      = var.vpc
  tags = merge(
    var.tags,
    {
      "Name" = "${var.appname}-${var.cluster_name}-sg"
    },
  )
}

resource "aws_security_group_rule" "cluster_https_external_access" {
  description       = "Allow external devices within the org to communicate with the EKS cluster API."
  protocol          = "tcp"
  security_group_id = aws_security_group.cluster.id
  cidr_blocks       = concat([], tolist(data.aws_subnet.tier2_shared.*.cidr_block))
  from_port         = 443
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "lb_subnet_access_int" {
  description       = "allow int lb to access worker nodes"
  protocol          = "tcp"
  security_group_id = module.eks_cluster.worker_security_group_id
  cidr_blocks       = data.aws_subnet.tier2.*.cidr_block
  from_port         = 30102
  to_port           = 30103
  type              = "ingress"
}

resource "aws_security_group_rule" "lb_subnet_access_ext" {
  description       = "allow ext lb to access worker nodes"
  protocol          = "tcp"
  security_group_id = module.eks_cluster.worker_security_group_id
  cidr_blocks       = data.aws_subnet.tier1.*.cidr_block
  from_port         = 30100
  to_port           = 30101
  type              = "ingress"
}

resource "aws_security_group_rule" "lb_subnet_access_https" {
  description       = "allow client to access lb for https"
  protocol          = "tcp"
  security_group_id = module.eks_cluster.worker_security_group_id
  cidr_blocks       = data.aws_subnet.tier1.*.cidr_block
  from_port         = 443
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "lb_subnet_access_http" {
  description       = "allow client to access lb for http"
  protocol          = "tcp"
  security_group_id = module.eks_cluster.worker_security_group_id
  cidr_blocks       = data.aws_subnet.tier1.*.cidr_block
  from_port         = 80
  to_port           = 80
  type              = "ingress"
}