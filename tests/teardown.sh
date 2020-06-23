# Delete the example hazelcast cluster
cd ../examples
terraform destroy -auto-approve
cd ../tests

# Delete the job resource
cd kubernetes-resources
terraform destroy -auto-approve
