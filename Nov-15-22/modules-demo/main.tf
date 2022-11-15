provider "aws" {
  region = "ap-south-1"
}

module "ntier_aws" {
    source              = "./modules/ntier_aws"
}
