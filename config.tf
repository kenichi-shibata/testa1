terraform {
  required_version = "~> 0.13.2"

  backend "s3" {
    region               = "eu-west-1"
    bucket               = "ctm-terraform-state"
    key                  = "<YOUR_SERVICE>.tfstate"
    workspace_key_prefix = "<YOUR_DOMAIN>"
    encrypt              = true
    acl                  = "bucket-owner-full-control"
    kms_key_id           = "arn:aws:kms:eu-west-1:482506117024:alias/terraform"
  }
}
