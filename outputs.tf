output "dev_ip" {
  value = aws_instance.dev_node.public_ip
}

output "dev_public_dns" {
  value = aws_instance.dev_node.public_dns
}
