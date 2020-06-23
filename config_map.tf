resource "kubernetes_config_map" "hazelcast" {
  metadata {
    name   = var.name
    labels = var.labels
  }
  data = {
    "hazelcast.yaml" = templatefile("${path.module}/hazelcast.yaml.tmpl", {
      service_dns = "${var.name}.${var.namespace}.svc.cluster.local"
    })
  }
}