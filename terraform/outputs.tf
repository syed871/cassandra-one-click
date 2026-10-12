output "vpc_id" {
  value = module.vpc.vpc_id
}

output "cassandra_private_ips" {
  value = module.instances.private_ips
}

output "cassandra_instance_ids" {
  value = module.instances.instance_ids
}

output "cassandra_nodes" {
  value = {
    for index, instance_id in module.instances.instance_ids :
    "${var.project_name}-node-${index + 1}" => module.instances.private_ips[index]
  }
}
