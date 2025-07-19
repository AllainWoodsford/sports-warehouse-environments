terraform {
  required_version = "~> 1.12.2"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 6.0.0"
      configuration_aliases = [aws.dev, aws.test, aws.prod]
    }
  }
}

# Dev Provider Alias
provider "aws" {
  # Configuration options
  alias  = "dev"
  region = "ap-southeast-2" #sydney

  assume_role {
    role_arn = "arn:aws:iam:366483376693:role/OrganizationAccountAccessRole"
  }

  default_tags {
    tags = {
      OwnedBy     = "OilyGooseStudio"
      ManagedBy   = "Terraform"
      Environment = "Dev"
    }
  }
}

# Test Provider Alias
provider "aws" {
  # Configuration options
  alias  = "test"
  region = "ap-southeast-2" #sydney

  assume_role {
    role_arn = "arn:aws:iam:253157412494:role/OrganizationAccountAccessRole"
  }

  default_tags {
    tags = {
      OwnedBy     = "OilyGooseStudio"
      ManagedBy   = "Terraform"
      Environment = "Test"
    }
  }
}

provider "aws" {
  # Configuration options
  alias  = "prod"
  region = "ap-southeast-2" #sydney

  assume_role {
    role_arn = "arn:aws:iam:430730481777:role/OrganizationAccountAccessRole"
  }

  default_tags {
    tags = {
      OwnedBy     = "OilyGooseStudio"
      ManagedBy   = "Terraform"
      Environment = "Production"
    }
  }
}

# Data
data "aws_caller_identity" "dev" {
  provider = aws.dev
}
data "aws_caller_identity" "test" {
  provider = aws.test
}
data "aws_caller_identity" "prod" {
  provider = aws.prod
}




