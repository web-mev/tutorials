terraform {
  required_version = ">= 1.2.6, <2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket               = "webmev-tf"
    key                  = "tutorials/tf.state"
    region               = "us-east-2"
  }
}

locals {
  common_tags = {
    Name      = "mev-tutorial"
    Project   = "WebMEV"
    Terraform = "True"
  }
}

provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = local.common_tags
  }
}
