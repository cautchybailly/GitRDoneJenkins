# Backend bucket configuration for Terraform state storage
terraform {
  backend "s3" {
    bucket  = "saba-jenkins-bucket"
    key     = "saba-jenkins-bucket/gutcheck/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
