provider "azurerm" {
  features {}
}

provider "azuread" {
  
}

terraform {
  required_version = ">= 1.2.1"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.10.0"
    }
    azuread = {
      version = ">= 2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.5.1"
    }
  }
}

# provider "helm" {
#   kubernetes {
#     host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
#     cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)

#     # using kubelogin to get an AAD token for the cluster.
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       command     = "kubelogin"
#       args = [
#         "get-token",
#         "--environment",
#         "AzurePublicCloud",
#         "--server-id",
#         data.azuread_service_principal.aks_aad_server.application_id, # Note: The AAD server app ID of AKS Managed AAD is always 6dae42f8-4368-4678-94ff-3960e28e3630 in any environments.
#         "--client-id",
#         azuread_application.app.application_id, # SPN App Id created via terraform
#         "--client-secret",
#         azuread_service_principal_password.spn_password.value,
#         "--tenant-id",
#         data.azurerm_subscription.current.tenant_id, # AAD Tenant Id
#         "--login",
#         "spn"
#       ]
#     }
#   }
# }

module "aks" {
  source = "./module/aks"
  cluster_name = var.cluster_name
  resource_group_name = var.resource_group_name
  location = var.location
  kubernetes_version = var.kubernetes_version
  system_node_count = var.system_node_count
  grp_id = module.spn.grpi_id
  node_pool_name = var.node_pool_name
  node_pool_size = var.node_pool_size
}

module "spn" {
  source = "./module/spn"
#   spn_name = var.spn_name
  aad_group_aks_admins = var.aad_group_aks_admins
}