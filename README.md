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
## Setup Mongo
```bash
docker run -d -e MONGO_INITDB_ROOT_USERNAME=superuser -e MONGO_INITDB_ROOT_PASSWORD=mysecretpassword -p 27017:27017 --name=mongo mongo:latest
```

## Exec mongosh into container
```bash
## Localhost
docker exec -it mongo mongosh -u superuser -p mysecretpassword
## Solar DB
docker exec -it mongo mongosh 'mongodb+srv://supercluster.d83jj.mongodb.net/superData' -u 'superuser' -p 'SuperPassword'
```

## Get mongo data
```bash
docker exec -it mongo mongodump -d superData -u 'superuser' -p 'SuperPassword' -o solar-dump 'mongodb+srv://supercluster.d83jj.mongodb.net/'
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

