region = "us-east-1"
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