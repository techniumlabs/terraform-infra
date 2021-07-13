owners = ["343253"]
region = "us-east-1"
ami_name = "amazon-eks-node-1.15-*"
cluster_name = "my-eks"
cluster_version = "1.19"
vpc_name = "my-vpc"
node_groups_name = "spot-1"
instance_types = ["t3.medium","t3.small"]
max_capacity = 2
min_capacity= 1
desired_capacity = 2
capacity_type = "SPOT"
k8s_labels = {
    environment = "dev"
}
ng_additional_tags = {
    Name= "Test"
}

# launch template
volume_size = 100
volume_type = "gp2"
delete_on_termination = true
device_name = "/dev/xvda"