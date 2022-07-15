# Generating ansible inventory
resource "local_file" "generate_ansible_inventory" {

  content = templatefile("${path.module}/script-ansible-inventory-creator.tfpl", {
      inventory_tag         = var.instance_tags,        # hostname of the ec2 instance
      # inventory_ip          = aws_instance.dev_node.*.public_ip
      inventory_ip          = aws_instance.dev_node.*.public_dns
    })
  filename = "${path.module}/ansible/inventory"

  depends_on = [
    aws_instance.dev_node
  ]
}

# generating ansible playbook install_git.yml
resource "local_file" "generate_ansible_playbook_install_git" {

  content = templatefile("${path.module}/script-ansible-playbook-install-git.tfpl", {
      inventory_tag         = var.instance_tags        # hostname of the ec2 instance
    })
  filename = "${path.module}/ansible/playbooks_dir/install-git"

  depends_on = [
    aws_instance.dev_node
  ]
}