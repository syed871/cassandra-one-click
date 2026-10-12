variable "ami_id" {
  description = "Ubuntu AMI ID"
  type        = string
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name"
  type        = string
}

variable "private_subnet_a_id" {
  description = "First private subnet ID"
  type        = string
}

variable "private_subnet_b_id" {
  description = "Second private subnet ID"
  type        = string
}

variable "security_group_id" {
  description = "Cassandra security group ID"
  type        = string
}
