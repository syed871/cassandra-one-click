
resource "aws_security_group" "bastion" {
  name        = "${var.project_name}-bastion-sg"
  description = "SSH access to bastion from my public IP only"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from my public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_cidrs
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-bastion-sg"
  }
}

resource "aws_security_group" "cassandra" {
  name        = "${var.project_name}-sg"
  description = "Security group for Cassandra cluster"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from bastion only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [
      aws_security_group.bastion.id
    ]
  }

  ingress {
    description = "Cassandra inter-node"
    from_port   = 7000
    to_port     = 7000
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Cassandra SSL inter-node"
    from_port   = 7001
    to_port     = 7001
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Cassandra CQL"
    from_port   = 9042
    to_port     = 9042
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Cassandra JMX"
    from_port   = 7199
    to_port     = 7199
    protocol    = "tcp"
    self        = true
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-sg"
  }
}
