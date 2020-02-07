#!/bin/bash

vault login -method=userpass username=ct-eg-1 password=password

# Attempt to issue cert for subdomain
vault write pki_int/issue/ct-eg-1 common_name="test.colinturney.me" ttl="24h"

# Attempt to issue cert for different domain
vault write pki_int/issue/example-eg-1 common_name="test.example.com" ttl="24h"
