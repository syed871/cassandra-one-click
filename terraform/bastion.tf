
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  subnet_id                   = module.subnets.public_subnet_a_id
  vpc_security_group_ids      = [module.security_groups.bastion_security_group_id]
  key_name                    = "cassandra-bastion-key"
  associate_public_ip_address = true

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project_name}-bastion"
    Role = "bastion"
  }
}
