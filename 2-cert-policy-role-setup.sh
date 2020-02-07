#!/bin/bash

vault auth enable userpass

# example-eg-1:
# allowed_domains = example.com
# allowed_subdomains = yes
# all other options are defaults

vault write pki_int/roles/example-eg-1 \
  allowed_domains="example.com" \
  allow_subdomains=true \
  max_ttl="720h"

  cat <<EOF > example-eg-1.hcl

  path "pki_int/issue/example-eg-1" {
    capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
  }
EOF

vault policy write example-eg-1 example-eg-1.hcl

vault write auth/userpass/users/example-eg-1 \
  password=password \
  policies=example-eg-1

# ct-eg-1:
# allowed_domains = colinturney.me
# allowed_subdomains = yes
# all other options are defaults

vault write pki_int/roles/ct-eg-1 \
  allowed_domains="colinturney.me" \
  allow_subdomains=true \
  max_ttl="720h"

  cat <<EOF > ct-eg-1.hcl

  path "pki_int/issue/ct-eg-1" {
    capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
  }
EOF

vault policy write ct-eg-1 ct-eg-1.hcl

vault write auth/userpass/users/ct-eg-1 \
  password=password \
  policies=ct-eg-1

# example-eg-2:
# allowed_domains = example.com
# allowed_subdomains = no
# allow_bare_domains = true
# all other options are defaults

vault write pki_int/roles/example-eg-2 \
  allowed_domains="example.com" \
  allow_subdomains=false \
  allow_bare_domains=true \
  max_ttl="720h"

  cat <<EOF > example-eg-2.hcl

  path "pki_int/issue/example-eg-2" {
    capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
  }
EOF

vault policy write example-eg-2 example-eg-2.hcl

vault write auth/userpass/users/example-eg-2 \
  password=password \
  policies=example-eg-2

# ct-eg-2:
# allowed_domains = colinturney.me
# allowed_subdomains = no
# allow_bare_domains = true
# all other options are defaults

vault write pki_int/roles/ct-eg-2 \
  allowed_domains="colinturney.me" \
  allow_subdomains=false \
  allow_bare_domains=true \
  max_ttl="720h"

  cat <<EOF > ct-eg-2.hcl

  path "pki_int/issue/ct-eg-2" {
    capabilities = [ "create", "read", "update", "delete", "list", "sudo" ]
  }
EOF

vault policy write ct-eg-2 ct-eg-2.hcl

vault write auth/userpass/users/ct-eg-2 \
  password=password \
  policies=ct-eg-2
