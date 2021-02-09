#!/bin/sh

# Install docker, docker-compose and Node.

#clone node project..
git clone https://github.com/rohitCodeRed/NodeServer.git

cd NodeServer

## build the image with docker file
docker build -t node_app_image .

cd ..

#clone Angular project
git clone https://github.com/rohitCodeRed/angularCli.git

cd angularCli

npm install

npx -p @angular/cli@11.1.0 ng build

## build the image with docker file
docker build -t angular_app_image .

cd ..


## Finally run deployment script...
docker-compose up
