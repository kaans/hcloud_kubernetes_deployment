resource "local_file" "kube_cluster_yaml" {
  filename          = "${path.root}/${var.output_file_path}"
  sensitive_content = var.kube_config_yaml

  lifecycle {
    prevent_destroy = false
  }
}
