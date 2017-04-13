#!/bin/bash
sed "s/TOKEN1/$1/g" "Dokerfile.tmp" > ./tmp && mv ./tmp Dokerfile
sed "s/PROVIDER2/$2/g" "Dokerfile" > ./tmp && mv ./tmp Dokerfile

