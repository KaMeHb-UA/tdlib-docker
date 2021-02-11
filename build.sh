#!/bin/sh

export DOCKER_CLI_EXPERIMENTAL=enabled

PLATFORMS="linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x"
DH_NAME="kamehb/tdlib"

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

docker buildx use stdbuilder || docker buildx create --use --name stdbuilder

tag=`[ "$1" == latest ] && echo "$1" || echo $(echo "$1" | cut -c2-)`

docker buildx build --build-arg version="$1" -f "Dockerfile" -t "$DH_NAME:$tag" -t "$DH_NAME:latest" "--platform=$PLATFORMS" . --push
