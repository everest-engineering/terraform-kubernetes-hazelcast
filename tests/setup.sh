#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NO_COLOUR='\033[0m'

# Deploy the example hazelcast cluster
echo -e "${YELLOW}Deploying the example hazelcast cluster${NO_COLOUR}"

cd ../examples
terraform apply -auto-approve
cd ../tests

echo -e "${YELLOW}Verifying that the cluster is formed successfully${NO_COLOUR}"

# TODO(jaswanth): Use backoff strategy to read the logs
sleep 10

POD_NAME=$(kubectl get pods -l created-by=terraform | awk '{print $1}' | grep -v NAME | head -1)
LOG_MATCHES=$(kubectl logs ${POD_NAME} | grep 'Members {size:3')
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Cluster has formed successfully!${NO_COLOUR}"
else
    echo -e "${RED}Cluster failed to form!${NO_COLOUR}"
    exit
fi

# Build the project
echo -e "${YELLOW}Building the hazelcast client project${NO_COLOUR}"

cd hazelcast-java-client
./gradlew --no-daemon clean shadowJar

# Build the docker image in minikube
echo -e "${YELLOW}Building the docker image${NO_COLOUR}"
eval $(minikube docker-env )
docker build -t 'local/hazelcast_client:latest' .

cd ..

# Deploy the client as a job
echo -e "${YELLOW}Deploying the client to kubernetes cluster${NO_COLOUR}"
cd kubernetes-resources
terraform init
terraform apply -auto-approve

echo -e "${YELLOW}Verifying that the client has connected successfully${NO_COLOUR}"

# TODO(jaswanth): Use backoff strategy to read the logs
sleep 10

POD_NAME=$(kubectl get pods | awk '{print $1}' | grep hazelcast-test-client | grep -v NAME | head -1)
LOG_MATCHES=$(kubectl logs ${POD_NAME} | grep 'Connection Successful!')
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Client has connected successfully!${NO_COLOUR}"
else
    echo -e "${RED}Client failed to connect!${NO_COLOUR}"
    exit
fi