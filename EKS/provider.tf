terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.21.0"
    }
  }
}

provider "aws" {
region = var.region
}


backend "s3" {
    bucket         	   = "eks-tfstate"
    key                = "state/terraform.tfstate"
    region         	   = var.region
    encrypt        	   = true
    dynamodb_table     = "eksstate_tf_lockid"
  }
}


data "aws_availability_zones" "azs" {}


