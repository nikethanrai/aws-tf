output "vpc_id" {
  description = "ID of the tenant-a VPC"
  value       = module.network.vpc_id
}

output "public_subnet_id" {
  description = "ID of the tenant-a public subnet"
  value       = module.network.public_subnet_id
}

output "private_subnet_id" {
  description = "ID of the tenant-a private subnet"
  value       = module.network.private_subnet_id
}

output "runner_queue_url" {
  description = "URL of the runner job queue"
  value       = module.runner.queue_url
}

output "runner_asg_name" {
  description = "Name of the runner Auto Scaling group"
  value       = module.runner.asg_name
}
