data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "instances" {
  source = "./modules/instances"

  ami_id                = data.aws_ami.ubuntu.id
  project_name          = var.project_name
  instance_profile_name = module.iam.instance_profile_name
  private_subnet_a_id   = module.subnets.private_subnet_a_id
  private_subnet_b_id   = module.subnets.private_subnet_b_id
  security_group_id     = module.security_groups.security_group_id
}
