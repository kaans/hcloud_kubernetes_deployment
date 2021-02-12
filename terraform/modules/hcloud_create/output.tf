output "external_ips" {
  value = hcloud_server.node.*.ipv4_address
}

output "internal_ips" {
  value = hcloud_server_network.k8snode.*.ip
}

output "hostnames" {
  value = hcloud_server.node.*.name
}

output "gateway_ip" {
  value = hcloud_floating_ip.gateway.ip_address
}

output "gateway_dns" {
  value = join("", hcloud_rdns.floating_gateway[*].dns_ptr)
}
