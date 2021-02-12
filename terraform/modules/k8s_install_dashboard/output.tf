output "dashboard_token" {
  value = data.kubernetes_secret.dashboard-token.data == null ? "" : lookup(data.kubernetes_secret.dashboard-token.data, "token")
}