resource "cloudflare_record" "gateway" {
  zone_id = var.zone_id
  name    = var.dns_name
  value   = var.target_ip
  type    = var.dns_entry_type
  ttl     = var.dns_entry_ttl
}
