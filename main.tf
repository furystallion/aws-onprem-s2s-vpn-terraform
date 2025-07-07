provider "aws" {
  region = var.region
}

locals {
  tags = {
    terraform = "true"
  }
}
