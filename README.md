# Solar System NodeJS Application

A simple HTML+MongoDB+NodeJS project to display Solar System and it's planets.

---
## Requirements

For development, you will only need Node.js and NPM installed in your environement.

### Node
- #### Node installation on Ubuntu

  You can install nodejs and npm easily with apt install, just run the following commands.

      $ sudo apt install nodejs
      $ sudo apt install npm

- #### Other Operating Systems
  You can find more information about the installation on the [official Node.js website](https://nodejs.org/) and the [official NPM website](https://npmjs.org/).

Check node installation with the following command.

    $ node --version
    v8.11.3

    $ npm --version
    6.1.0

## Run the application locally

Export following variables

| Variable Name | Variable Value |
| ------------- | -------------- |
| MONGO_URI | mongodb+srv://supercluster.d83jj.mongodb.net/superData |
| MONGO_USERNAME | superuser |
| MONGO_PASSWORD | SuperPassword |

## Install Dependencies from `package.json`
```bash
npm install
```

## Run Unit Testing
```bash
npm test
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

## Problem Statement

Prerequiste:  
  - AWS Account
  - Github account

Steps: 
1. Login to AWS
2. Setup following infra over AWS via Terraform
    - VPC 
    - 2 Subnets 
    - All necessary networking resource 
    - EC2 in private subnet
    - SSM access enabled over EC2

3. Containerization
    - Clone the following repo
    - Dockerize the app 

4. Deploy the app
    - Deploy the application over EC2
    - Setup the CICD process for the same via Github Actions
