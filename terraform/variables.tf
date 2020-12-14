variable "account" {
  type        = string
  description = "Account name minus the `ctm-` prefix"
}

variable "data_bucket_name" {
  type    = string
  default = "some_bucket_name"
}

variable "data_account_id" {
  type    = string
  default = "029718257588"
}