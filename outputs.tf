output "db_password" {
  description = "password to database"
  value       = module.database.db_config.password
  sensitive   = true
}

output "lb_dns_name" {
  description = "dns address to access lb"
  value       = module.autoscaling.lb_dns_name
}
