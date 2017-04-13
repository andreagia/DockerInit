#!/bin/bash
sudo apt-get update
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
sudo apt-get update
sudo apt-get install -y docker-engine


sed "s/TOKEN1/$1/g" "Dokerfile.tmp" > ./tmp && mv ./tmp Dokerfile
sed "s/PROVIDER2/$2/g" "Dokerfile" > ./tmp && mv ./tmp Dokerfile

docker build -t saas .
docker run -p 8080:8080  --privileged --dns 150.217.1.32 saas

