module "networking" {
  source       = "./modules/networking"
  project_name = var.project_name

  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = aws_internet_gateway.cassandra.id

  public_subnet_a_id  = module.subnets.public_subnet_a_id
  public_subnet_b_id  = module.subnets.public_subnet_b_id
  private_subnet_a_id = module.subnets.private_subnet_a_id
  private_subnet_b_id = module.subnets.private_subnet_b_id

  depends_on = [aws_internet_gateway.cassandra]
}
