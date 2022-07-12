resource "local_file" "generate_ansible_inventory" {


  content = templatefile("${path.module}/script-ansible.tfpl", {
      inventory_tag         = var.instance_tags,        # hostname of the ec2 instance
      # inventory_ip          = aws_instance.dev_node.*.public_ip
      inventory_ip          = aws_instance.dev_node.*.public_dns
    })
  filename = "${path.module}/ansible/inventory"

  depends_on = [
    aws_instance.dev_node
  ]
  
  # this setting will trigger the script every time var.instance-state change
  # triggers = {
  #   added-or-removed-instances = "${aws_instance.dev_node.*.public_ip}"
  # }
}


