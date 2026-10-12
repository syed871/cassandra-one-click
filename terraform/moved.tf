moved {
  from = aws_vpc.cassandra
  to   = module.vpc.aws_vpc.cassandra
}

moved {
  from = aws_subnet.public_a
  to   = module.subnets.aws_subnet.public_a
}

moved {
  from = aws_subnet.public_b
  to   = module.subnets.aws_subnet.public_b
}

moved {
  from = aws_subnet.private_a
  to   = module.subnets.aws_subnet.private_a
}

moved {
  from = aws_subnet.private_b
  to   = module.subnets.aws_subnet.private_b
}

moved {
  from = aws_eip.nat
  to   = module.networking.aws_eip.nat
}

moved {
  from = aws_nat_gateway.cassandra
  to   = module.networking.aws_nat_gateway.cassandra
}

moved {
  from = aws_route_table.public
  to   = module.networking.aws_route_table.public
}

moved {
  from = aws_route_table.private
  to   = module.networking.aws_route_table.private
}

moved {
  from = aws_route_table_association.public_a
  to   = module.networking.aws_route_table_association.public_a
}

moved {
  from = aws_route_table_association.public_b
  to   = module.networking.aws_route_table_association.public_b
}

moved {
  from = aws_route_table_association.private_a
  to   = module.networking.aws_route_table_association.private_a
}

moved {
  from = aws_route_table_association.private_b
  to   = module.networking.aws_route_table_association.private_b
}

moved {
  from = aws_security_group.cassandra
  to   = module.security_groups.aws_security_group.cassandra
}



moved {
  from = aws_iam_role.cassandra_ssm
  to   = module.iam.aws_iam_role.cassandra_ssm
}

moved {
  from = aws_iam_role_policy_attachment.cassandra_ssm
  to   = module.iam.aws_iam_role_policy_attachment.cassandra_ssm
}

moved {
  from = aws_iam_instance_profile.cassandra_ssm
  to   = module.iam.aws_iam_instance_profile.cassandra_ssm
}

moved {
  from = aws_instance.cassandra
  to   = module.instances.aws_instance.cassandra
}
