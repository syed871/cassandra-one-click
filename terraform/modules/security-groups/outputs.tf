output "security_group_id" {
  description = "Cassandra security group ID"
  value       = aws_security_group.cassandra.id
}

output "bastion_security_group_id" {
  description = "Bastion security group ID"
  value       = aws_security_group.bastion.id
}
