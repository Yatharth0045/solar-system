# Solar System NodeJS Application

A simple HTML+MongoDB+NodeJS project to display Solar System and it's planets.

---
## Requirements

For development, you will only need Node.js and NPM installed in your environement.

### Node
- #### Node installation on Windows

  Just go on [official Node.js website](https://nodejs.org/) and download the installer.
Also, be sure to have `git` available in your PATH, `npm` might need it (You can find git [here](https://git-scm.com/)).

- #### Node installation on Ubuntu

  You can install nodejs and npm easily with apt install, just run the following commands.

      $ sudo apt install nodejs
      $ sudo apt install npm

- #### Other Operating Systems
  You can find more information about the installation on the [official Node.js website](https://nodejs.org/) and the [official NPM website](https://npmjs.org/).

If the installation was successful, you should be able to run the following command.

    $ node --version
    v8.11.3

    $ npm --version
    6.1.0

---

## Github Workflows
1. workflow-1
  - Job: Unit test
    - Checkout repository
    - Setup NodeJS
    - Install Dependency
    - Cache Dependency
    - Run test cases
    - Store Test result
    - Run code coverage - ignore if errors out
  - Job: Containerization
    - Github Token Permissions | [All Permissions](https://docs.github.com/en/actions/security-for-github-actions/security-guides/automatic-token-authentication#permissions-for-the-github_token)
    - Downcase repo
    - GHCR login
    - GHCR build and push

2. workflow-2
  - Job: Running Containers
    - Job containers
    - Service containers


## Setup Mongo
```bash
docker run --rm -d -e MONGO_INITDB_ROOT_USERNAME=superuser -e MONGO_INITDB_ROOT_PASSWORD=mysecretpassword -p 27017:27017 --mount type=bind,source=./solar-dump,target=/tmp/solar-dump --name=mongo mongo:latest
```

## Exec mongosh into container
```bash
## Localhost
docker exec -it mongo mongosh -u superuser -p mysecretpassword
## Solar DB
docker exec -it mongo mongosh 'mongodb+srv://supercluster.d83jj.mongodb.net/superData' -u 'superuser' -p 'SuperPassword'
```

## Exec into mongo container
```bash
docker exec -it mongo bash
```

## Get mongo data
```bash
docker exec -it mongo mongodump -d superData -u 'superuser' -p 'SuperPassword' -o /tmp/solar-dump 'mongodb+srv://supercluster.d83jj.mongodb.net/'
```

## Install Dependencies from `package.json`
```bash
npm install
```

## Set ENVs
```bash
export MONGO_URI='mongodb+srv://supercluster.d83jj.mongodb.net/superData'
export MONGO_USERNAME='superuser'
export MONGO_PASSWORD='SuperPassword'
```

## Run Unit Testing
```bash
npm test
```

## Hit request via cURL
```bash
curl -X POST 'http://localhost:3000/planet' -H 'Content-type: application/json; charset=UTF-8' --data-raw '{"id":"3"}'
```

## Run Code Coverage
```bash
npm run coverage
```

## Run Application
```bash
npm start
```

## Access Application on Browser
    http://localhost:3000/

## Docker 

This section includes building and running the application via docker

### Build

```bash
docker build -t solar-project .
```

### Run

Using above build image
```bash
docker run \
--env MONGO_URI='mongodb+srv://supercluster.d83jj.mongodb.net/superData' \
--env MONGO_USERNAME='superuser' \
--env MONGO_PASSWORD='SuperPassword' \
-p 3000:3000 \
solar-project:latest
```

Use pre-build image
```bash
docker run --rm -d \
--env MONGO_URI='mongodb+srv://supercluster.d83jj.mongodb.net/superData' \
--env MONGO_USERNAME='superuser' \
--env MONGO_PASSWORD='SuperPassword' \
--name solar-system \
-p 3001:3000 \
yatharth0045/solar-system:latest
```

### Setup Kubernetes

## Pre-requisites

Install the following
- minikube
- ngrok: Signup on ngrok for the authentication token

## Configure ngrok
```bash
## Get auth token from ngrok
## Link: https://dashboard.ngrok.com/get-started/your-authtoken
ngrok config add-authtoken <auth-token>
```

## Extract kubeconfig
```bash
kubectl config view --flatten > kubeconfig
```

## Start minikube and expose it
```bash
minikube start
export CLUSTER_URL=$(kubectl config view -o json | jq -r '.clusters[].cluster.server') && echo $CLUSTER_URL
export CLUSTER_IP=$(echo ${CLUSTER_URL} | sed 's|https://||') && echo $CLUSTER_IP
ngrok http ${CLUSTER_URL} --host-header="${CLUSTER_IP}"
## Update the url in kubeconfig

## Validate if kubeconfig is working
kubectl --kubeconfig=kubeconfig get nodes
```