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
  path        = var.root_path
  type        = "jwt"
  description = var.auth_backend_desccription
  jwt_validation_pubkeys = [<<EOT
-----BEGIN CERTIFICATE-----
MIIC9DCCAdwCCQCA+pMeksBbAjANBgkqhkiG9w0BAQsFADA8MQswCQYDVQQGEwJV
UzELMAkGA1UECAwCVFgxEDAOBgNVBAcMB0hvdXN0b24xDjAMBgNVBAMMBW1hbm9q
MB4XDTIxMDkwMjAwMDcyMFoXDTMxMDgzMTAwMDcyMFowPDELMAkGA1UEBhMCVVMx
CzAJBgNVBAgMAlRYMRAwDgYDVQQHDAdIb3VzdG9uMQ4wDAYDVQQDDAVtYW5vajCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMsn9sw3hsKwXMrrRRIJLIBn
UZ5DKMTtO+glBhBRRIPCOirNy4zVUAXUCc/Jm5xkLYjB9RYiSzMV8/10ZKtZmhor
U5surw1buiUv6v4xe0Y+ECyqaAayWh3iMaofu6vuCBUPubNDftst8YX2t0oALQyj
rX+B3X+Z46L4gYa01vQc0fhmyAo1fnTd7K0FBZ9dKeTOqpJlWZvqmGiJy1f5K0ER
4zFbfQp+ue2PBKtbxoYKaXHOtoqnNI0sbMVPEa669RMFCSPH9LPOomqYJK+RvknV
AqgxWxA/OeIcUhTOSfcoGbtzuPSsLcbF8GJTObdkiLPkzvz+CNi+7RSHToxwlY0C
AwEAATANBgkqhkiG9w0BAQsFAAOCAQEAmMCI4DDOZvk9QqiBp14OTdJslBTHSsfm
eo7oLrfHDUl7r1UDL+R858VJFTwiA388NYoOzv99nDdloTff+7hl4+e8lovYySDR
GXK8UE0GEheiukrnx2gJLyIPVRutiOlBoR2MTusFx3weTshQEu+O57dmCmCHdXWV
XMKz2oXKeelf84cp9O0rpWXuhl7Bp2Tfecs5P3QzIw27lPznVpY//TDKRQ5zhd3V
GtdI8OnsOuCMmBFnfgSsDT3VIf/usgvY2LDlfRJh74uqfALs9ahgI2t0X/xW7IBl
VVe4isaH4aGu7Q3n+AxVoIOrli7Nr52DpOQ26zJZecUQ8ZP32MnGyQ==
-----END CERTIFICATE-----
EOT
  ]
}

resource "vault_jwt_auth_backend_role" "app_role" {
  backend        = vault_jwt_auth_backend.psjwt.path
  role_name      = "role-${var.application_name}"
  token_policies = [vault_policy.app_policy.name]
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