variable "dns_name" {}

variable "target_ip" {}

variable "zone_id" {}

variable "dns_entry_type" {
  default = "A"
}

variable "dns_entry_ttl" {
  default = 3600
}
