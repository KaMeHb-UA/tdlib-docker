#!/bin/sh

export DOCKER_CLI_EXPERIMENTAL=enabled

PLATFORMS="linux/386,linux/amd64,linux/arm/v5,linux/arm/v6,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/mips64le,linux/s390x"
DH_NAME="kamehb/tdlib"

docker run --rm --privileged multiarch/qemu-user-static --reset -p yes

docker buildx use stdbuilder || docker buildx create --use --name stdbuilder

docker buildx build -f "Dockerfile" -t "$DH_NAME:$1" "--platform=$PLATFORMS" . --push
