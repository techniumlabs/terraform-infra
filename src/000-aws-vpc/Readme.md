
# Config
config your VPC details in `terraform.tfvar` file
```note
name = "my-vpc"
region = "us-east-1"
cidr = "10.0.0.0/16"
azs = ["us-east-1a", "us-east-1b","us-east-1c"]
public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
database_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
env = "dev"
....
```
# Terraform

## Init
This is where you initialize your code to download the requirements mentioned in your code
```bash
/000-aws-vpc$ terraform init
```
## Plan
This is where you review changes and choose whether to simply accept them
```bash
/000-aws-vpc$ terraform plan
```
## Apply
This is where you accept changes and apply them against real infrastructure
```bash
/000-aws-vpc$ terraform apply
```
# aws-node-termination-handler
Suppose if have been choose spot instances, follow this [link](https://artifacthub.io/packages/helm/aws/aws-node-termination-handler) to add aws-node-termination-handler to your pods. By using this  you can avoid  your application downtime