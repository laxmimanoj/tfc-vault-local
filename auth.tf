#--------------------------------
# Enable jwt auth method
#--------------------------------
# resource "vault_auth_backend" "psauth" {
#     path = var.root_path
#     type = "jwt"
#     description = var.auth_backend_desccription
# }

#configure jwt auth
resource "vault_jwt_auth_backend" "psjwt" {
  path                   = var.root_path
  type                   = "jwt"
  description            = var.auth_backend_desccription
  jwt_validation_pubkeys = [file("cert.pem")]
}

resource "vault_jwt_auth_backend_role" "app_role" {
  backend         = vault_jwt_auth_backend.psjwt.path
  role_name       = "role-${var.application_name}"
  token_policies  = [vault_policy.app_policy.name]
  role_type       = "jwt"
  bound_subject   = var.application_name
  bound_audiences = ["vault"]
  user_claim      = "unique_name"
  bound_claims = {
    role = "role-${var.application_name}"
  }
  token_ttl      = 20
  token_max_ttl  = 20
  token_num_uses = 1
}