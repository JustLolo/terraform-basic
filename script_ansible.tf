# # Generating ansible inventory
# resource "local_file" "generate_ansible_inventory" {

#   content = templatefile("${path.module}/script-ansible-inventory-creator.tfpl", {
#     instances = var.instances
#     # inventory_tag = var.instance_tags, # hostname of the ec2 instance
#     inventory_tag = var.instance_tags, # hostname of the ec2 instance
#     # inventory_ip          = aws_instance.dev_node.*.public_ip
#     inventory_ip = aws_instance.dev_node.*.public_ip
#   })
#   filename = "${path.module}/ansible/inventory"

#   depends_on = [
#     aws_instance.dev_node
#   ]
# }

# generating ansible playbook install_git.yml
# resource "local_file" "generate_ansible_playbook_install_git" {

#   content = templatefile("${path.module}/script-ansible-playbook-install-git.tfpl", {
#     inventory_tag = var.instance_tags # hostname of the ec2 instance
#   })
#   filename = "${path.module}/ansible/playbooks_dir/install-git.yml"

#   depends_on = [
#     aws_instance.dev_node
#   ]
# }

#                               #
##   #######################   ##
########  ## Local env config  ##  ########
##   #######################   ##
#                               #
#Getting the current username, it's needed for configuring the current environment
# data "external" "current_user" {
#   program = ["bash", "./scripts/get_current_username.sh"]

#   # same, but first will remain for organization purposes and "consistency"
#   # program = ["bash","-c", <<EOT
#   #       echo "{"
#   #       echo "\"username\": \"$(whoami)\""
#   #       echo "}"
#   #   EOT
#   # ]
# }

# # generating ansible playbook ssh_config_local.yml
# resource "local_file" "generate_ansible_ssh_config_local" {
#   content = templatefile("${path.module}/script-ansible-playbook-ssh-config-local.tfpl", {
#     list_Name_ip_state = [aws_instance.dev_node.*.tags.Name, aws_instance.dev_node.*.public_ip, aws_instance.dev_node.*.instance_state]
#     current_user       = data.external.current_user.result.username
#   })
#   filename = "${path.module}/ansible/playbooks_dir/ssh-config-local.yml"

#   depends_on = [
#     aws_instance.dev_node
#   ]
# }

# # running the play book every time the generated file changes bc new host will be added to ssh config
# resource "null_resource" "update_ssh_config" {

#   provisioner "local-exec" {
#     on_failure  = fail
#     interpreter = ["/bin/bash", "-c"]
#     command     = <<EOT
#         cd ./ansible
#         ansible-playbook playbooks_dir/ssh-config-local.yml
#     EOT
#   }

#   depends_on = [
#     local_file.generate_ansible_ssh_config_local
#   ]

#   triggers = {
#     file_changed = md5(local_file.generate_ansible_ssh_config_local.content),
#     instance     = join(",", aws_instance.dev_node.*.public_ip)
#   }
# }


# # deleting the host from ssh config every time the instance is deleted
# resource "null_resource" "delete_ssh_config" {
#   for_each = toset(aws_instance.dev_node.*.tags.Name)

#   provisioner "local-exec" {
#     when        = destroy
#     on_failure  = fail
#     interpreter = ["/bin/bash", "-c"]
#     command     = <<EOT
#         cd ./ansible
#         echo "Deleting ${each.key} from ssh config:"
#         echo "ansible-playbook ./playbooks_dir/ssh-config-local.yml --extra-vars "${replace(each.key, "-", "_")}_state='absent'""
#         ansible-playbook ./playbooks_dir/ssh-config-local.yml --extra-vars "${replace(each.key, "-", "_")}_state='absent'"
#     EOT
#   }

#   depends_on = [
#     local_file.generate_ansible_ssh_config_local
#   ]
# }


# # generating ansible playbook ssh_config_know_host_local.yml
# resource "local_file" "generate_ansible_ssh_config_know_host_local" {
#   content = templatefile("${path.module}/script_ansible_ssh_config_know_host_local.tfpl", {
#     # list_Name_ip_state = [aws_instance.dev_node.*.tags.Name, aws_instance.dev_node.*.public_ip, aws_instance.dev_node.*.instance_state]
#     # current_user       = data.external.current_user.result.username
#   })
#   filename = "${path.module}/ansible/playbooks_dir/ssh_config_know_host_local.yml"

#   depends_on = [
#     aws_instance.dev_node
#   ]
# }

# #testing
