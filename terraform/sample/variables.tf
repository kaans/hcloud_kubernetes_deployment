variable "hcloud_token" {
  description = "Token for the Hetzner cloud project where the servers will be created"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key used to connect to the servers"
  type        = string
}

variable "ssh_private_key" {
  description = "SSH private key used to connect to the servers"
  type        = string
}

variable "kubernetes_dns_name" {
  description = "Domain name that should point to the cluster. This is set as reverse DNS entry in the floating IP in Hetzner cloud."
  type        = string
  default     = ""
}

variable "ansible_inventory_output_file_path" {
  description = "Path where the dynamic inventory with the created servers for Ansible is stored. If modified, make sure to adjust ansible.cfg accordingly."
  default     = "../ansible/inventory.cfg"
  type        = string
}

variable "cloudflare_api_token" {
  description = "API Token for cloudflare. Used to set up the DNS entry in cloudflare."
  default     = "enteryourtokenhere"
  type        = string
}

variable "cloudflare_dns_name" {
  description = "DNS name set up in cloudflare that should point to the floating IP of the cluster. This should not be the full domain but the subdomain part, e.g. cluster instead of cluster.domain.com."
  default     = ""
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Zone ID of the zone of the domain in cloudflare."
  default     = ""
  type        = string
}

variable "hcloud_nodes" {
  description = "List of servers that make up the cluster"
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
  description = "Name of the Hetzner cloud private network"
  default     = "k8s"
  type        = string
}

variable "hcloud_private_network_enable" {
  type        = bool
  description = "Enable use of private Hetzner network for pods; need to specify the name of the network in hcloud_private_network_name. This must be enabled in order for the hcloud_cloud_controller to initialize with a node IP from the cloud provider."
  default     = true
}

variable "hcloud_csi_enable" {
  description = "If true, enable HCloud CSI plugin; else disable it"
  default     = false
  type        = bool
}

variable "hcloud_cloud_controller_enable" {
  description = "If true, enable HCloud Cloud Controller plugin; else disable it. This must be true in order for the cluster to be initialized with the cloud provider."
  default     = true
  type        = bool
}

variable "k8s_print_config_enable" {
  description = "If true, enable the output of the kubernetes config; else do not output it"
  default     = false
  type        = bool
}

variable "cloudflare_enable" {
  description = "If true, enable registration of the cluster on a DNS record in cloudflare; else do not register it"
  default     = false
  type        = bool
}

variable "dashboard_enable" {
  description = "If true, enable the Kubernetes dashboard; else disable it"
  default     = false
  type        = bool
}
