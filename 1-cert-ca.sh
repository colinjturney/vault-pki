#!/bin/bash

#### Generate root cert and intermediary CA for example.com

# Generate the root cert and save it in CA_cert.crt

vault write -field=certificate pki/root/generate/internal \
  common_name="example.com" \
  ttl=87600h > CA_cert.crt

# Configure the CA and CRL URLs

vault write pki/config/urls \
  issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" \
  crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl"

# Generate an intermediate and save CSR

vault write -format=json pki_int/intermediate/generate/internal \
  common_name="example.com Intermediate Authority" \
  | jq -r '.data.csr' > pki_intermediate.csr

# Sign the intermediate with the root and save it the generated cert

vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \
  format=pem_bundle ttl="43800h" \
  | jq -r '.data.certificate' > intermediate.cert.pem

# Import signed intermediate cert back into Vault.

vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem

#### Generate root cert and intermediary CA for colinturney.me

# Generate the root cert and save it in CA_cert.crt

vault write -field=certificate pki/root/generate/internal \
  common_name="colinturney.me" \
  ttl=87600h > ct_CA_cert.crt

# Configure the CA and CRL URLs

vault write pki/config/urls \
  issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" \
  crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl"

# Generate an intermediate and save CSR

vault write -format=json pki_int/intermediate/generate/internal \
  common_name="colinturney.me Intermediate Authority" \
  | jq -r '.data.csr' > ct_pki_intermediate.csr

# Sign the intermediate with the root and save it the generated cert

vault write -format=json pki/root/sign-intermediate csr=@ct_pki_intermediate.csr \
  format=pem_bundle ttl="43800h" \
  | jq -r '.data.certificate' > ct_intermediate.cert.pem

# Import signed intermediate cert back into Vault.

vault write pki_int/intermediate/set-signed certificate=@ct_intermediate.cert.pem
