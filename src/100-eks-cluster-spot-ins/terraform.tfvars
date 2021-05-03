region = "us-east-1"
cluster_name = "my-eks"
cluster_version = "1.19"
vpc_name = "my-vpc"
worker_groups_launch_template_name = "spot-1"
override_instance_types = ["t3.medium","t3.small"]
spot_instance_pools = 2
asg_max_size= 2
asg_desired_capacity = 2
kubelet_extra_args = "--node-labels=node.kubernetes.io/lifecycle=spot"
root_volume_type = "gp2"
   