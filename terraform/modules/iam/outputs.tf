output "role_name" {
  description = "Name of the Cassandra SSM IAM role"
  value       = aws_iam_role.cassandra_ssm.name
}

output "instance_profile_name" {
  description = "Name of the Cassandra EC2 instance profile"
  value       = aws_iam_instance_profile.cassandra_ssm.name
}
