#SSM config
    1. Create the ami using [packer](https://github.com/awslabs/amazon-eks-ami)
    2. Update image id in terraform variable file
    3. Add the AmazonSSMFullAccess and AmazonSSMManagedInstanceCore policies in EKS role and restart the all nodes 
    
# Config
config your EKS cluster details in `terraform.tfvar` file
```note
region = "us-west-2"
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
## Apply
This is where you accept changes and apply them against real infrastructure
```bash
/100-eks-cluster$ terraform apply
```
# aws-node-termination-handler
Suppose if have been choose spot instances, follow this [link](https://artifacthub.io/packages/helm/aws/aws-node-termination-handler) to add aws-node-termination-handler to your pods. By using this  you can avoid  your application downtime

# LB Config
1. Create policy for AWS Load Balance Controller
2. Create an IAM role for the AWS Load Balancer Controller with that policy
3. Update trusted-relationship policy for IAM role with EKS cluster provider id
4. Create service account with IAM role arn annotation
5. Install the TargetGroupBinding custom resource definitions
6. Add the eks-charts repository.
7. Install the AWS Load Balancer Controller using the command that corresponds to the Region that your cluster is in
```bash
    helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller \
  --set clusterName=<cluster-name> \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  -n kube-system
```
[more info](https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html)

8. Add public and private subnet tags

    - Key – kubernetes.io/cluster/<cluster-name>

    - Value – shared or owned

9. Add Private subnet tag

    - Key – kubernetes.io/role/internal-elb

    - Value – 1

10. Add Private subnet tag

    - Key – kubernetes.io/role/elb

    - Value – 1

11. Deploy your application with deployment, service ingress for ALB [more info](https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html) 


12. Deploy your application with deployment, service ingress for NLB [more info](https://docs.aws.amazon.com/eks/latest/userguide/load-balancing.html) 
    
