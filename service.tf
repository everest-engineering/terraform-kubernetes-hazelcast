resource "kubernetes_service" "hazelcast" {
  metadata {
    name   = var.name
    labels = var.labels
  }
  spec {
    selector = {
      name = var.name
    }
    port {
      port = 5701
    }
  }
}