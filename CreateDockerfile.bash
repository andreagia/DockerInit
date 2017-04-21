#!/bin/bash
apt-get install apt-transport-https  ca-certificates  curl  software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce

WANIP=$(curl http://checkip.amazonaws.com)
openssl req -new -nodes -x509 -subj "/C=IT/ST=Oregon/L=Florence/O=IT/CN=$WANIP" -days 3650 -keyout ./mds2.key.pem -out ./mds2.cert.pem -extensions v3_ca 
sed "s/WANIP/$WANIP/g" "nginx.conf.tmp" > ./tmp && mv ./tmp nginx.conf
sed "s/TOKEN1/$1/g" "Dockerfile.tmp" > ./tmp && mv ./tmp Dockerfile
sed "s/PROVIDER2/$2/g" "Dockerfile" > ./tmp && mv ./tmp Dockerfile

docker build -t saas .
docker run -p 443:443 saas
