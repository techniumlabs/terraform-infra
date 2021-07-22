variable "region" {
  type = string
} 

variable "cluster_name" {
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

variable fargate_selectors {
  type = list(map)
}