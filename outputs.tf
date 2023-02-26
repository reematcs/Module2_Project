output "ip_deployment" {
  value = aws_instance.ansible_deployment.private_ip
}
output "ip_server" {
  value = aws_instance.ansible_provisioning_server.private_ip
}
