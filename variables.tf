variable "name" {
  description = "name of the cluster"
  type        = string
  default     = "hazelcast"
}
variable "namespace" {
  description = "kubernetes namespace to deploy to"
  type        = string
  default     = "default"
}
variable "hazelcast_version" {
  description = "hazelcast version to deploy"
  type        = string
}
variable "cluster_members" {
  description = "number of members in the cluster"
  type        = number
  default     = 1
}
variable "cpu" {
  description = "cpu units to request"
  type        = string
}
variable "memory" {
  description = "amount of memory to request"
  type        = string
}
variable "labels" {
  description = "labels to apply to all resources"
  type        = map(string)
}
