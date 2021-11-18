terraform {
  required_version = "~>0.14"

}

provider "aws" {
  region              = "eu-west-1"
  allowed_account_ids = [var.account_id]
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/${var.tfm_x_acc_role_name}-${var.env}"
    session_name = "terraform"
  }
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/${var.tfm_x_acc_role_name}-${var.env}"
    session_name = "terraform"
  }
}

variable "env" { default = "dev" }
variable "tfm_x_acc_role_name" { default = "xops-tfm-adm-x-acc-role" }

# variable "account_id" { default = "333946375643" } #int-nwk
variable "account_id" { default = "061211638568" } #dev-infra 
# variable "account_id" { default = "669720269214" } # awsbeheer

variable "account_id_core_shared" { default = "086282490297" }

# provider "aws" {
#   alias                   = "core_shared"
#   region                  = "eu-west-1"
#   allowed_account_ids     = [var.account_id_core_shared]
#   shared_credentials_file = "~/.aws/credentials"
#   profile                 = "tfm-admin-shd"
# }
