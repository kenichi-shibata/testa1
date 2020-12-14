# Everything in the feature is in a single file
data "aws_route53_zone" "ctmers" {
  # count toggles the feature
  count = terraform.workspace == "main" ? 1 : 0
  name  = "ctmers.io."
}

module "acm_ctmers" {
  create_certificate = terraform.workspace == "main" ? 1 : 0

  # using modules is desired
  source  = "terraform-aws-modules/acm/aws"
  version = "~> v1.0"

  domain_name = "*.ctmers.io"
  zone_id     = join("", data.aws_route53_zone.ctmers.*.zone_id)

  wait_for_validation = true

  tags = merge(local.default_tags, {
    Name = "ctmers.io wildcard"
  })
}
