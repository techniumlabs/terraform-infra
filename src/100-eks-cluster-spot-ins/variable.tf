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
   
variable "worker_groups_launch_template_name" {
  type = string
} 
 
variable "override_instance_types" {
  type = list(string)
} 
  
variable "spot_instance_pools" {
  type = number
} 
     
variable "asg_max_size" {
  type = number
} 
      
variable "asg_desired_capacity" {
  type = number
} 
      
variable "kubelet_extra_args" {
  type = string
} 

variable "root_volume_type" {
  type = string
} 
      