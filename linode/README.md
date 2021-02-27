# Deploying in Linode.

An important guide about this process is [ A Beginner's Guide to Terraform ](https://www.linode.com/docs/guides/beginners-guide-to-terraform/)

To deploy in Linode you should have an API Key. To get this API key you should
get from the panel control from Linode.

In addition to this it may be useful to have configured the linode-cli in you
setup to get information from linode. The instalation process in Archlinux is:
```
yay -S linode-cli
```

It installs the linode-cli from the AUR repository. Then perform:
```
linode-cli configure
```
It asks by an API-TOKEN, which could be obtained from the Linode console
interface.


## Get list of images
To get the list of images in linode, you could use the `linode-cli` software by
the next command:
```
linode-cli images list
```

## Getting private_key from the deployment
To save the private_key, perform:
```
terraform output private_key > id_rsa

chmod u+x id_rsa
chmod 600 id_rsa
```

To use with the terraform cloud backend you should login:
```
terraform login
```
and then enter the token provided. For security the keys entered are hidden,
make to copy only once, because you do not have a visual feedback.

After that you could init the terraform and get the keys.
