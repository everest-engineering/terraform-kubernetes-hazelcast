resource "kubernetes_deployment" "hazelcast" {
  metadata {
    name   = var.name
    labels = var.labels
  }
  spec {
    replicas = var.cluster_members
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
          env {
            name  = "JAVA_OPTS"
            value = "-Dhazelcast.config=/opt/hazelcast/config_ext/hazelcast.yaml"
          }
          volume_mount {
            name       = "hazelcast-config"
            mount_path = "/opt/hazelcast/config_ext/"
          }
        }
        automount_service_account_token = true
        volume {
          name = "hazelcast-config"
          config_map {
            name = var.name
          }
        }
      }
    }
  }
}
