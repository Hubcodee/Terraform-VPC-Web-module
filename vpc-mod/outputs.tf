#Subnet Id outputs 
# Must reference the below vars in root module
output "subnet_id1" {
  value       = aws_subnet.subnet1.id
  description = "Subnet1 id"
}
output "subnet_id2" {
  value       = aws_subnet.subnet2.id
  description = "Subnet2 id"
}
output "vpc_id" {
  value = aws_vpc.main.id
  description = "VPC id"
}
