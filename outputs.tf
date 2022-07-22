# output "dev_ip" {
#   value = aws_instance.dev_node.*.public_ip
# }

# output "dev_public_dns" {
#   value = aws_instance.dev_node.*.public_dns
# }

# output "dev_tags" {
#   value = aws_instance.dev_node.*.tags.Name
# }

output "instance_tags" {
  value = {
    for name, value in aws_instance.instance : name => value.tags.Name
  }
}

output "instance_ip" {
  value = {
    for name, value in aws_instance.instance : name => value.public_ip
  }
}

output "instance_public_dns" {
  value = {
    for name, value in aws_instance.instance : name => value.public_dns
  }
}

# output "instance_ip" {
#   for_each = {
#     key = "value"
#   }
#   value = aws_instance.instance.*.public_ip
# }

# output "instance_public_dns" {
#   value = aws_instance.instance.*.public_dns
# }

# output "instance_tags" {
#   value = aws_instance.instance.*.tags.Name
# }
