variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The region to deploy the cluster in"
}

variable "team_name" {
  type        = string
  default     = "devops"
  description = "Name of the team who owns this"
}

variable "tags" {
  type = map(string)
  default = {
    environment = "mgmt"
  }
  description = "AWS tags to be applied to created resources."
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "appname" {
  type        = string
  description = "App name"
}

variable "vpc" {
  type        = string
  description = "VPC ID to be used for deploying vault"
}

variable "instance_type" {
  type        = string
  default     = "m5.large"
  description = "eks Instance type"
}

variable "cluster_name" {
  type        = string
  default     = "blue"
  description = "Name of the cluster"
}

variable "cluster_version" {
  type        = string
  description = "Name of the cluster"
}

variable "pod_subnets" {
  type        = list
  default     = []
  description = "Subnets for pods"
}

variable "route53_dns" {
  type        = string
  description = "dns suffix for the zone"
}

variable "aws_profile" {
  type        = string
  description = "AWS Profile name where the env has to be created"
}

variable "worker_policies" {
  type        = list(string)
  description = "List of Policy ARN for the worker"
}
