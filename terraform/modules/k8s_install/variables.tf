variable "external_ips" {
  description = "List of public IP addresses of nodes to include in the cluster"
}

variable "internal_ips" {
  description = "List of internal IP addresses of nodes to include in the cluster"
}

variable "hostnames" {
  description = "List of hostnames of nodes to include in the cluster"
}

variable "nodes" {
  description = "Specification of nodes to be created"
}

variable "ssh_private_key" {
  description = "Private Key to authorized the access for the machines"
}

variable "hcloud_token" {}

variable "cluster_name" {
  description = "Name of the cluster used in the kube config"
  type = string
  default = "local"
}
