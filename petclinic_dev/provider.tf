#terraform {
# required_providers {
#  aws = {
#   source = "hashicorp/aws"
#  version = "3.52.0"
# region = var.region
# }
# }
# }

provider "aws" {
  # Configuration options
  region = var.region
}
