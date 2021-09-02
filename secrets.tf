#----------------------------------------------------------
# Enable kv version 2 secrets engine
#----------------------------------------------------------
resource "vault_mount" "psengine" {
  path        = var.path
  type        = "kv-v2"
  description = var.secret_engine_description
}