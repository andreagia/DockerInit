#!/bin/bash
apt-get update
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
apt-get update
apt-get install -y docker-engine


sed "s/TOKEN1/$1/g" "Dockerfile.tmp" > ./tmp && mv ./tmp Dockerfile
sed "s/PROVIDER2/$2/g" "Dockerfile" > ./tmp && mv ./tmp Dockerfile

docker build -t saas .
docker run -p 8080:8080  --privileged --dns 150.217.1.32 saas

