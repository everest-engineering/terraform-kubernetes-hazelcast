resource "kubernetes_service" "hazelcast" {
  metadata {
    name   = var.name
    labels = var.labels
  }
  spec {
    type       = "ClusterIP"
    cluster_ip = "None"
    selector = {
      name = var.name
    }
    port {
      name = "hazelcast"
      port = 5701
    }
  }
}