variable "resource_group_name" {
  type = string
}

variable "location" {
    type = string
}

variable "cluster_name" {
    type = string
}

variable "kubernetes_version" {
    type = string
}

variable "system_node_count" {
    type = string
}

# variable "spn_name" {
#   type = string
# }

variable "aad_group_aks_admins" {
  type = string
}

variable "node_pool_name" {
    type = string
}

variable "node_pool_size" {
    type = string
}