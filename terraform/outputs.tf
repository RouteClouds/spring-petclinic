output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.main.name
}

output "eks_kubeconfig" {
  description = "Kubeconfig for the EKS cluster"
  value       = local.kubeconfig
  sensitive   = true
}

output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = aws_db_instance.main.address
}

output "rds_port" {
  description = "Port of the RDS instance"
  value       = aws_db_instance.main.port
}

output "rds_username" {
  description = "Username for the RDS instance"
  value       = aws_db_instance.main.username
}

output "rds_password" {
  description = "Password for the RDS instance"
  value       = aws_db_instance.main.password
  sensitive   = true
}
