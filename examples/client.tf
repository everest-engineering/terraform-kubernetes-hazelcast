// This is an example test job to validate whether the cluster is setup propertly or not
// This resource is disabled by default

resource "kubernetes_job" "default" {
  count = 0
  metadata {
    name = "hazelcast-test-client"
  }
  spec {
    template {
      metadata {
        labels = {
          name    = "hazelcast-test-client"
          purpose = "testing"
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
