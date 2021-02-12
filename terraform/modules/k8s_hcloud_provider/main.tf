locals {
  hcloud_secret_name = "hcloud-api-token"
}

resource "kubernetes_service_account" "cloud-controller-manager" {
  metadata {
    name      = "cloud-controller-manager"
    namespace = "kube-system"
  }
}

resource "kubernetes_secret" "cloud-controller-manager" {
  metadata {
    name      = local.hcloud_secret_name
    namespace = "kube-system"
  }

  data = {
    token = var.hcloud_token
  }
}

resource "kubernetes_cluster_role_binding" "cloud-controller-manager" {
  metadata {
    name = "system:cloud-controller-manager"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "cloud-controller-manager"
    namespace = "kube-system"
  }
}

resource "helm_release" "hcloud_cloud_controller" {
  name       = "hcloud-cloud-controller"
  repository = "https://helm-charts.mlohr.com"
  chart      = "hcloud-cloud-controller-manager"
  version    = var.hc_cloud_controller_version
  namespace  = "kube-system"

  depends_on = [
    kubernetes_secret.cloud-controller-manager
  ]

  set {
    name  = "manager.secret.create"
    value = false
  }

  set {
    name  = "manager.secret.name"
    value = local.hcloud_secret_name
  }

  set {
    name  = "manager.privateNetwork.enabled"
    value = var.hcloud_private_network_enable
  }

  set {
    name  = "manager.privateNetwork.id"
    value = var.hcloud_private_network_name
  }

  set {
    name  = "manager.privateNetwork.clusterSubnet"
    value = "10.244.0.0/16"
  }

  set {
    name  = "manager.loadBalancers.enabled"
    value = var.load_balancers_enable
  }
}

resource "helm_release" "hc_csi" {
  count = var.hcloud_csi_enable ? 1 : 0
  name       = "hcloud-csi-driver"
  repository = "https://helm-charts.mlohr.com/"
  chart      = "hcloud-csi-driver"
  version    = var.hc_csi_version
  namespace  = "kube-system"

  depends_on = [
    kubernetes_secret.cloud-controller-manager
  ]

  set {
    name  = "csiDriver.storageClass.isDefault"
    value = true
  }

  set {
    name  = "csiDriver.secret.create"
    value = false
  }

  set {
    name  = "csiDriver.secret.name"
    value = local.hcloud_secret_name
  }
}
