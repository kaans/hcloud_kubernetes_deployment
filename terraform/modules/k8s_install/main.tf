resource "rke_cluster" "cluster" {
  dynamic "nodes" {
    for_each = var.external_ips

    content {
      address           = nodes.value
      user              = "root"
      role              = var.nodes[nodes.key].roles
      ssh_key           = var.ssh_private_key
      hostname_override = var.hostnames[nodes.key]
      internal_address  = var.internal_ips[nodes.key]
    }
  }

  kubernetes_version = "v1.18.6-rancher1-2"

  cloud_provider {
    name = "external"
  }

  network {
    plugin = "canal"
  }

  authentication {
    sans = var.internal_ips
  }

  services {
    kubeproxy {
      extra_args = {
        "nodeport-addresses" = "10.0.0.0/8"
      }
    }
  }
}
