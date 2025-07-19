terraform {
  required_version = "~> 1.12.2"
  #   backend "s3" {
  #     bucket         = "input later"
  #     key            = "dev/state/terraform.tfstate"
  #     region         = "ap-southeast-2"
  #     use_lockfile = true
  #     encrypt = true
  #   }

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 6.0.0"
      configuration_aliases = [aws.dev]
    }
  }


}

provider "aws" {
  # Configuration options
  alias  = "dev"
  region = "ap-southeast-2" #sydney

  assume_role {
    role_arn = "arn:aws:iam::366483376693:role/OrganizationAccountAccessRole"
  }

  default_tags {
    tags = {
      OwnedBy     = "OilyGooseStudio"
      ManagedBy   = "Terraform"
      Environment = "Dev"
    }
  }
}

data "aws_caller_identity" "dev" {
  provider = aws.dev
}

module "remote_backend" {
  source = "git@github.com:AllainWoodsford/sports-warehouse-modules.git//s3/remote_backend?ref=v0.1.0"
  providers = {
    aws = aws.dev
  }
  #Input Variables
  bucket        = "og-sports-warehouse"
  bucket_suffix = "dev"
}