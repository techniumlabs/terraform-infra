output "eks_cluster" {
  value = module.eks_cluster
}

output "pod_subnets" {
  value = var.pod_subnets
}
