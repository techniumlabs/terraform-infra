data "aws_subnet_ids" "tier1" {
  vpc_id = var.vpc

  tags = {
    tier = "tier1"
  }
}

data "aws_subnet_ids" "tier2" {
  vpc_id = var.vpc

  tags = {
    tier = "tier2"
  }
}

data "aws_subnet_ids" "tier2_shared" {
  vpc_id = var.vpc

  tags = {
    tier = "tier2-shared-${var.cluster_name}"
  }
}

data "aws_subnet" "tier1" {
  count = length(data.aws_subnet_ids.tier1.ids)
  id    = tolist(data.aws_subnet_ids.tier1.ids)[count.index]
}


data "aws_subnet" "tier2" {
  count = length(data.aws_subnet_ids.tier2.ids)
  id    = tolist(data.aws_subnet_ids.tier2.ids)[count.index]
}

data "aws_subnet" "tier2_shared" {
  count = length(data.aws_subnet_ids.tier2_shared.ids)
  id    = tolist(data.aws_subnet_ids.tier2_shared.ids)[count.index]
}


data "aws_eks_cluster" "cluster" {
  name = module.eks_cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.cluster_id
}

data "aws_route53_zone" "public" {
  name         = var.route53_dns
  private_zone = false
}

data "aws_route53_zone" "private" {
  name         = var.route53_dns
  private_zone = true
}
