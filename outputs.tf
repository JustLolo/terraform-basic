output "intances_tree" {
  value = local.instances
}

output "webapp" {
  value = {
    for name, value in aws_instance.webapp : name => [value.tags.Name, value.public_dns, value.public_ip]
  }
}

output "webapp_asg" {
  value = {
    for name, value in aws_instance.webapp_asg : name => [value.tags.Name, value.public_dns, value.public_ip]
  }
}

output "database" {
  value = {
    for name, value in aws_instance.database : name => [value.tags.Name, value.public_dns, value.public_ip]
  }
}
