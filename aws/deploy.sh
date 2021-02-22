#!/bin/bash
# Deploy infrastructure
terraform init
terraform apply -auto-approve
terraform output private_key > id_rsa
chmod u+x id_rsa
chmod 600 id_rsa
