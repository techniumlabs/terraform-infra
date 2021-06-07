

provider "azurerm" {
  features {}
}


data "azurerm_virtual_network" "aks" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}


resource "azurerm_kubernetes_cluster" "aks" {
    name                = var.aks_name
    location            = var.location
    resource_group_name = var.resource_group_name
    dns_prefix          = var.dns_prefix
    default_node_pool {
      name       = var.dnp_name
      node_count = var.dnp_node_count
      vm_size    = var.dnp_vm_size
      vnet_subnet_id = data.azurerm_subnet.subnet.id
    }
    identity {
      type = var.aks_identity
    }

    windows_profile {
      admin_username = var.windows_profile_username
      admin_password = var.windows_profile_password
    }
    network_profile {
        network_plugin     = var.network_profile_plugin
        network_policy     = var.network_profile_policy
        dns_service_ip     = cidrhost(var.service_ip, 10)
        docker_bridge_cidr = var.docker_bridge_cidr
        service_cidr       = var.service_ip

      }
}

resource "azurerm_kubernetes_cluster_node_pool" "win" {
  # priority = "Spot"
  name                  = var.win_pool_name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.wnp_vm_size
  node_count            = var.wnp_node_count
  os_type               = "Windows"
  vnet_subnet_id = data.azurerm_subnet.subnet.id
 
}


resource "azurerm_container_registry" "acr" {
      name = var.registry_name
      resource_group_name = var.resource_group_name
      location = var.location
      sku = var.registry_sku
      admin_enabled = false
}

resource "azurerm_role_assignment" "role_acr" {
      scope = azurerm_container_registry.acr.id
      role_definition_name = var.role_definition_name
      principal_id = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
      skip_service_principal_aad_check = true
}
