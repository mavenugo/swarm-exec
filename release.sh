#!/bin/bash
set -x

NAMESPACE=${NAMESPACE:-"mavenugo"}
IMAGE_NAME=${IMAGE_NAME:-"swarm-exec"}
DOCKER_TAG_LATEST=${DOCKER_TAG_LATEST:-"yes"}
FULL_IMAGE_NAME=$NAMESPACE/$IMAGE_NAME
VERSION=${VERSION:-"17.03.0-ce"}
BASE_URL=${BASE_URL:-"get"}

if [[ $VERSION == *"-rc"* ]]
then
    BASE_URL="test"
fi

# build the binary
./build.sh

docker build --build-arg VERSION=$VERSION --build-arg BASE_URL=$BASE_URL -t $FULL_IMAGE_NAME:$VERSION -f Dockerfile .
docker push $FULL_IMAGE_NAME:$VERSION

if [[ "$DOCKER_TAG_LATEST" == "yes" ]] ; then
    docker push $FULL_IMAGE_NAME:latest
fi

rm -f bin/swarm-exec
