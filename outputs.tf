output "application_name" {
  value = var.application_name
}

output "root_mount_path" {
  value = vault_mount.psengine.path
}

output "root_mount_type" {
  value = vault_mount.psengine.type
}

output "root_auth_path" {
  value = vault_jwt_auth_backend.psjwt.path
}

output "root_auth_type" {
  value = vault_jwt_auth_backend.psjwt.type
}

output "application_role" {
  value = vault_jwt_auth_backend_role.app_role.role_name
}

output "application_policy" {
  value = vault_policy.app_policy.name
}

