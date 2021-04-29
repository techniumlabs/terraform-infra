variable "name" {
    type = string
   }

variable "region" {
    type = string
    
}

variable "cidr"{
    type = string

}

variable "azs" {
    type = list(string)
   
}

variable "public_subnets" {
    type = list(string)
    
}

variable "private_subnets" {
    type = list(string)
   
}

variable "database_subnets" {
    type = list(string)
   
}

variable "env" {
    type = string
   
}

variable  "enable_nat_gateway" {
    type = bool
   
}
variable  "single_nat_gateway" {
    type = bool
  
}
variable  "one_nat_gateway_per_az" {
    type = bool
    
}
variable  "create_igw" {
    type = bool
   }

variable  "public_dedicated_network_acl" {
    type = bool
   }

variable  "private_dedicated_network_acl" {
    type = bool
}

variable  "database_dedicated_network_acl" {
    type = bool
}
