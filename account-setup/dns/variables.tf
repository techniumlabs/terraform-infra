variable "region" {
  type        = string
  default     = "ap-southeast-2"
  description = "The region to deploy the cluster in"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "vpc" {
  type        = string
  description = "VPC ID to be used"
}

variable "team_name" {
  type        = string
  default     = "devops"
  description = "Name of the team who owns this"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "AWS tags to be applied to created resources."
}

variable "resolver_name" {
  type        = string
  default     = "internal-site"
  description = "Name of resolver"
}

variable "internal_domain" {
  type        = string
  description = "Internal domain to which we need to forward to"
}

variable "internal_dns_ip" {
  type        = list(string)
  default     = []
  description = "DNS IP for the forward rule"
}
