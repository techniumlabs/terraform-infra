variable "region" {
  type = string
} 

variable "cluster_name" {
  type = string
}

variable "ami_name" {
  type = string
} 
 
 variable "cluster_version" {
  type = string
} 
   
variable "vpc_name" {
  type = string
} 
   
variable "node_groups_name" {
  type = string
} 
 
variable "instance_types" {
  type = list(string)
} 
  
variable "min_capacity" {
  type = number
} 
     
variable "max_capacity" {
  type = number
} 
      
variable "desired_capacity" {
  type = number
} 
      
variable "k8s_labels" {
  type = map
} 
variable "capacity_type" {
  type = string
}

variable "ng_additional_tags" {
  type = map
}

variable volume_size {
  type = number
}
variable volume_type {
  type = string
}
variable delete_on_termination {
  type = string
}

variable device_name {
  type = string
}

variable owners {
  type = list(string)
}