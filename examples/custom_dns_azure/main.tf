module "cognito" {
  source = "git@bitbucket.org:ohpen-dev/terraform-aws-ohp-cognito-user-pool.git?ref=v0.1.0"

  user_pool_name           = local.name
  tags                     = local.tags
  clients                  = toset(local.clients)
  domain                   = "infra.dev.ohpen.tech"
  domain_hostname          = "auth"
  domain_certificate_arn   = module.acm.arn
  create_custom_dns_record = true
}

module "azure_idp" {
  source = "git@bitbucket.org:ohpen-dev/terraform-aws-ohp-cognito-idp.git//modules//azure?ref=v0.1.0"

  cognito_user_pool_id = module.cognito.id
  xml_metadata_file    = file("./oma_poc.xml")
  # xml_metadata_url = "https://login.microsoftonline.com/d7661b63-f3e7-470c-9d60-fd77e99f4bfc/federationmetadata/2007-06/federationmetadata.xml?appid=1c925009-4f79-4344-9932-cd15ab0f76de"
}

module "acm" {
  source = "git@bitbucket.org:ohpen-dev/terraform-aws-ohp-acm.git?ref=v0.1.0"
  providers = {
    aws = aws.us_east_1
  }

  domain_name = "infra.dev.ohpen.tech"
  host_name   = "auth"
  tags        = local.tags
}



locals {
  name = "test"
  tags = {
    name = "test"
  }
  clients = [
    {
      name                                 = "ohpen-api"
      refresh_token_validity               = 30
      generate_secret                      = false
      access_validity                      = 1
      id_token_validity                    = 1
      explicit_auth_flows                  = ["ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
      prevent_user_existence_errors        = "ENABLED"
      supported_identity_providers         = [module.azure_idp.name]
      callback_urls                        = ["https://openapi.portals.dev.ohpen.tech/"]
      logout_urls                          = ["https://openapi.portals.dev.ohpen.tech/"]
      allowed_oauth_flows_user_pool_client = true
      allowed_oauth_flows                  = ["code", "implicit"]
      allowed_oauth_scopes                 = ["phone", "email", "openid", "profile", "aws.cognito.signin.user.admin"]

      token_validity_units = {
        access_token  = "hours"
        id_token      = "hours"
        refresh_token = "days"
      }
    }
  ]
}

