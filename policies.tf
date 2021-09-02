resource "vault_policy" "app_policy" {
  name = "policy-${var.application_name}"
  policy = <<EOT
path "${var.root_path}/data/${var.application_name}" {
  capabilities = ["read"]
}
EOT
}