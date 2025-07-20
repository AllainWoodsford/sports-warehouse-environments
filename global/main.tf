terraform {
  required_version = "~> 1.12.2"
  backend "s3" {
    bucket       = "og-sports-warehouse-networking"
    key          = "state/terraform.tfstate"
    region       = "ap-southeast-2"
    use_lockfile = true
    encrypt      = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0.0"
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
#Implement backend
# module "remote_backend" {
#   source = "git@github.com:AllainWoodsford/sports-warehouse-modules.git//s3/remote_backend_destroyable?ref=v0.1.8"
#   #Input Variables
#   user_arn       = "arn:aws:iam::547610822592:user/terraform-user"
#   lock_file_path = "state/terraform.tfstate.tflock"
#   bucket         = "og-sports-warehouse"
#   bucket_suffix  = "networking"
# }

resource "aws_instance" "instance" {
  ami           = "ami-00839deb72faa8a04"
  instance_type = "t2.micro"
}
resource "aws_instance" "instance2" {
  ami           = "ami-00839deb72faa8a04"
  instance_type = "t2.micro"
}

# resource "aws_route53_zone" "main" {
#   name = "sportswarehouse.xyz"
# }

# ##DEV Environment
# resource "aws_route53_zone" "dev" {
#   name = "dev.sportswarehouse.xyz"

#   tags = {
#     Environment = "dev"
#   }
# }
# resource "aws_route53_record" "dev-ns" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = "dev.sportswarehouse.xyz"
#   type    = "NS"
#   ttl     = "30"
#   records = aws_route53_zone.dev.name_servers
# }

# ##TEST Environment
# resource "aws_route53_zone" "test" {
#   name = "test.sportswarehouse.xyz"

#   tags = {
#     Environment = "test"
#   }
# }
# resource "aws_route53_record" "test-ns" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = "test.sportswarehouse.xyz"
#   type    = "NS"
#   ttl     = "30"
#   records = aws_route53_zone.test.name_servers
# }

# ##PROD Environment
# resource "aws_route53_zone" "prod" {
#   name = "prod.sportswarehouse.xyz"

#   tags = {
#     Environment = "prod"
#   }
# }
# resource "aws_route53_record" "prod-ns" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = "prod.sportswarehouse.xyz"
#   type    = "NS"
#   ttl     = "30"
#   records = aws_route53_zone.prod.name_servers
# }



