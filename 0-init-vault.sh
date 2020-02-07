#!/bin/bash

# Initialise Vault. Store keys locally FOR DEMO PURPOSES ONLY

vault operator init -key-shares=1 -key-threshold=1 > init-output.txt 2>&1

echo "Unseal: "$(grep Unseal init-output.txt | cut -d' ' -f4) >> vault.txt
echo "Token: "$(grep Token init-output.txt | cut -d' ' -f4) >> vault.txt
rm init-output.txt

# Unseal Vault
vault operator unseal $(cat vault.txt | grep Unseal | cut -f2 -d' ')

# Login to Vault
vault login $(cat vault.txt | grep Token | cut -f2 -d' ')

# Enable the PKI engine

vault secrets enable pki

# Tune the PKI secrets engine to issue certificates with a maximum time-to-live (TTL) of 87600hrs

vault secrets tune -max-lease-ttl=87600h pki

# Enable PKI intermediate ca engine

vault secrets enable -path=pki_int pki

vault secrets tune -max-lease-ttl=43800h pki_int
