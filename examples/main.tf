module "hazelcast" {
  source            = "../"
  name              = "customer-orders"
  hazelcast_version = "3.12.7"
  cluster_members   = 3
  cpu               = "500m"
  memory            = "200Mi"
  labels = {
    created-by = "terraform"
    purpose    = "example"
  }
}
