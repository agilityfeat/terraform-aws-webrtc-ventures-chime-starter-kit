terraform {
  /* backend "s3" {
    bucket  = "chimestarterkit-iac-state"
    encrypt = true
    key     = "terraform.tfstate"
    region  = "us-east-1"
  } */
  backend "local" {
    path = "./.terraform.tfstate"
  }
}
