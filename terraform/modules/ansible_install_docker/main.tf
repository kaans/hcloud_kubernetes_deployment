resource "null_resource" "ansible_install_docker" {
  triggers = {
    node_ips = md5(join(",", var.node_ips))
  }

  count = length(var.node_ips)

  connection {
    type     = "ssh"
    user     = "root"
    agent    = true
    host     = var.node_ips[count.index]
  }

  provisioner "remote-exec" {
    inline = [
      "apt update",
      "apt install -y software-properties-common",
      "apt install -y ansible",
      "mkdir -p /bootstrap/ansible"
    ]
  }

  provisioner "file" {
    source      = "${path.module}/ansible/"
    destination = "/bootstrap/ansible/"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /bootstrap/ansible",
      "ansible-playbook docker.yaml --extra-vars=\"docker_version=${var.docker_version}\""
    ]
  }
}
