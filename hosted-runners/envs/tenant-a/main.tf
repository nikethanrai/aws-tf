terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
    backend "s3" {
        bucket = "tf-state-105003116761-ap-southeast-2"
        key = "hosted-runners/envs/tenant-a/terraform.tfstate"
        region = "ap-southeast-2"
        dynamodb_table = "tf-state-lock"
      
    }
}
provider "aws" {
  region = "ap-southeast-2"

}

module "network" {
    source = "../../modules/network"
    name_prefix = "tenant-a"
  
}

module "runner" {
  source = "../../modules/runner"
  name_prefix = "tenant-a"
  private_subnet_id = module.network.private_subnet_id
  max_size = 1
  desired_capacity = 1
  
}
