variable "ssh_public_key" {
  description = "Public Key to authorized the access for the machines"
}

variable "kubernetes_dns_name" {
  description = "DNS name under which the cluster will be reachable"
}

variable "nodes" {
  description = "List of nodes that make up the cluster"
  type = list(object({
    id          = string
    server_type = string
    image       = string
    location    = string
    keep_disk   = bool
    roles       = list(string)
  }))
}

variable "hcloud_private_network_name" {
  description = "Name of the hcloud private network"
  default     = "k8s"
}

variable "floating_ip_location" {
  default = "nbg1"
}

variable "private_network_ip_range" {
  default = "10.0.0.0/8"
}

variable "subnet_network_zone" {
  default = "eu-central"
}

variable "subnet_ip_range" {
  default = "10.3.0.0/24"
}
