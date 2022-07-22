# resource "null_resource" "change_instance_state" {
#   count = var.instance-state == "keep" ? 0 : var.instance_count

#   provisioner "local-exec" {
#     on_failure  = fail
#     interpreter = ["/bin/bash", "-c"]

#     command = <<EOT
#         echo "Warning! Performing the --> ${lookup(var.instance-state-map, var.instance-state)} <-- operation on instance/s having:"
#         echo "ec2-id:           ${aws_instance.dev_node[count.index].id}"
#         echo "ec2-ip:           ${aws_instance.dev_node[count.index].public_ip}"
#         echo "ec2-public dns:   ${aws_instance.dev_node[count.index].public_dns}"

#         # Performing the action
#         aws ec2 ${lookup(var.instance-state-map, var.instance-state)} --instance-ids ${aws_instance.dev_node[count.index].id}
#         echo "******* Action Performed *******"
#     EOT
#   }
#   # this setting will trigger the script every time var.instance-state change
#   triggers = {
#     last-modified-state = "${var.instance-state}"
#   }
# }