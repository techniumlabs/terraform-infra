region = "us-east-1"
cluster_name = "my-cluster1"
cluster_version = "1.18"
subnets = ["subnet-0f730fea8a4a4994d","subnet-0c86a6fab212aae33"]
vpc_id = "vpc-0531cb2fef557b8b6"
worker_groups_launch_template_name = "spot-1"
override_instance_types = ["t3.medium","t3.small"]
spot_instance_pools = 2
asg_max_size= 2
asg_desired_capacity = 2
kubelet_extra_args = "--node-labels=node.kubernetes.io/lifecycle=spot"
root_volume_type = "gp2"
   