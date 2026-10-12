resource "aws_instance" "cassandra" {
  count = 3

  key_name             = "cassandra-bastion-key"
  ami                  = var.ami_id
  instance_type        = "t3.micro"
  iam_instance_profile = var.instance_profile_name

  subnet_id = count.index == 0 ? var.private_subnet_a_id : var.private_subnet_b_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-node-${count.index + 1}"
    Role = "cassandra"
  }
}
