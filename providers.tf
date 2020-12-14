provider "aws" {
  version = "~> 2.7"

  region              = "eu-west-1"
  allowed_account_ids = ["${local.account_id}"]

  assume_role {
    role_arn = "arn:aws:iam::${local.account_id}:role/go-agent"
  }
}
