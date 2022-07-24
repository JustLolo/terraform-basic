output "intances_tree" {
  value = local.instances
}

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