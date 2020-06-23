resource "kubernetes_job" "default" {
  metadata {
    name = "hazelcast-test-client"
  }
  spec {
    template {
      metadata {
        labels = {
          name       = "hazelcast-test-client"
          created-by = "terraform"
          purpose    = "testing"
        }
      }
      spec {
        automount_service_account_token = true
        container {
          name              = "client"
          image             = "local/hazelcast_client:latest"
          image_pull_policy = "Never"
        }
      }
    }
  }
}
