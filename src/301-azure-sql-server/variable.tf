variable server_name {
  type        = string
  description = "Server name"
}

variable location {
  type        = string
  description = "Zone"
}


variable database_name {
  type        = string
  description = "database name"
}

variable username {
  type        = string
  description = "sql server username"
}

variable password {
  type        = string
  description = "sql server password"
}

variable server_version {
  type        = string
  default     = ""
  description = "sql server version"
}

variable exist_storage_ac_name {
  type        = string
  description = "use exist storage account"
}

variable new_storage_ac_name {
  type        = string
  description = "create new storage account and use it"
}

variable exist_resource_group_name {
  type        = string
  description = "use exist resource group"
}

variable new_resource_group_name {
  type        = string
  description = "create new resource group and use it"
}

variable elasticpool_edition{
    type  = string
}

variable elasticpool_name {
  type        = string
  default     = ""
}


variable firewall_rule {
  type    =  list(object({
                name             = string
                start_ip_address = string
                end_ip_address   = string
                }))
  default = []
  description = "firewall list"
}

variable dtu {
  type = number

}

variable db_dtu_min {
  type = number

}

variable db_dtu_max {
  type = number

}

variable pool_size {
  type = number

}