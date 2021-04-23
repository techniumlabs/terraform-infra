variable "name" {
    type = string
    default = "my-vpc"
}

variable "region" {
    type = string
    default = "us-east-1"
}

variable "cidr"{
    type = string
    default = "10.0.0.0/16"
}

variable "azs" {
    type = list(string)
    default = ["us-east-1a", "us-east-1b","us-east-1c"]
}

variable "public_subnets" {
    type = list(string)
    default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "private_subnets" {
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "database_subnets" {
    type = list(string)
    default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "env" {
    type = string
    default = "dev"
}


variable  enable_nat_gateway {
    type = bool
    default = true
}
variable  single_nat_gateway {
    type = bool
    default = true
}
variable  one_nat_gateway_per_az {
    type = bool
    default = false
}
variable  create_igw {
    type = bool
    default = true
}
variable  public_dedicated_network_acl {
    type = bool
    default = true
}
variable  private_dedicated_network_acl {
    type = bool
    default = true
}
variable  database_dedicated_network_acl {
    type = bool
    default = true
}
