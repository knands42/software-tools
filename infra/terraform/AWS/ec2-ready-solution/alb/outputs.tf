# Load Balancer outputs
output "load_balancer_id" {
  description = "ID of the load balancer"
  value       = aws_lb.main.id
}

output "load_balancer_arn" {
  description = "ARN of the load balancer"
  value       = aws_lb.main.arn
}

output "load_balancer_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.main.dns_name
}

output "load_balancer_zone_id" {
  description = "Canonical hosted zone ID of the load balancer"
  value       = aws_lb.main.zone_id
}

output "load_balancer_hosted_zone_id" {
  description = "Canonical hosted zone ID of the load balancer (alias for zone_id)"
  value       = aws_lb.main.zone_id
}

# Target Group outputs
output "target_group_id" {
  description = "ID of the target group"
  value       = aws_lb_target_group.main.id
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.main.arn
}

output "target_group_name" {
  description = "Name of the target group"
  value       = aws_lb_target_group.main.name
}

output "target_group_port" {
  description = "Port of the target group"
  value       = aws_lb_target_group.main.port
}

output "target_group_protocol" {
  description = "Protocol of the target group"
  value       = aws_lb_target_group.main.protocol
}

# Listener outputs
output "http_listener_arn" {
  description = "ARN of the HTTP listener"
  value       = aws_lb_listener.http.arn
}

output "https_listener_arn" {
  description = "ARN of the HTTPS listener (if certificate is provided)"
  value       = var.certificate_arn != "" ? aws_lb_listener.https[0].arn : null
}

output "http_only_listener_arn" {
  description = "ARN of the HTTP-only listener (if no certificate is provided)"
  value       = var.certificate_arn == "" ? aws_lb_listener.http_only[0].arn : null
}

# Security Group outputs
output "security_group_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}

output "security_group_arn" {
  description = "ARN of the ALB security group"
  value       = aws_security_group.alb.arn
}

output "security_group_name" {
  description = "Name of the ALB security group"
  value       = aws_security_group.alb.name
}

# Health Check outputs
output "health_check_path" {
  description = "Health check path"
  value       = var.health_check_path
}

output "health_check_protocol" {
  description = "Health check protocol"
  value       = var.health_check_protocol
}

output "health_check_interval" {
  description = "Health check interval"
  value       = var.health_check_interval
}

# Load Balancer attributes
output "load_balancer_type" {
  description = "Type of load balancer"
  value       = aws_lb.main.load_balancer_type
}

output "load_balancer_subnets" {
  description = "Subnets attached to the load balancer"
  value       = aws_lb.main.subnets
}

output "load_balancer_security_groups" {
  description = "Security groups attached to the load balancer"
  value       = aws_lb.main.security_groups
}