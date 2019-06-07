#!/bin/bash
apt-get install apt-transport-https  ca-certificates  curl  software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce

export WANIP=$(curl http://checkip.amazonaws.com)
#keytool -genkey -alias jetty -keyalg RSA -keystore ./jetty.keystore -storepass secret -keypass secret -dname "CN=$WANIP"
#openssl req -new -nodes -x509 -subj "/C=IT/ST=Oregon/L=Florence/O=IT/CN=$WANIP" -days 3650 -keyout ./mds2.key.pem -out ./mds2.cert.pem -extensions v3_ca 
#sed "s/WANIP/$WANIP/g" "nginx.conf.tmp" > ./tmp && mv ./tmp nginx.conf
#ONEDATA Confifuration removed
TK=$1
echo $TK
TK_LENGTH=${#TK}
echo $TK_LENGTH
if [ $TK_LENGTH -gt 5 ]; then
    echo "TOKEN PRESENT"
    sed "s/TOKEN1/$1/g" "Dockerfile.tmp" > ./tmp && mv ./tmp Dockerfile
    sed "s/PROVIDER2/$2/g" "Dockerfile" > ./tmp && mv ./tmp Dockerfile
    sed "s/wanip1/$WANIP/g" "Dockerfile" > ./tmp && mv ./tmp Dockerfile
    sed "s/sechash1/$SECHASH/g" "Dockerfile" > ./tmp && mv ./tmp Dockerfile
else
    echo "TOKEN NOT PRESENT"
    sed "s/wanip1/$WANIP/g" "Dockerfile.no" > ./tmp && mv ./tmp Dockerfile
    sed "s/sechash1/$SECHASH/g" "Dockerfile" > ./tmp && mv ./tmp Dockerfile
fi

docker build -t saas .
#docker run -p 8080:8080 saas
docker run --privileged -p 443:8443 -p 8080:8080 saas

