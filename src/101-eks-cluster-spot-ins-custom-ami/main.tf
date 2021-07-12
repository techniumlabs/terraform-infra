provider "aws" {
    region = var.region
}

# terraform {
#   backend "s3" {
#   }
# }

data "aws_eks_cluster" "cluster" {
    name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
    name = module.my-cluster.cluster_id
}

data "aws_ami_ids" "ubuntu" {
  # owners = ["343434343"]

  filter {
    name   = "name"
    values = [var.ami_name]
  }
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

    # node_groups = {

    #    node_group = {
    #     desired_capacity = var.desired_capacity
    #     max_capacity     = var.max_capacity
    #     min_capacity     = var.min_capacity
    #     instance_types   = var.instance_types
    #     capacity_type    = var.capacity_type
    #     k8s_labels       = var.k8s_labels
    #     additional_tags  = var.ng_additional_tags
    #   }
    # }
    
     worker_groups_launch_template = [
    {
      name                    = "spot-1"
      ami_id                  = data.aws_ami_ids.ubuntu.ids[0]
      override_instance_types = ["m5.large", "m5a.large", "m5d.large", "m5ad.large"]
      spot_instance_pools     = 4
      asg_max_size            = 5
      asg_desired_capacity    = 5
      kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot"
      public_ip               = true
    },
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
