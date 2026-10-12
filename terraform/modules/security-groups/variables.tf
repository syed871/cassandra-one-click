variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "ssh_allowed_cidrs" {
  description = "CIDR ranges allowed to connect through SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
