module "hazelcast" {
  source            = "../../"
  name              = "customer-orders"
  hazelcast_version = "3.11.7"
  labels = {
    CreatedBy = "terraform"
    Purpose   = "testing"
  }
}