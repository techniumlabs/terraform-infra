location = "East US"

server_name = "techniumsql"

database_name = "techsql"

username = "technium"

password = "p@ssword123#"

server_version = "12.0"

firewall_rule = [{
      name             = "access-to-azure"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }]


exist_resource_group_name = ""

new_resource_group_name = "py_test2"

exist_storage_ac_name = ""

new_storage_ac_name = "testtechniumlabs2"

elasticpool_name = "test"

elasticpool_edition = "Basic"

dtu                 = 50

db_dtu_min          = 0

db_dtu_max          = 5

pool_size           = 5000

