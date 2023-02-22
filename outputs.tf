output "ip_worker" {
  value = aws_instance.ansible_worker.public_ip
}