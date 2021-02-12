output "client_cert" {
  value = rke_cluster.cluster.client_cert
}

output "client_key" {
  value = rke_cluster.cluster.client_key
}

output "ca_crt" {
  value = rke_cluster.cluster.ca_crt
}

output "api_server_url" {
  value = rke_cluster.cluster.api_server_url
}

output "kube_config_yaml" {
  value = rke_cluster.cluster.kube_config_yaml
}