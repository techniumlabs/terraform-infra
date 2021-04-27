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

module "my-cluster" {
    source          = "terraform-aws-modules/eks/aws"
    cluster_name    = var.cluster_name
    cluster_version = var.cluster_version
    subnets         = var.subnets
    vpc_id          = var.vpc_id
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

output cluster_endpoint {
    value = module.my-cluster.cluster_endpoint
  
}
