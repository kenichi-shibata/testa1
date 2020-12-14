// https://github.com/terraform-linters/tflint/blob/master/docs/guides/config.md
config {
  module = false
  deep_check = false
  force = false
}

rule "terraform_deprecated_interpolation" {
  enabled = true
}
