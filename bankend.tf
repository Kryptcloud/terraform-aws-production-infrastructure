terraform {
  backend "s3" {
    bucket = "terraform-prod-state-bucket-486753526260-eu-north-1-an"
    key = "prod/terraform.tfstate"
    region = "eu-north-1"
    use_lockfile = true
  encrypt = true
  }
}
