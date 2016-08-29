startProdNuppServer () {

  docker rm -f nupp-server

  docker run --name nupp-server --hostname nupp-server -e NODE_ENV=production
  -p 3000:3000 -d crizstiano/nupp-server:1.0
}

startDevNuppServer () {
  docker build --tag 'crizstiano/nupp-server:1.0' . --no-cache
  docker run --name nupp-server --hostname nupp-server \
  -e NODE_ENV=development \
  -v $(pwd)/code:/home/nupp/app \
  -v /home/nupp/app/node_modules \
  -p 3000:3000 -d crizstiano/nupp-server:1.0
}

startNewProyect () {
  cd starter
  docker build --tag 'crizstiano/nupp-server:1.0' . --no-cache
  cd ..
  docker run --name nupp-server --rm -v $(pwd)/code:/home/nupp/app \
  crizstiano/nupp-server:1.0 bash -c 'npm init --yes && npm shrinkwrap'
  docker rmi crizstiano/nupp-server:1.0
}

# init process

# create files
startNewProyect

# create docker node container with development environment
startDevNuppServer

# create docker node container with production environment
# startProdNuppServer
