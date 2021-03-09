# Deploying to GCP

To deploy in Google Cloud Platform there are several guides. A complete
reference for this provider could be found at [Google Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs).

In this case, you should have installed the gcloud command.
For Archlinux, the command to install it is:
```
yay -S google-cloud-sdk
```

To access the resources in google cloud you should create a credentials file,
at [Create service account file](https://cloud.google.com/iam/docs/creating-managing-service-account-keys).

This file should be downloaded as JSON, and then used as enviroment variable
when deploying locally.

Unfortunately, for the terraform backend, this is not enough as you should use
a environment variable with this information.
For this you could perform the following.

1. Create a environment variable in the terraform cloud configuration with the
	 name `CREDENTIALS_GOOGLE`
2. Copy the contents of the JSON file in this
	 variable.

