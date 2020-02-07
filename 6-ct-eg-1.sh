#!/bin/bash

vault login -method=userpass username=ct-eg-2 password=password

# Attempt to issue cert for bare domain - Should pass
vault write pki_int/issue/ct-eg-2 common_name="colinturney.me" ttl="24h"

# Attempt to issue cert for subdomain - Should fail
vault write pki_int/issue/ct-eg-2 common_name="test.colinturney.me" ttl="24h"
