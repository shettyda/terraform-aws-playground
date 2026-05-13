terraform {

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "6.43.0"
    }

    github = {
      source  = "integrations/github"
      version = "6.12.1"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

provider "github" {

}