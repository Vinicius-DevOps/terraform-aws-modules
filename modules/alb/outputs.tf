output "lb_arn" {
  description = "The arn of Application Load Balancer (ALB)."
  value       = aws_lb.main.arn
}

output "lb_dns_name" {
  description = "The DNS Name of Application Load Balancer (ALB)."
  value       = aws_lb.main.dns_name
}

output "target_group_arn" {
  description = "The arn of Target Group."
  value       = aws_lb_target_group.main.arn
}

output "listener_arn" {
  description = "The arn of Listener."
  value       = aws_lb_listener.http.arn
}