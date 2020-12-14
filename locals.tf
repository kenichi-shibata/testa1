locals {
  account = {
    "main"               = "482506117024"
    "development"        = "029718257588"
    "data-store-dev"     = "803282121149"
    "nonproduction"      = "038452852957"
    "data-store-nonprod" = "873030778727"
    "production"         = "631977481591"
    "data-store-prod"    = "922545523820"
    "disaster-recovery"  = "207498761283"
    "data-store-dr"      = "966417984793"
    "data-nonprod"       = "207220154943"
    "data-prod"          = "077201780497"
    "paas-nonprod"       = "650525879627"
    "paas-prod"          = "652661650227"
    "sso"                = "038084509188"
    "labs"               = "065106232109"
    "backup"             = "935037204433"
    "security"           = "985138771065"
  }

  account_id = local.account[terraform.workspace]

  default_tags = {
    Name                   = "home.risk-validation.prod"
    environment            = "prod"
    owner                  = "DG-CTM-ITHome@bglgroup.co.uk"
    domain                 = "home"
    service                = "home.risk-validation"
    costcenter             = "421"
    protectfromtermination = "true"
    reason                 = "DVSUPPORT-1000"
    terraform              = "https://github.com/ComparetheMarket/engineering.terraform-boilerplate/tree/some-path/"
  }
}
