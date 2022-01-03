output "SG_VPC" {
  value       = aws_security_group.subnetSG.id
  description = "SG id"
}
