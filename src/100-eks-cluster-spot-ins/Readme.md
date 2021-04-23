
# Config
config your EKS cluster details in `terraform.tfvar` file
```note
region = "us-east-1"
cluster_name = "my-cluster1"
cluster_version = "1.18"
subnets = ["subnet-23232","subnet-4234234"]
vpc_id = "vpc-0531cb2fef557b8b6"
worker_groups_launch_template_name = "spot-1"
override_instance_types = ["t3.medium","t3.small"]
spot_instance_pools = 2
asg_max_size= 2
asg_desired_capacity = 2
kubelet_extra_args = "--node-labels=node.kubernetes.io/lifecycle=spot"#spot instance
root_volume_type = "gp2"
```
# Terraform

## Init
This is where you initialize your code to download the requirements mentioned in your code
```bash
/100-eks-cluster$ terraform init
```
## Plan
This is where you review changes and choose whether to simply accept them
```bash
/100-eks-cluster$ terraform plan
```
## apply
This is where you accept changes and apply them against real infrastructure
```bash
/100-eks-cluster$ terraform apply
```
# aws-node-termination-handler
Suppose if have been choose spot instances, follow this [link](https://artifacthub.io/packages/helm/aws/aws-node-termination-handler) to add aws-node-termination-handler to your pods. By using this  you can avoid  your application downtime