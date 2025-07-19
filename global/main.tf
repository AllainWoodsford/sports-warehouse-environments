terraform {
  required_version = "~> 1.12.2"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 6.0.0"
     ## configuration_aliases = [aws.dev]
      
    }
  }
}

provider "aws" {
    region = "ap-southeast-2" #sydney
    #deploys into networking account
    assume_role {
    role_arn = "arn:aws:iam::349960126574:role/OrganizationAccountAccessRole"
  }
   default_tags {
    tags = {
      OwnedBy     = "OilyGooseStudio"
      ManagedBy   = "Terraform"
      Environment = "networking"
    }
   }
}

resource "aws_route53_zone" "main" {
  name = "sportswarehouse.xyz"
}

##DEV Environment
resource "aws_route53_zone" "dev" {
  name = "dev.sportswarehouse.xyz"

  tags = {
    Environment = "dev"
  }
}
resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dev.sportswarehouse.xyz"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.dev.name_servers
}

##TEST Environment
resource "aws_route53_zone" "test" {
  name = "test.sportswarehouse.xyz"

  tags = {
    Environment = "test"
  }
}
resource "aws_route53_record" "test-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "test.sportswarehouse.xyz"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.test.name_servers
}

##PROD Environment
resource "aws_route53_zone" "prod" {
  name = "prod.sportswarehouse.xyz"

  tags = {
    Environment = "prod"
  }
}
resource "aws_route53_record" "prod-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "prod.sportswarehouse.xyz"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.prod.name_servers
}