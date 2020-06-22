variable "name" {
  description = "name of the cluster"
  default     = "hazelcast"
}
variable "hazelcast_version" {
  description = "hazelcast version to deploy"
}
variable "cpu" {
  description = "cpu units to request"
  default     = "1"
}
variable "memory" {
  description = "amount of memory to request"
  default     = "1Gi"
}
variable "labels" {
  description = "labels to apply to all resources"
  type        = map(string)
}