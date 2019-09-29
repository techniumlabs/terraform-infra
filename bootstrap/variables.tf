variable "region" {
  type        = string
  default     = "ap-southeast-2"
  description = "The region to deploy the cluster in"
}

variable "terraform_state_bucket" {
  type        = string
  default     = "terraform-state"
  description = "Bucket to save the terraform state"
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

variable "env" {
  type        = string
  default     = "mgmt"
  description = "Name of the environment"
}
