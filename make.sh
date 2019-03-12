#!/bin/bash

# Help function -h and welcome message
usage() {
  cat <<EOF
Usage:
make.sh <option> -e <ARGS> (optional)
-h		show this help
-b		build docker --image--
-r		rebuild docker --image--
-t		test docker --container--
-s		run as service --container--
-c		remove docker --image--

EOF
}

# default
SERVICE_TARGET="."

# Reset the variables
BUILD=0
REBUILD=0
TEST=0
SERVICE=0
CLEAN=0

# Parse parameters
while getopts 'hbrtsc' OPTION ; do
  case "$OPTION" in
    h)  usage
		exit 0;;
    b)  BUILD=1;;
    r)	REBUILD=1;;
    t)  TEST=1;;
    s)  SERVICE=1;;
    c)  CLEAN=1;;
    *)  echo "Unknown parameter"
  esac
done

# only build the container.
build() {
  docker-compose build "$SERVICE_TARGET"

}

# force a rebuild by passing --no-cache
rebuild() {
  docker-compose build --no-cache "$SERVICE_TARGET"
}

# testing if everything runs // adopt to own needs
test() {
  docker-compose -p run --rm "$SERVICE_TARGET" sh -c '\
		echo "I am `whoami`. My uid is `id -u`." && echo "Docker runs!"' \
    && echo success
}

# run as a (background) service
service() {
  docker-compose -p up -d "$SERVICE_TARGET"
}

# remove created images
clean() {
  docker rm $(docker ps -a -q)
  docker rmi $(docker images -q)
}

if [ "$BUILD" == 1 ]
then
		echo "-----------------------------------------------------"
        echo "building the docker image"
		echo "-----------------------------------------------------"
    build
		exit 0
fi

if [ "$REBUILD" == 1 ]
then
		echo "-----------------------------------------------------"
        echo "building the docker image"
		echo "-----------------------------------------------------"
    rebuild
		exit 0
fi

if [ "$TEST" == 1 ]
then
		echo "-----------------------------------------------------"
        echo "building the docker image"
		echo "-----------------------------------------------------"
    test
		exit 0
fi

if [ "$SERVICE" == 1 ]
then
		echo "-----------------------------------------------------"
        echo "building the docker image"
		echo "-----------------------------------------------------"
    service
		exit 0
fi

if [ "$CLEAN" == 1 ]
then
		echo "-----------------------------------------------------"
        echo "building the docker image"
		echo "-----------------------------------------------------"
    clean
		exit 0
fi
