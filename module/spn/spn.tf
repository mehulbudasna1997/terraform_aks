data "azuread_client_config" "current"{}

# resource "azuread_application_registration" "example" {
#   display_name = "pawan_test1"
  
# }

# resource "azuread_application_password" "example" {
#   application_id = azuread_application_registration.example.id
# }

resource "azuread_group" "aks_admins" {
#   depends_on = [ azuread_application_password.example ]
  display_name     = var.aad_group_aks_admins
  security_enabled = true
  owners           = [data.azuread_client_config.current.object_id]

  # members = [
  #   # data.azuread_client_config.current.object_id,
  #   # azuread_service_principal.spn.object_id,
  #   azuread_application_registration.example.object_id,
  # ]
}

resource "azuread_group_member" "test" {
  group_object_id = azuread_group.aks_admins.object_id
  member_object_id = data.azuread_client_config.current.object_id
}