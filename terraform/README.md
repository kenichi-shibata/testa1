# Terraform Features

You can create whatever resources you want except the following:
* [S3 buckets and policies](https://github.com/ComparetheMarket/infrastructure.terraform-s3)
* [IAM roles and policies](https://github.com/ComparetheMarket/account-infrastructure/tree/master/iam/service-permissions)

# Resource names

All resources should be suffixed with the workspace eg. `the-great-bucket-worker-${terraform.workspace}`


# How to deploy

See `feature.gocd.yaml`

```
TERRAFORM_VERSION=0.13.2
ACCOUNT=dev
ENVIRONMENT=shared

export TF_VAR_account=$ACCOUNT # must be exported for docker

# Initialise with the correct `workspace_key_prefix`
docker run -v $PWD:/usr/src -w /usr/src/terraform -u 998:998 hashicorp/terraform:$TERRAFORM_VERSION init -backend-config="workspace_key_prefix=$ACCOUNT"

# Select or create workspace
docker run -v $PWD:/usr/src -w /usr/src/terraform -u 998:998 hashicorp/terraform:$TERRAFORM_VERSION workspace select $ENVIRONMENT || docker run -v $PWD:/usr/src -w /usr/src/terraform -u 998:998 hashicorp/terraform:$TERRAFORM_VERSION workspace new $ENVIRONMENT

# Terraforn Plan
docker run -v $PWD:/usr/src -w /usr/src/terraform -e TF_VAR_account -u 998:998 hashicorp/terraform:$TERRAFORM_VERSION plan -out=plan.out -input=false

# Tar `.terraform` to preserve unix permissions for later stages (native artifact store uses zip, which doesn't work)
tar -zcf terraform.tgz terraform/.terraform

# Restore `.terraform`
tar -xzf terraform.tgz 

# Terraform Apply from Plan
docker run -v $PWD:/usr/src -w /usr/src/terraform -e TF_VAR_account -u 998:998 hashicorp/terraform:$TERRAFORM_VERSION apply -auto-approve -input=false plan.out
```

## Notes on terraform in docker

* `-v $PWD:/usr/src` shares whole repo - required because sometimes you link to external resources from terraform
* `-w /usr/src/terraform` set `/terraform` as the working directory
* `-u 998:998` execute as GoCD users, so that it can tidy up afterwards without permissions issues
* `-e TF_VAR_account` set your terraform variables