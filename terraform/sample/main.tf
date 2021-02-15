####
# Providers
####

provider "hcloud" {
  token = var.hcloud_token
}

provider "kubernetes" {
  config_path    = "kube_config.yaml"
  config_context = "local"

  client_certificate     = module.k8s_install.client_cert
  client_key             = module.k8s_install.client_key
  cluster_ca_certificate = module.k8s_install.ca_crt
  host                   = module.k8s_install.api_server_url
}

provider "helm" {
  kubernetes {
    config_path    = "kube_config.yaml"
    config_context = "local"

    client_certificate     = module.k8s_install.client_cert
    client_key             = module.k8s_install.client_key
    cluster_ca_certificate = module.k8s_install.ca_crt
    host                   = module.k8s_install.api_server_url
  }
}

provider "rke" {
  debug = false
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

####
# Modules
####

module "hcloud_create" {
  source = "../modules/hcloud_create"

  ssh_public_key              = var.ssh_public_key
  kubernetes_dns_name         = var.kubernetes_dns_name
  hcloud_private_network_name = var.hcloud_private_network_name

  nodes = var.hcloud_nodes
}

module "ansible_install_docker" {
  source = "../modules/ansible_install_docker"

  node_ips = module.hcloud_create.external_ips

  # docker version must be supported by rke provider, currently 19.03
  docker_version = "5:19.03.15~3-0~debian-buster"
}

module "k8s_install" {
  source = "../modules/k8s_install"

  external_ips    = module.hcloud_create.external_ips
  ssh_private_key = var.ssh_private_key
  internal_ips    = module.hcloud_create.internal_ips
  nodes           = var.hcloud_nodes
  hostnames       = module.hcloud_create.hostnames
  hcloud_token    = var.hcloud_token

  depends_on = [
    module.ansible_install_docker
  ]
}

module "cloudflare" {
  source = "../modules/cloudflare"

  count = var.cloudflare_enable ? 1 : 0

  dns_name  = var.cloudflare_dns_name
  target_ip = module.hcloud_create.gateway_ip
  zone_id   = var.cloudflare_zone_id
}

module "k8s_print_config" {
  source = "../modules/k8s_print_config"

  count = var.k8s_print_config_enable ? 1 : 0

  kube_config_yaml = module.k8s_install.kube_config_yaml
}

module "k8s_hcloud_provider" {
  source = "../modules/k8s_hcloud_provider"

  count = var.hcloud_cloud_controller_enable || var.hcloud_csi_enable ? 1 : 0

  hcloud_token                  = var.hcloud_token
  hcloud_private_network_name   = var.hcloud_private_network_name
  hcloud_private_network_enable = var.hcloud_private_network_enable
  hcloud_csi_enable             = var.hcloud_csi_enable
}

module "k8s_install_dashboard" {
  source = "../modules/k8s_install_dashboard"

  count = var.dashboard_enable ? 1 : 0
}
