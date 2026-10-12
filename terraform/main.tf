data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
}
