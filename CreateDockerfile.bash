#!/bin/bash
apt-get install apt-transport-https  ca-certificates  curl  software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
apt-get update
apt-get install -y --allow-unauthenticated docker-engine

sed "s/TOKEN1/$1/g" "Dockerfile.tmp" > ./tmp && mv ./tmp Dockerfile
sed "s/PROVIDER2/$2/g" "Dockerfile" > ./tmp && mv ./tmp Dockerfile

docker build -t saas .
docker run -p 8080:8080 saas

