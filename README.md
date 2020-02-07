# Vault PKI Demo

The code in this demo will build a single Vault server, backed by a 3-node Consul Cluster for Storage Backend. The aim of this is to demo how you could use the PKI secrets engine to create a root CA and an intermediary CA within Vault, to generate self-signed certificates that could be used for TLS.

## Important Notes

1. **Note:** As of 2nd January 2019, there is an incompatibility between Vagrant 2.2.6 and Virtualbox 6.1.X. Until this incompatibility is fixed, it is recommended to run Vagrant with Virtualbox 6.0.14 instead.

2. **Note:** This demo aims to demonstrate Vault's PKI engine. It does **not** intend to demonstrate how to build a Vault and Consul deployment according to any recommended architecture, nor does it intend to demonstrate any form of best practice. Amongst many other things, you should always enable ACLs, configure TLS and never store your Vault unseal keys or tokens on your Vault server!

## Requirements
* The VMs created by the demo will consume a total of 2GB memory.
* The demo was tested using Vagrant 2.2.6 and Virtualbox 6.0.14

## What is built?

The demo will build the following Virtual Machines:
* **vault-server**: A single Vault server
* **consul-{1-3}-server**: A cluster of 3 Consul servers within a single Datacenter

## Provisioning scripts
The following provisioning scripts will be run by Vagrant:
* install-consul.sh: Automatically installs and configures Consul 1.6.2 (open source) on each of the consul-{1-3}-server VMs. A flag allows it to configure a consul client on the Vault VM too.
* install-vault.sh: Automatically installs and configures Vault 1.3.0 (open source) on the Vault server.

## Additional files
The following additional files are also included and should be copied onto the VM from the /vagrant directory and run in numerical order:
* 0-init-vault.sh: Needs to be run as a manual step to initialise and unseal Vault, logging in using the root token and enable the PKI secrets engine.
* 1-cert-ca.sh: Generate a root and intermediary CA for both example.com and colinturney.me
* 2-cert-policy-role-setup.sh: Generate PKI roles, policies and userpass users that can generate certificates.
* 3-example-eg-1: Script to attempt to generate certs. One attempt will pass, the other will fail due to policy or role configurations.
* 4-ct-eg-1: Script to attempt to generate certs. One attempt will pass, the other will fail due to policy or role configurations.
* 5-example-eg-2: Script to attempt to generate certs. One attempt will pass, the other will fail due to policy or role configurations.
* 6-ct-eg-2: Script to attempt to generate certs. One attempt will pass, the other will fail due to policy or role configurations.

## How to get started
Once Vagrant and Virtualbox are installed, to get started just run the following command within the code directory:
```
vagrant up
```
Once vagrant has completely finished, run the following to SSH onto the vault server
```
vagrant ssh vault-server
```
Once SSH'd onto vault-server, run the following commands in sequence:
```
cp /vagrant/{0,1,2,3,4,5}*.sh . ;
chmod 744 {0,1,2,3,4,5)*.sh ;
./0-init-vault.sh ;
```
This will create a file called vault.txt in the directory you run the script in. The file contains a single Vault unseal key and root token, in case you wish to seal or unseal vault in the future. Of course, in a real-life scenario these files should not be generated automatically and not be stored on the vault server.

You can then simply run each script following `0-init-vault.sh` in numerical order to configure Vault's DB secrets engine.

Once everything is built, you should be able to access the following UIs at the following addresses:

* Consul UI: http://10.0.0.11:7500/ui/

If you're having problems, then check your Virtualbox networking configurations. They should be set to the default of NAT. If problems still persist then you might be able to access the UIs via the port forwarding that has been set up- check the Vagrantfile for these ports.

## Support
No support or guarantees are offered with this code. It is purely a demo.

## Future Improvements
* Use Docker containers instead of VMs.
* Other suggested future improvements very welcome.
