terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "2.2.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}
provider "aws" {
  profile = "terraform"
  region  = var.region
}


