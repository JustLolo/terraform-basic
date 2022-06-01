terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.0"
      #in a production environment you have to fix version
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
  #shared_credentials_files = ["~/Arnaldo/.aws/credentials"]
  #shared_config_files      = [file("~/.aws/config")]
  shared_credentials_files = [file("~/.aws/credentials")]

  profile = "vscode"
}