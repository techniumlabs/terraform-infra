variable "region" {
  type        = string
  default     = "ap-southeast-2"
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

variable "vpc" {
  type        = string
  description = "VPC ID to be used for deploying vault"
}

variable "instance_type" {
  type        = string
  default     = "m5.large"
  description = "Vault server instance type"
}

variable "name_prefix" {
  type        = string
  default     = "vault"
  description = "Prefix to be before every resource"
}
