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

You can also create via the gcloud command:

1. Initialize gcloud selecting the current project:
```bash
gcloud init
```

2. Create a service account, selecting the role:
```bash
gcloud iam service-accounts create SERVICE_ACCOUNT_ID \
    --description="DESCRIPTION" \
    --display-name="DISPLAY_NAME"

gcloud projects add-iam-policy-binding PROJECT_ID \
    --member="serviceAccount:SERVICE_ACCOUNT_ID@PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/editor"
```
Example:
```bash
gcloud iam service-accounts create terraform \         
     --description="Service account to deploy with terraform" \
     --display-name="Terraform"   

gcloud projects add-iam-policy-binding project --member="serviceAccount:terraform@project.iam.gserviceaccount.com" --role="roles/editor"
```

3. Download a service account key:
```bash
gcloud iam service-accounts keys create key.json \
  --iam-account sa-name@project-id.iam.gserviceaccount.com
```

Example:
```bash
cloud iam service-accounts keys create key.json \
  --iam-account terraform@project.iam.gserviceaccount.com
```

This file should be downloaded as JSON, and then used as environment variable
when deploying locally.

Unfortunately, for the terraform cloud backend, this is not enough as you should use
an environment variable with this information.
For this you could perform the following.

1. Create an environment variable in the terraform cloud configuration with the
	 name `GOOGLE_CREDENTIALS`
2. Copy the contents of the JSON file in this
	 variable.

