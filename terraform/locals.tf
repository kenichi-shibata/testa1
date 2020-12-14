locals {
  account_ids = {
    "dev" = "029718257588"
  }
  account_id = local.account_ids[var.account]
}
