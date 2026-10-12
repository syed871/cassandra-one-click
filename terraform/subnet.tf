module "subnets" {
  source       = "./modules/subnets"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
}
