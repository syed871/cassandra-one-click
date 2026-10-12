resource "aws_internet_gateway" "cassandra" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "${var.project_name}-igw"
  }
}
