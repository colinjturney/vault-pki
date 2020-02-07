#!/bin/bash

vault login -method=userpass username=example-eg-2 password=password

# Attempt to issue cert for bare domain - Should pass
vault write pki_int/issue/example-eg-2 common_name="example.com" ttl="24h"

# Attempt to issue cert for subdomain - Should fail
vault write pki_int/issue/example-eg-2 common_name="test.example.com" ttl="24h"
