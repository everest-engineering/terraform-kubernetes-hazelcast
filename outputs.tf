output "service_name" {
  description = "Hazelcast service name (cluster ip)"
  value       = kubernetes_service.hazelcast.metadata.0.name
}