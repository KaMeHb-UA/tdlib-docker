#!/bin/sh

export DOCKER_CLI_EXPERIMENTAL=enabled

PLATFORMS="linux/386,linux/amd64,linux/arm/v5,linux/arm/v6,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/mips64le,linux/s390x"
DH_NAME="kamehb/tdlib"

docker run --rm --privileged docker/binfmt:66f9012c56a8316f9244ffd7622d7c21c1f6f28d

docker buildx use stdbuilder || docker buildx create --use --name stdbuilder

docker buildx build -f "Dockerfile" -t "$DH_NAME:$1" "--platform=$PLATFORMS" . --push
