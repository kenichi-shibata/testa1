# engineering.terraform-boilerplate

# Introduction
The aim of this terraform-boilerplate, is to provide a GitHub Repo Template for future terraform projects. We are **not**
attempting to remake the wheel or diverge from the [Official Best Practices](https://www.terraform.io/docs/extend/best-practices)
and [Non-Official Best Practices](https://www.terraform-best-practices.com). It is a given that you are current and familiar with them.


# How to use this template
* Click "Use this template" above. https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template
* Delete any directories/features you don't with to use


# State files

State files are stored in `s3://ctm-terraform-state` in the `main` account. Our naming strategy is:

```
s3://bucket/workspace_key_prefix/workspace_name/key
s3://ctm-terraform-state/ACCOUNT/ENVIRONMENT/DOMAIN.SERVICE.tfstate
s3://ctm-terraform-state/nonprod/test/domain.service.tfstate
s3://ctm-terraform-state/nonprod/shadow/domain.service.tfstate
s3://ctm-terraform-state/prod/prod/domain.service.tfstate
s3://ctm-terraform-state/paas-prod/prod/domain.service.tfstate
s3://ctm-terraform-state/main/shared/networking.tfstate
```

**Note: this naming strategy only works if you specify an `environment/workspace`, so in the absence of an environment use `shared` NOT `default`.**

# Versions
This boilerplate supports `>= 0.12`. It is recommended that you use `~> 0.13.2`, however you need to consider if you have to share state with previous versions
of terraform. If you do, you need to use the lowest common version. This boilerplate does not support `<=0.11.x`.

# Accounts
The account will be specified using the `account` varaible, which will be the human readable account name with `ctm-` stripped. eg. `data-nonprod`.

The account name can be specified as an environment variable `TF_VAR_account=data-nonprod`.

@todo A script will be made to create the `locals { account { } }` map.

```
locals {
  account = {
    "main"       = "482506117024"
    "..."        = "..."
  }
  account_id = local.account[var.account]
}
```


# Workspaces
Workspaces are used to specify environments `shadow`, `test`, `load` etc. within the same account `nonprod`.

If you're working on something generic or doesn't require an environment, use the `shared` workspace.


# Root input variables
Do not use root input variables unless absolutely necessary. `locals` are favoured over `variable`s.

It is desired that the run commands will be a simple as (with plan files for CI):

```
export TF_VAR_account=main
terraform workspace select shadow || terraform workspace new shadow
terraform apply
```


# Using terraform within a software project
When embedding terraform within a software project follow the `/terraform` layout in the root of your project. All the terraform is to be self-contained here.
You must also set your repository with the `terraform` topic, so that it can be discoverable later. See https://docs.github.com/en/github/administering-a-repository/classifying-your-repository-with-topics


# Toggling environments
Using `count` attribute to toggle resources in accounts is acceptable

```
resource "x" "y" {
    count = terraform.workspace == "main" ? 1 : 0
}
```


# Group features
Group features together. eg. a DNS validation resource can sit next to associated resource, not in DNS. See [ctmers_certificate.tf](ctmers_certificate.tf)


# Naming
Use underscores in variable and resource names

```
resource "x" "my_resource_name" {}
```

# Tags
See governance at for required tags: https://github.com/ComparetheMarket/architecture.governance/blob/master/governance/standards/infrastructure/guidance-tagging.md

Configure your project's default tags at `00-variables.tf`

And apply them via:

```
  tags = "${merge(local.default_tags, {
    Name      = "ctmers.io wildcard"
  })}"
```

# Using 3rd party modules
Use of 3rd party modules is preferable where the quality can be relyed upon. https://github.com/terraform-aws-modules are semi-official

# JSON and policies should be external
See terraform/templates/cloudwatch.json

Large policies and templates should be stored with an appropriate extension and loaded using `templatefile` function or similar.


# Using modules


# Testing
TFLint
Perhaps use https://github.com/gruntwork-io/terratest
