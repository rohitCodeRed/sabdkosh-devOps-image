DevOps Docker Image
===

![](https://i.imgur.com/hMQ3Eow.jpg)

What we gonna Develop?
---
> * We will be developing **Mean** App  with angular 2 with automated code push, build, testing and Deploy by **Jenkins Tools** and **Docker**.
> * At the end, will create it's **Docker** image.

## Introduction

<i class="fa fa-file-text"></i> **DevOps** (a clipped compound of "development" and "operations") is a software engineering culture and practice that aims at unifying software development (Dev) and software operation (Ops).
Basically It's an automatiom of end-to-end software delivery lifecycle.
For more details (https://en.wikipedia.org/wiki/DevOps,
https://www.versionone.com/devops-101/what-is-devops/).

<i class="fa fa-file-text"></i> **Docker** 
It allows us to run applications inside containers. These containers in most cases communicate with each other.
:::info
Docker containers wrap a piece of software in a complete filesystem that contains everything needed to run: code, runtime, system tools, system libraries – anything that can be installed on a server. This guarantees that the software will always run the same, regardless of its environment.
:::
For more details (https://www.docker.com/what-docker)

<i class="fa fa-file-text"></i> **Docker Image**
:::info 
An image is an inert, immutable, file that's essentially a snapshot of a container. Images are created with the build command, and they'll produce a container when started with run. Images are stored in a Docker registry such as registry.hub.docker.com. Because they can become quite large, images are designed to be composed of layers of other images, allowing a miminal amount of data to be sent when transferring images over the network. 
:::

<i class="fa fa-file-text"></i> **Jenkins**
Jenkins is a Continuous Integration (CI) server or tool which is written in java. It provides Continuous Integration services for software development, which can be started via command line or web application server.
For more details (https://vmokshagroup.com/blog/what-is-jenkins/)

<i class="fa fa-file-text"></i> **MEAN App**
:::info
The term MEAN refers to a collection of JavaScript based technologies used to develop web applications. MEAN is an acronym for MongoDB, ExpressJS, AngularJS and Node.js. From client to server to database, MEAN is full stack JavaScript.
:::
Mean App is App developed from all above technology.

Please view source code on [GitHub](https://github.com/hackmdio/hackmd-io-issues/issues/new).



**Table of Contents**
[TOC]


So Let's Start!!
===
## Installing and Running Docker
 There are many ways of installing Docker, two of them are
*  Install using the repository
*  Manually Install from a package

I tried both one, but faced error with repository option. So I installed manually. Please follow link before installation (https://docs.docker.com/install/linux/docker-ce/ubuntu/#upgrade-docker-ce).
I installed **docker CE** for 64 bit linux OS with Ubuntu distro.
``` shell
$ uname -a
Linux rohit-comp 4.13.0-36-generic #40~16.04.1-Ubuntu SMP Fri Feb 16 23:25:58 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

$ cat /etc/os-release
NAME="Linux Mint"
VERSION="18.3 (Sylvia)"
ID=linuxmint
ID_LIKE=ubuntu
PRETTY_NAME="Linux Mint 18.3"
VERSION_ID="18.3"
HOME_URL="http://www.linuxmint.com/"
SUPPORT_URL="http://forums.linuxmint.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/linuxmint/"
VERSION_CODENAME=sylvia
UBUNTU_CODENAME=xenial
```
To check Docker Installation,
``` shell
$ sudo docker info
Containers: 1
 Running: 0
 Paused: 0
 Stopped: 1
Images: 1
 ...
 ..
 .
```
Docker install as a root privilages, to get rid of sudo follow link: https://docs.docker.com/install/linux/linux-postinstall/.

## Installing and Running Jenkin Image as Master Docker Container
Go to jenkins website (https://jenkins.io/doc/book/getting-started/installing/) and find “Docker” section.All the options are briefly explained.
``` shell
$ docker run \
  -u root \
  --rm \
  -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkinsci/blueocean  
```

:::info
After Installation, I find jenkins is running on **http://localhost:8080**. :mega:
First time it asking the password, which I get after  running the below command: 
```shell
$ docker logs <containerID>
...
..
Jenkins initial setup is required. An admin user has been created and a password generated.
Please use the following password to proceed to installation:

b7dfc43dad7f4ff58f3eadedd6ee1d97

This may also be found at: /var/jenkins_home/secrets/initialAdminPassword
...
.
```
:::

Finally, I installed the suitable plugins.
::: info
After plugins installation, you can create new image with same settings as default "jenkinsci/blueocean" image.:mega:
Command used:
``` shell
$ docker container ls

CONTAINER ID        IMAGE                 COMMAND                  CREATED             STATUS              PORTS                                              NAMES
4ff91266d7ab        jenkinsci/blueocean   "/sbin/tini -- /us..."   31 seconds ago      Up 27 seconds       0.0.0.0:8080->8080/tcp, 0.0.0.0:50000->50000/tcp   youthful_noether

$ docker commit 4ff91266d7ab master_jenkins

sha256:b8a9e8c5ebe3d5a0aaf1febea2a6189761eff0ca76961430aa0ea7367e125617

$ docker image ls

REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
master_jenkins        latest              b8a9e8c5ebe3        14 seconds ago      436 MB
jenkinsci/blueocean   latest              f04e14ab531d        6 days ago          433 MB
hello-world           latest              e38bc07ac18e        3 months ago        1.85 kB
```
:::

> * You can use more options: https://docs.docker.com/engine/reference/commandline/commit/.
> * You can see all docker images in repository.json file at path: 
>**/var/lib/docker/image/repository.json**
> * Also jenkin package at **/var/lib/docker/volume/jenkin-data**.


### Running hello-world Slave Image from jenkins Master Container

After login into jenkins, let's create our own pipeline.
:::info
**Jenkins Pipeline**
Jenkins Pipeline (or simply "Pipeline") is a suite of plugins which supports implementing and integrating continuous delivery pipelines into Jenkins.

Jenkins Pipeline provides an extensible set of tools for modeling simple-to-complex delivery pipelines "as code". The definition of a Jenkins Pipeline is typically written into a text file (called a Jenkinsfile) which in turn is checked into a project’s source control repository.
* For more details please refers: **https://jenkins.io/doc/pipeline/tour**

:::

Steps:
* **Go to "new items" in menu**.

    ![](https://i.imgur.com/9Vwj3L2.png)
    ![](https://i.imgur.com/SdAT8RC.png)
    
* **After entering project name, select pipeline option**.
* **Then you configure the project and at last write the script for running docker image**:

![](https://i.imgur.com/3MGqtWU.png)

* **After above step dashboard look like**:

![](https://i.imgur.com/j6kdzjc.png)

* **Then go to project and click the build now option from menu**:

![](https://i.imgur.com/8nFZl4R.png)

* :tada: Hurray!!! finally we run the docker container from jenkins master conatiner .

![](https://i.imgur.com/uUbqzJh.png)
![](https://i.imgur.com/INXbrGw.png)

:::info
* Through **Open Blue Ocean** option, you can easily configure and set up multiple pipeline projects with so much interactive UI. :mega:
* You can also pipeline with GIT, GITHUB,Bit Bucket repositories.
for more details prefer: **https://jenkins.io/doc/book/blueocean/**
:::

## Installing and Running a MongoDB Server image through Docker

I created a folder locally, under which DockerFile is saved.

:::success
**DockerFile**
* A Dockerfile is a text configuration file written in a popular, human-readable Markup Language called YAML.
* It is a step-by-step script of all the commands you need to run to assemble a Docker Image.
* The docker build command processes this file generating a Docker Image in your Local Image Cache, which you can then start-up using the docker run command, or push to a permanent Image Repository.

* for more details refer: https://codefresh.io/docker-tutorial/build-docker-image-dockerfiles/, https://docs.docker.com/engine/reference/builder/#usage
:::

```shell
$ mkdir ~/dockerFiles/mongoDockerFile/
$ ls
docker-entrypoint.sh  Dockerfile

```
:point_right: I downloaded it from git repository:https://github.com/docker-library/mongo.

**DockerFile** look like..
```shell
FROM ubuntu:xenial

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
		jq \
		numactl \
	&& rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root (https://github.com/tianon/gosu/releases)
ENV GOSU_VERSION 1.10
# grab "js-yaml" for parsing mongod's YAML config files (https://github.com/nodeca/js-yaml/releases)
ENV JSYAML_VERSION 3.10.0

RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		wget \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	chmod +x /usr/local/bin/gosu; \
    ..........
    ....
    ..
```
:point_right: Building Mongodb Image steps . . . :fire:
* **Run command docker < path >**:
```shell
$ docker build -t mongo_image ~/dockerFiles/mongoDockerFile/

Sending build context to Docker daemon 29.18 kB
Step 1/22 : FROM ubuntu:xenial
xenial: Pulling from library/ubuntu
8ee29e426c26: Pull complete 
6e83b260b73b: Pull complete 
e26b65fd1143: Pull complete 
40dca07f8222: Pull complete 
b420ae9e10b3: Pull complete 
Digest: sha256:3097ac92b852f878f802c22a38f97b097b4084dbef82893ba453ba0297d76a6a
Status: Downloaded newer image for ubuntu:xenial
 ---> 7aa3602ab41e
.......
.........
.....
---> 5182af174621
Removing intermediate container a993eac70d01
Step 17/22 : RUN mkdir -p /data/db /data/configdb 	&& chown -R mongodb:mongodb /data/db /data/configdb
 ---> Running in 8f430a61c7a1
 ---> f8416b437cd4
Removing intermediate container 8f430a61c7a1
Step 18/22 : VOLUME /data/db /data/configdb
 ---> Running in f70530166d9c
 ---> 6f7d4c1be4d4
Removing intermediate container f70530166d9c
Step 19/22 : COPY docker-entrypoint.sh /usr/local/bin/
 ---> f4dbc4ec208b
Removing intermediate container e868262ee4a4
Step 20/22 : ENTRYPOINT docker-entrypoint.sh
 ---> Running in 398fd62574c3
 ---> 2ecfb72fc501
Removing intermediate container 398fd62574c3
Step 21/22 : EXPOSE 27017
 ---> Running in 6c90f7a5db9f
 ---> 6a138701af20
Removing intermediate container 6c90f7a5db9f
Step 22/22 : CMD mongod
 ---> Running in e329ca553521
 ---> 6155456a21b8
Removing intermediate container e329ca553521
Successfully built 6155456a21b8

$ docker image ls

REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
mongo_image           latest              6155456a21b8        11 seconds ago      379 MB
ubuntu                xenial              7aa3602ab41e        11 days ago         115 MB
master_jenkins        latest              b8a9e8c5ebe3        2 weeks ago         436 MB
jenkinsci/blueocean   latest              f04e14ab531d        3 weeks ago         433 MB
hello-world           latest              e38bc07ac18e        3 months ago        1.85 kB

```
* **Running the Mongo image**:
```shell
$ docker run --name mongo_container -p 27017:27017 mongo_image

2018-08-07T16:14:46.306+0000 I CONTROL  [main] Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'
2018-08-07T16:14:46.311+0000 I CONTROL  [initandlisten] MongoDB starting : pid=1 port=27017 dbpath=/data/db 64-bit host=0b26e5b03843
2018-08-07T16:14:47.677+0000 I CONTROL  [initandlisten] 
2018-08-07T16:14:47.928+0000 I STORAGE  [initandlisten] createCollection: local.startup_log with generated UUID: d846bf70-343c-4313-9407-9af118793080
2018-08-07T16:14:48.156+0000 I FTDC     [initandlisten] Initializing full-time diagnostic data capture with directory '/data/db/diagnostic.data'
2018-08-07T16:14:48.158+0000 I STORAGE  [LogicalSessionCacheRefresh] createCollection: config.system.sessions with generated UUID: e5da2512-ec6d-492e-a358-10ed70a2d2a0
2018-08-07T16:14:48.158+0000 I NETWORK  [initandlisten] waiting for connections on port 27017
2018-08-07T16:14:48.628+0000 I INDEX    [LogicalSessionCacheRefresh] build index on: config.system.sessions properties: { v: 2, key: { lastUse: 1 }, name: "lsidTTLIndex", ns: "config.system.sessions", expireAfterSeconds: 1800 }
2018-08-07T16:14:48.628+0000 I INDEX    [LogicalSessionCacheRefresh] 	 building index using bulk method; build may temporarily use up to 500 megabytes of RAM
2018-08-07T16:14:48.630+0000 I INDEX    [LogicalSessionCacheRefresh] build index done.  scanned 0 total records. 0 secs
2018-08-07T16:14:48.631+0000 I COMMAND  [LogicalSessionCacheRefresh] command config.$cmd command: createIndexes { createIndexes: "system.sessions", indexes: [ { key: { lastUse: 1 }, name: "lsidTTLIndex", expireAfterSeconds: 1800 } ], $db: "config" } numYields:0 reslen:114 locks:{ Global: { acquireCount: { r: 1, w: 1 } }, Database: { acquireCount: { W: 1 } }, Collection: { acquireCount: { w: 1 } } } protocol:op_msg 472ms
2018-08-07T16:16:04.639+0000 I CONTROL  [signalProcessingThread] got signal 15 (Terminated), will terminate after current cmd ends
2018-08-07T16:16:04.639+0000 I NETWORK  [signalProcessingThread] shutdown: going to close listening sockets...
2018-08-07T16:16:04.639+0000 I NETWORK  [signalProcessingThread] removing socket file: /tmp/mongodb-27017.sock
2018-08-07T16:16:04.639+0000 I CONTROL  [signalProcessingThread] Shutting down free monitoring
2018-08-07T16:16:04.639+0000 I FTDC     [signalProcessingThread] Shutting down full-time diagnostic data capture
2018-08-07T16:16:04.642+0000 I STORAGE  [signalProcessingThread] WiredTigerKVEngine shutting down
2018-08-07T16:16:04.947+0000 I STORAGE  [signalProcessingThread] shutdown: removing fs lock...
2018-08-07T16:16:04.947+0000 I CONTROL  [signalProcessingThread] now exiting
```

:::info
For backing up **MongoDB** data and also auto removal of created container, Use::mega:
```shell
$ docker run --rm --name mongo_container -p 27017:27017 -v mongoData:/data/db mongo_image
```
"--rm" for auto removal

"-v mongoData:/data/db" 
Creates a mount point within the Container linking it back to file systems accessible by the Docker Host
:::



## Running a Node server
For running a server, I choose expressJs frame work: https://expressjs.com/. 

**Prerequisite**
* npm
* node

that's it, and you are ready!
Steps are very easy, also it is well documented.
I have already my expressjs project in github repository.
:::success
:point_right: link: (https://github.com/rohitCodeRed/NodeServer)

:::

```shell
$ node -v
v14.15.4

$ npm -v
6.14.11

```

**Project file structure**

![](https://i.imgur.com/qbL0hUS.png)


Let discuss about folder:
* There are three folder in **app** folder.
* **api** folder contains all the external apis with token based authentication, like post, get apis for creating, deleting users.
* **model** folder contains all the mongo db collections schemas.
* **services** folder contains all the services or functions required by **api** folder.


**Start the server**
```shell
$ node index.js 
(node:14601) DeprecationWarning: Mongoose: mpromise (mongoose's default promise library) is deprecated, plug in your own promise library instead: http://mongoosejs.com/docs/promises.html
Example app listening on port: 3001
failed to connect to server [localhost:27017] on first connect [MongoError: connect ECONNREFUSED 127.0.0.1:27017]

```
Server is started on port 3001, By hitting http://localhost:3001, web page look like:

![](https://i.imgur.com/7XNeEHD.png)
![](https://i.imgur.com/c2cbpEM.png)
![](https://i.imgur.com/h8XiMHl.png)

:::info
Above, it's all about basic static server info are showing with help of **npm** package: **systeminformation** ::mega:
:::

### Running a Node server image through Docker
Let's create a Dockerfile for node app.
**Docker** file look's like:
```Dockerfile
FROM node:14.15.4
RUN mkdir -p /usr/src/app
COPY . /usr/src/app/
WORKDIR /usr/src/app
RUN ls -al
RUN npm install
EXPOSE 3001
CMD ["node", "index.js"]
```
* All Code of node app are stored in ~/DevsOpsImage/nodeSrever directory.
Now built it..
```shell
$ docker build -t node_image ~/DevsOpsImage/nodeServer/

Sending build context to Docker daemon 29.58 MB
Step 1/6 : FROM node:14.15.4
8: Pulling from library/node
Digest: sha256:3422df4f7532b26b55275ad7b6dc17ec35f77192b04ce22e62e43541f3d28eb3
Status: Downloaded newer image for node:14.15.4
 ---> 8198006b2b57
Step 2/6 : WORKDIR /node_app
 ---> b1a3bb04379c
Removing intermediate container c2b630ad766c
Step 3/6 : COPY . /node_app
 ---> 68caaf68d07b
Removing intermediate container ea0956e26760
Step 4/6 : RUN npm install
 ---> Running in e07fa77acafa
up to date in 1.463s
 ---> cf4816dcd3d9
Removing intermediate container e07fa77acafa
Step 5/6 : CMD node index.js
 ---> Running in 2c39e44bfbea
 ---> 29174456cced
Removing intermediate container 2c39e44bfbea
Step 6/6 : EXPOSE 3001
 ---> Running in 070e3f29ab1e
 ---> 425fc0606b38
Removing intermediate container 070e3f29ab1e
Successfully built 425fc0606b38
```

* Node app docker image is succesfully built, let's run it
```shell
$ docker run --rm --name node_container -p 3001:3001 node_image

(node:7) DeprecationWarning: Mongoose: mpromise (mongoose's default promise library) is deprecated, plug in your own promise library instead: http://mongoosejs.com/docs/promises.html
Example app listening on port: 3001
failed to connect to server [localhost:27017] on first connect [MongoError: connect ECONNREFUSED 127.0.0.1:27017]

```
Now it's running on http://localhost:3001. :tada:


### Linking MongoDB and Node servers Docker Image Containers

* Let's run our **mongoDB server image**
```shell
$ docker run --rm --name mongo_container -p 27017:27017 -v mongoData:/data/db mongo_image

2018-09-10T15:09:36.188+0000 I CONTROL  [main] Automatically disabling TLS 1.0, to force-enable TLS 1.0 specify --sslDisabledProtocols 'none'
2018-09-10T15:09:36.430+0000 I CONTROL  [initandlisten] MongoDB starting : pid=1 port=27017 dbpath=/data/db 64-bit host=24871290d581
2018-09-10T15:09:36.430+0000 I CONTROL  [initandlisten] db version v4.0.0
2018-09-10T15:09:36.430+0000 I CONTROL  [initandlisten] git version: 3b07af3d4f471ae89e8186d33bbb1d5259597d51
2018-09-10T15:09:36.430+0000 I CONTROL  [initandlisten] OpenSSL version: OpenSSL 1.0.2g  1 Mar 2016
2018-09-10T15:09:36.430+0000 I CONTROL  [initandlisten] allocator: tcmalloc
2018-09-10T15:09:36.430+0000 I CONTROL  [initandlisten] modules: none
2018-09-10T15:09:36.430+0000 I CONTROL  [initandlisten] options: { net: { bindIpAll: true } }
2018-09-10T15:09:37.761+0000 I STORAGE  [initandlisten] WiredTiger message [1536592177:761386][1:0x7f301685ba00], txn-recover: Recovering log 2 through 2
2018-09-10T15:09:38.599+0000 I FTDC     [initandlisten] Initializing full-time diagnostic data capture with directory '/data/db/diagnostic.data'
2018-09-10T15:09:38.650+0000 I NETWORK  [initandlisten] waiting for connections on port 27017
```
* Then run our **Node server image**, before running node_app image we have to link with mongo_container 
```shell
$ docker run --rm --name node_container -p 3001:3001 --link=mongo_container:database node_image

(node:7) DeprecationWarning: Mongoose: mpromise (mongoose's default promise library) is deprecated, plug in your own promise library instead: http://mongoosejs.com/docs/promises.html
Example app listening on port: 3001

**-----------MongoDB connection established------------**
 DB: angularChart 
 Host: database 
 Port: 27017

```
* Now we clearly see that mongoDB connection is established. <i class="fa fa-eye fa-fw"></i>
:::info
I tried command to see the host information in node_container after linking with mongo_container
`docker exec -it node_container cat /etc/hosts`
`Output:`
```shell
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
172.17.0.2	database 17b74cacae30 mongo_container
```
:::

### Requesting REST api of Node Server (Only work when MongoDB is connected )
**1. Register API**
:::success
* Url: "http://localhost:3001/api/apiAcess/register"
* Method: POST
* **Description**: `It register the user through which other user will created ,updated and deleted.`

* **Request**: `curl -X POST \
  http://localhost:3001/api/apiAcess/register \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: d2d1eec7-e2e5-a1b2-eb18-c69fa39c1fc0' \
  -d '{
	"username":"rohit1@amdocs.com",
	"password":"rohit123"
}'`
  
* **Response**: `{
    "registered": true,
    "data": {
            "username": "rohit1@amdocs.com",
            "onCreated": "2018-09-14T15:07:59.345Z"
        }
    }`
:::

**2. Acess token Api**
:::success
* Url: "http://localhost:3001/api/apiAcess/get_token"
* Method: POST
* **Description**: `It used to get JWT Token for accessing other users apis.`

* **Request**: `curl -X POST \
  http://localhost:3001/api/apiAcess/get_token \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: a19e348e-5bc1-0d9d-a66d-1363d8b42076' \
  -d '{
	"username":"rohit1@amdocs.com",
	"password":"rohit123"
}'`
  
* **Response**: `{
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ4ZmNlNzg0Yjc1MmMzYjk3ZjM2ODM4ZTA4ZjM1OWY2IiwiaWF0IjoxNTM2OTM5MTc4LCJleHAiOjE1Mzc1NDM5Nzh9.UetQlScOaPn4fI-1cNB0GPSkbT85Yg_szMdBELZTNS8"
}`
:::

**3. Create New Users by registered JWT Token api**
:::success
* Url: "http://localhost:3001/api/user/create"
* Method: POST
* **Description**: `It create a new user by bearer token of registered token.`

* **Request**: `curl -X POST \
  http://localhost:3001/api/user/create \
  -H 'authorization: bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQ4ZmNlNzg0Yjc1MmMzYjk3ZjM2ODM4ZTA4ZjM1OWY2IiwiaWF0IjoxNTM2OTM5MTc4LCJleHAiOjE1Mzc1NDM5Nzh9.UetQlScOaPn4fI-1cNB0GPSkbT85Yg_szMdBELZTNS8' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: c0160533-ca62-1a7c-9ea3-e8900d830557' \
  -d '{
  "nickname":"rohit2",
  "username":"rohit2@gmailcom",
  "password":"rohit123"
}'`
  
* **Response**: `{
    "_id": "5b9bfe6df1eb9f1ab13bd0c8",
    "username": "rohit2@gmailcom",
    "nickname": "rohit2",
    "onCreated": "2018-09-14T18:31:09.054Z",
    "createdBy": "5b9bf92a657c401758c2ec80"
}`
:::

**4. Update User by Id with registered JWT Token api**
:::success
* Url: "http://localhost:3001/api/user/update/:id"
* hitting Url: "http://localhost:3001/api/user/update/5b9bfe6df1eb9f1ab13bd0c8"
* Method: PUT
* **Description**: `It update a user nickname from rohit2 to rocky with bearer token of registered token.`

* **Request**: ` curl -X PUT \
  http://localhost:3001/api/user/update/5b9bfe6df1eb9f1ab13bd0c8 \
  -H 'authorization: bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjViOWJmOTJhNjU3YzQwMTc1OGMyZWM4MCIsImlhdCI6MTUzNjk0ODcyNiwiZXhwIjoxNTM3NTUzNTI2fQ.tMbw0_ZCcead6MTo3b6jLSTMgYJ6rU1e_06heg1u28g' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 345ee8cd-06be-4ebc-ebf9-a48177524091' \
  -d '{
	"nickname":"roky"
}' `
  
* **Response**: `{
    "username": "rohit2@gmailcom",
    "nickname": "roky",
    "onCreated": "2018-09-14T18:31:09.054Z",
    "createdBy": "5b9bf92a657c401758c2ec80"
}`
:::

**5. Delete User by Id with registered JWT Token api**
:::success
* Url: "http://localhost:3001/api/user/delete/:id"
* hitting Url: "http://localhost:3001/api/user/delete/5b9bfe6df1eb9f1ab13bd0c8"
* Method: PUT
* **Description**: `It delete a user by Id with bearer token of registered token.`

* **Request**: `curl -X DELETE \
  http://localhost:3001/api/user/delete/5b9bfe6df1eb9f1ab13bd0c8 \
  -H 'authorization: bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjViOWJmOTJhNjU3YzQwMTc1OGMyZWM4MCIsImlhdCI6MTUzNjk0ODcyNiwiZXhwIjoxNTM3NTUzNTI2fQ.tMbw0_ZCcead6MTo3b6jLSTMgYJ6rU1e_06heg1u28g' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -H 'postman-token: 20a060fc-a200-5b28-5c4a-06e4959cf8b3'`
  
* **Response**: `{
    "deleted": true,
    "data": {
        "n": 1,
        "ok": 1
    }
}`
:::

## Running an Angular app

For an angular app, I use angular framework: https://angular.io/

**Prequisite**
* npm
* node

**Steps**
Install angular cli.
:::info
npm install -g @angular/cli
:::

Create angular app.
:::info
ng new my-app
:::

That's it and you ready to go.
I have already my angular project in github repository.
:::success
:point_right: link: (https://github.com/rohitCodeRed/angularCli)

:::

**Project file structure**

![](https://i.imgur.com/20CIOib.png)


**Start the server**
```shell
$ ng serve
** NG Live Development Server is listening on localhost:4200, open your browser on http://localhost:4200/ **
Date: 2018-10-13T15:44:14.248Z                                                            
Hash: d975bc6c74ccb6d0a321
Time: 29998ms
chunk {inline} inline.bundle.js (inline) 3.85 kB [entry] [rendered]
chunk {main} main.bundle.js (main) 713 kB [initial] [rendered]
chunk {polyfills} polyfills.bundle.js (polyfills) 604 kB [initial] [rendered]
chunk {scripts} scripts.bundle.js (scripts) 86.9 kB [initial] [rendered]
chunk {styles} styles.bundle.js (styles) 588 kB [initial] [rendered]
chunk {vendor} vendor.bundle.js (vendor) 22.2 MB [initial] [rendered]

webpack: Compiled successfully.

```
Now the angular app is running on http://localhost:4200.
I also deploy it on firebase cloud: https://firebase.google.com/
**Hosting link** :-
:::info
:point_right: https://ng-tabula.firebaseapp.com/
:::

Angular app look like:

![](https://i.imgur.com/LAyWbwg.png)

![](https://i.imgur.com/gsfxOG6.png)

![](https://i.imgur.com/BbOdfFd.png)

![](https://i.imgur.com/a0njljc.png)


### Running an Angular app image through Docker

**Dockerfile Creation**

*Dockerfile for angular app*

```Dockerfile
FROM nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY dist/angularCli/ /usr/share/nginx/html

```
As you can see we are copying all the files from our dist folder and we are also replacing the Nginx configuration with our own custom configuration (like the one below)

Ngnix sample configuration

    server {
        listen 80;
        location / {
            root /usr/share/nginx/html;
            index index.html index.htm;
            try_files $uri $uri/ /index.html =404;
        }
    }

Assumption here is to  already you have run the **ng build --prod**.

**Building a Docker Image of angular app**

After creation of Dockerfile, let's create it's image
* In source directory, run the command

```shell
$ ng build
$ docker build -t angular_app_image .
```
**Running a Docker Image of angular app**

To run the angular app image, run command

```shell
$ docker run --rm --name angular_app_container -p 4200:80 angular_app_image  
```
* Actually here -p specifies the port container:host mapping. In which our host machine (angular app) is listening port 80.

Now it's running on http://localhost:4200. :tada:

### Linking Node server and Angular app Image Containers
* Let's run our **Node server image**
```shell
$ docker run --rm --name node_server_container -p 3001:3001 node_image

(node:6) DeprecationWarning: current URL string parser is deprecated, and will be removed in a future version. To use the new parser, pass option { useNewUrlParser: true } to MongoClient.connect.
Example app listening on port: 3001

```
* Then run our **Angular app image**. While running angular_app_image image, we have to link with node_server_container. 
```shell
$ docker run --rm --name angular_app_container -p 4200:80 --link=node_server_container angular_app_image_test

172.17.0.1 - - [24/Mar/2019:12:54:13 +0000] "GET / HTTP/1.1" 200 711 "-" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36" "-"
172.17.0.1 - - [24/Mar/2019:12:54:13 +0000] "GET /polyfills.bundle.js HTTP/1.1" 200 221728 "http://localhost:4200/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36" "-"
172.17.0.1 - - [24/Mar/2019:12:54:13 +0000] "GET /styles.bundle.js HTTP/1.1" 200 221328 "http://localhost:4200/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36" "-"
172.17.0.1 - - [24/Mar/2019:12:54:13 +0000] "GET /inline.bundle.js HTTP/1.1" 200 3887 "http://localhost:4200/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36" "-"
172.17.0.1 - - [24/Mar/2019:12:54:13 +0000] "GET /scripts.bundle.js HTTP/1.1" 200 86972 "http://localhost:4200/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36" "-"
172.17.0.1 - - [24/Mar/2019:12:54:13 +0000] "GET /main.bundle.js HTTP/1.1" 200 285438 "http://localhost:4200/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36" "-"
172.17.0.1 - - [24/Mar/2019:12:54:13 +0000] "GET /vendor.bundle.js HTTP/1.1" 200 8132087 "http://localhost:4200/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36" "-"

```
* Now the linking between angular_app_container and node_server_container is established . <i class="fa fa-eye fa-fw"></i>
:::info
I tried command to see the host information in angular_app_container after linking with node_server_container
`docker exec -it angular_app_container cat /etc/hosts`
`Output:`
```shell
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
172.17.0.2	node_server_container 2cc6e57181d8
172.17.0.3	d51fc67de038
```
:::

Now both node server (http://localhost:3001) and angular app (http://localhost:4200) is running and linked. :tada:

## Build, Run and link all three Images From scratch
Right now, we have both **Angular** and **Node** project are in **Git hub**. Let's pull both project and build it's image

* **angular_app_image** 
```shell 
 $ git clone https://github.com/rohitCodeRed/angularCli.git
 $ cd angularCli
 $ npm install
 $ ng build
 $ docker build -t angular_app_image .
 
```

* **node_app_image**
```shell
 $ git clone https://github.com/rohitCodeRed/NodeServer.git
 $ cd NodeServer
 $ npm install
 $ docker build -t node_app_image .
```

* **mongo**
For **mongo** image, we can directly pull from docker official page.
```shell
$ docker pull mongo
```

Now we have all three images available at our local, let's create and run **docker-compose.yml** file.
* Please install**docker-compose** before running.

```
services:
  node_app:
    container_name: node_app
    restart: always
    image: node_app_image
    ports:
      - "3001:3001"
    links:
      - mongo:database
  mongo:
    container_name: mongo
    image: mongo
    volumes:
      - ./data:/data/db
    ports:
      - "27017:27017"
  angular_app:
    container_name: angular_app
    restart: always
    image: angular_app_image
    ports:
      - "4200:80"
    links:
      - node_app

```

Let run the .yml file.
```shell
$ docker-compose up
```
This above command will show all running container logs in one terminal.
After that, Angular app will run on http://localhost:4200 and Node app will run on http://localhost:3001.



## Build, Run and link all three Images with Jenkin Docker Image
//Todo..
