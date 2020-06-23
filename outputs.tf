output "service_dns" {
  description = "fully qualified dns name of the hazelcast service"
  value       = "${var.name}.${var.namespace}.svc.cluster.local"
}