resource "vault_policy" "app_policy" {
  name   = "policy-${var.application_name}"
  policy = <<EOT
path "${var.path}/data" {
  capabilities = ["read"]
}
EOT
}