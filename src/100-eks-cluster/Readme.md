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