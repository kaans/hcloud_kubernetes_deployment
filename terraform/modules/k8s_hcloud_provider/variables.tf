variable "hcloud_token" {}

variable "hcloud_private_network_name" {
  description = "Name of the Hetzner cloud network"
  default     = ""
}

variable "hcloud_private_network_enable" {
  type        = bool
  description = "Enable use of private Hetzner network for pods; need to specify the name of the network in hcloud_private_network_name"
  default     = false
}

variable "hc_cloud_controller_version" {
  description = "Version of the hcloud cloud controller"
  default     = "2.2.2"
}

variable "hc_csi_version" {
  description = "Version of the hcloud csi driver"
  default     = "1.0.4"
}

variable "load_balancers_enable" {
  default = false
}

variable "hcloud_csi_enable" {
  description = "If true, enable HCloud CSI plugin; else disable it"
  default = false
  type = bool
}

variable "hcloud_cloud_controller_enable" {
  description = "If true, enable HCloud Cloud Controller plugin; else disable it"
  default = true
  type = bool
}
