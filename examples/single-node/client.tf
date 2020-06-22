resource "kubernetes_job" "default" {
  metadata {
    name = "client"
  }
  spec {
    template {
      metadata {
        labels = {
          name = "client"
        }
      }
      spec {
        container {
          name              = "client"
          image             = "hazelcast/client:latest"
          image_pull_policy = "Never"
        }
      }
    }
  }
}