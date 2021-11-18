# Terraform Module - Cognito User Pools

[![license](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/ohpensource/terraform-aws-ohp-cognito-user-pool/continuous-delivery)

![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/ohpensource/terraform-aws-ohp-cognito-user-pool)

## Maintainer

* Platform Services

## Author

* Rupert Broad (based on https://github.com/lgallard/terraform-aws-cognito-user-pool)

## Description

Creates a Cognito User Pool. If custom DNS name for the authentication endpoint is required then you will also need to create an ACM certificate in us-east-1. This can be done with the terraform-aws-ohp-acm module and an additional provider for the us-east-1 region.

Cognito Identity Providers (IdPs), e.g. Azure can be added using the terraform-aws-ohp-cognito-idp module.

## Documentation

Describe how to use your module here.
[confluence](https://ohpendev.atlassian.net/wiki/spaces/CCE/pages/2062320795/Terraform+Modules)

## Usage

See examples folder

<!--- BEGIN_TF_DOCS --->
<!--- END_TF_DOCS --->
