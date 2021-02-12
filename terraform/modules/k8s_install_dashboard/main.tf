locals {
  namespace = "kubernetes-dashboard"
}

resource "kubernetes_namespace" "kubernetes-dashboard" {
  metadata {
    annotations = {
      name = local.namespace
    }

    name = local.namespace
  }
}

resource "kubernetes_service_account" "dashboard-user" {
  metadata {
    name      = "admin-user"
    namespace = local.namespace
  }
}

resource "kubernetes_cluster_role_binding" "dashboard-user" {
  metadata {
    name = "admin-user"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "admin-user"
    namespace = local.namespace
  }
}


data "kubernetes_secret" "dashboard-token" {
  metadata {
    name      = kubernetes_service_account.dashboard-user.default_secret_name
    namespace = local.namespace
  }

  depends_on = [
    kubernetes_service_account.dashboard-user
  ]
}


resource "helm_release" "kubernetes-dashboard" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  version    = var.kubernetes_dashboard_version
  namespace  = local.namespace

  set {
    name  = "metricsScraper.enabled"
    value = true
  }
}
