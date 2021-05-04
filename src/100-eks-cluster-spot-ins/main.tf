provider "aws" {
    region = "us-east-1"
}

data "aws_eks_cluster" "cluster" {
    name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
    name = module.my-cluster.cluster_id
} 

provider "kubernetes" {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_vpc" "selected" {

filter  {
    name   = "tag:Name"
    values = [var.vpc_name]
}
}
data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.selected.id
  filter  {
    name   = "tag:Name"
    values = ["${var.vpc_name}-private*"]
}
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.selected.id
  filter  {
    name   = "tag:Name"
    values = ["${var.vpc_name}-public*"]
}
}

locals {
    private_subnet = [for s in data.aws_subnet_ids.private.ids : s]
    public_subnet  = [for s in data.aws_subnet_ids.public.ids : s]
    pri_pub_subnet = concat(local.private_subnet,local.public_subnet)
}

module "my-cluster" {
    source          = "terraform-aws-modules/eks/aws"
    cluster_name    = var.cluster_name
    cluster_version = var.cluster_version
    subnets         = local.private_subnet
    vpc_id          = data.aws_vpc.selected.id
    enable_irsa     = true

     worker_groups_launch_template = [
    {
      name                    = var.worker_groups_launch_template_name
      override_instance_types = var.override_instance_types
      spot_instance_pools     = var.spot_instance_pools
      asg_max_size            = var.asg_max_size
      asg_desired_capacity    = var.asg_desired_capacity
      kubelet_extra_args      = var.kubelet_extra_args
      root_volume_type        = var.root_volume_type
    }
  ]
}



resource "aws_ec2_tag" "kubernet_tag" {
    count       = length(local.pri_pub_subnet)
    resource_id = local.pri_pub_subnet[count.index]
     key        = "kubernetes.io/cluster/${var.cluster_name}"
     value      = "owned"
}

resource "aws_ec2_tag" "private_sn_tag" {
    count       = length(local.private_subnet)
    resource_id =  local.private_subnet[count.index]
     key        = "kubernetes.io/role/internal-elb"
     value      = "1"
}

resource "aws_ec2_tag" "public_sn_tag" {
    count       = length(local.public_subnet)
    resource_id =  local.public_subnet[count.index]
     key        = "kubernetes.io/role/elb"
     value      = "1"
}

output cluster_endpoint {
  value       = module.my-cluster.cluster_endpoint
  
}
