resource "kubernetes_deployment" "hazelcast" {
  metadata {
    name   = var.name
    labels = var.labels
  }
  spec {
    selector {
      match_labels = {
        name = var.name
      }
    }
    template {
      metadata {
        labels = merge(var.labels, { name = var.name })
      }
      spec {
        container {
          name  = var.name
          image = "hazelcast/hazelcast:${var.hazelcast_version}"
          resources {
            requests {
              cpu    = var.cpu
              memory = var.memory
            }
          }
        }
      }
    }
  }
}