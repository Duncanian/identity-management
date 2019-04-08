#!/bin/bash

ROOT_DIR=$(pwd)

source $ROOT_DIR/.circleci/utils.sh

# checkout
buildTagAndPushDockerImage() {
    require DOCKER_USERNAME $DOCKER_USERNAME
    require DOCKER_PASSWORD $DOCKER_PASSWORD
    require DOCKER_REGISTRY $DOCKER_REGISTRY

    info "Build docker image for travela application"
    docker build -f docker/release/Dockerfile -t iam-server:0.0.1 .

    info "Tagging built docker image as shopinc/iam-server:0.0.1"
    docker tag iam-server:0.0.1 shopinc/iam-server:0.0.1
    is_success "Image successfully tagged shopinc/iam-server:0.0.1"

    info "Login to $DOCKER_REGISTRY container registry"
    is_success_or_fail $(echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin $DOCKER_REGISTRY)

    info "Push shopinc/iam-server:0.0.1 to $DOCKER_REGISTRY container registry"
    docker push shopinc/iam-server:0.0.1

    info "Logout of docker container registry"
    is_success_or_fail $(docker logout $DOCKER_REGISTRY)
}

buildAndDeployK8sConfiguration() {
    info "Run k8s"
    kubectl apply -f k8s/ -R
    is_success "Successfully ran k8s!"
}

main() {
    buildTagAndPushDockerImage
    buildAndDeployK8sConfiguration
}

$@
