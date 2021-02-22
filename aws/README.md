# Deploying in AWS.

To deploy in AWS is required to have installed the client of AWS.

In case of archlinux the installation process is:

```
yay -S aws-cli
```

When the cli tool is installed you could perform:
```
aws --version
```
This is for the cli version 1, you can also install the version 2 with:

```
yay -S aws-cli-v2-bin
```

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
