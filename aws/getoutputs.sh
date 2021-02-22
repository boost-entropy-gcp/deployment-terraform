#!/bin/bash
# Deploy infrastructure
terraform init
terraform output private_key > id_rsa
terraform output ip > ip_address.txt

chmod 600 id_rsa
