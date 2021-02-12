resource "null_resource" "ansible_install_docker" {
  triggers = {
    nodes = md5(join(",", var.nodes))
  }

  provisioner "local-exec" {
    working_dir = "../ansible"
    command     = "ansible-playbook docker.yaml --extra-vars=\"docker_version=${var.docker_version}\""
  }
}
