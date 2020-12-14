terraform {
  required_version = "~> 0.13.2"

  backend "s3" {
    region               = "eu-west-1"
    bucket               = "ctm-terraform-state"
    key                  = "<DOMAIN.SERVICE>.tfstate"
    # workspace_key_prefix = "YOU_MUST_OVERRIDE_THIS_VALUE_VIA_THE_CLI"
    encrypt              = true
    acl                  = "bucket-owner-full-control"
    kms_key_id           = "arn:aws:kms:eu-west-1:482506117024:alias/terraform"
  }
}
