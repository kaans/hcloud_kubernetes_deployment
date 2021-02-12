locals {
  output_file_path = "${path.root}/${var.output_file_path}"
}

resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/ansible_inventory.tpl",
    {
      nodes = var.node_ips
    }
  )
  filename = local.output_file_path
}