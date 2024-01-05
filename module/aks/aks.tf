resource "azurerm_resource_group" "rg" {
  name     =    "${var.resource_group_name}-${terraform.workspace}"
  location = var.location
}

# data "azurerm_resource_group" "rg" {
#   name     = var.resource_group_name
# }


data "azurerm_subscription" "current"{}

resource "azurerm_kubernetes_cluster" "aks" {
  name                   = "${var.cluster_name}-${terraform.workspace}"
  kubernetes_version     = var.kubernetes_version
  location               = var.location
  resource_group_name    = azurerm_resource_group.rg.name #data.azurerm_resource_group.rg.name
  dns_prefix             = var.cluster_name
  local_account_disabled = true

  default_node_pool {
    name       =  var.node_pool_name
    node_count = var.system_node_count
    vm_size    = var.node_pool_size
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    managed                = true
    azure_rbac_enabled     = true
    admin_group_object_ids = [var.grp_id]
    tenant_id              = data.azurerm_subscription.current.tenant_id
  }
}