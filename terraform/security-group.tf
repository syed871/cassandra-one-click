module "security_groups" {
  source = "./modules/security-groups"

  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  ssh_allowed_cidrs = ["157.50.149.10/32"]
}
