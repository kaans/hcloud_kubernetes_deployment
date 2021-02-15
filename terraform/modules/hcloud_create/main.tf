resource "hcloud_ssh_key" "user_access" {
  name       = "user_access"
  public_key = var.ssh_public_key
}

resource "hcloud_floating_ip" "gateway" {
  type          = "ipv4"
  home_location = var.floating_ip_location
  name          = "gateway"
}

resource "hcloud_floating_ip_assignment" "gateway" {
  floating_ip_id = hcloud_floating_ip.gateway.id
  server_id      = hcloud_server.node[0].id
}

resource "hcloud_rdns" "floating_gateway" {
  count          = length(var.kubernetes_dns_name) > 0 ? 1 : 0
  floating_ip_id = hcloud_floating_ip.gateway.id
  ip_address     = hcloud_floating_ip.gateway.ip_address
  dns_ptr        = var.kubernetes_dns_name
}

/**
* Servers
*/

resource "hcloud_server" "node" {
  count       = length(var.nodes)
  name        = "node-${var.nodes[count.index].id}"
  server_type = var.nodes[count.index].server_type
  image       = var.nodes[count.index].image
  ssh_keys    = [hcloud_ssh_key.user_access.id]
  location    = var.nodes[count.index].location
  keep_disk   = var.nodes[count.index].keep_disk

  labels = {
    "controlplane" = contains(var.nodes[count.index].roles, "controlplane")
    "etcd"         = contains(var.nodes[count.index].roles, "etcd")
    "worker"       = contains(var.nodes[count.index].roles, "worker")
  }
}

/**
* Network
*/


resource "hcloud_network" "k8s" {
  name     = var.hcloud_private_network_name
  ip_range = var.private_network_ip_range
}

resource "hcloud_network_subnet" "nodes" {
  network_id   = hcloud_network.k8s.id
  type         = "cloud"
  network_zone = var.subnet_network_zone
  ip_range     = var.subnet_ip_range
}

resource "hcloud_server_network" "k8snode" {
  count     = length(var.nodes)
  server_id = hcloud_server.node[count.index].id
  subnet_id = hcloud_network_subnet.nodes.id
}
