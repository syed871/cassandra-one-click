output "instance_ids" {
  description = "Cassandra EC2 instance IDs"
  value       = aws_instance.cassandra[*].id
}

output "private_ips" {
  description = "Private IP addresses of Cassandra nodes"
  value       = aws_instance.cassandra[*].private_ip
}
