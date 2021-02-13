output "external_ips" {
  value = module.hcloud_create.external_ips
}

output "internal_ips" {
  value = module.hcloud_create.internal_ips
}

output "gateway_ip" {
  value = module.hcloud_create.gateway_ip
}

output "gateway_dns" {
  value = module.hcloud_create.gateway_dns
}

output "dashboard_token" {
  value = join("", module.k8s_install_dashboard[*].dashboard_token)
}

output "kube_config_yaml" {
  value = module.k8s_install.kube_config_yaml
}
output "client_cert" {
  value = module.k8s_install.client_cert
}

output "client_key" {
  value = module.k8s_install.client_key
}

output "ca_crt" {
  value = module.k8s_install.ca_crt
}

output "api_server_url" {
  value = module.k8s_install.api_server_url
}

output "internal_kube_config_yaml" {
  value = module.k8s_install.internal_kube_config_yaml
}

output "rke_config_yaml" {
  value = module.k8s_install.rke_cluster_yaml
}

output "kube_admin_user" {
  value = module.k8s_install.kube_admin_user
}
