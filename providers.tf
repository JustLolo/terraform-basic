terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.0"
      #in a production environment you have to set a fixed version
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
  #if you are using environment variables and have set aws already don't need to set the following configuration

  #assuming you have configured aws cli already
  #shared_config_files      = [file("~/.aws/config")]
  #shared_credentials_files = [file("~/.aws/credentials")]




  #profile = "vscode"
  #just set the actual profile you are using in aws cli
  #if you want terraform uses the same actual profile as aws cli
  #you should use a variable pointing to the env variable AWS_PROFILE
}
