#!/bin/bash

ROOT_DIR=$(pwd)

source $ROOT_DIR/.circleci/utils.sh

prepareIamServerSecrets() {
    require IAM_SERVER_SECRETS $IAM_SERVER_SECRETS
    require IAM_SERVER_SECRETS_PATH $IAM_SERVER_SECRETS_PATH

    info "Prepare iam-server secrets"
    echo $IAM_SERVER_SECRETS | base64 --decode > $IAM_SERVER_SECRETS_PATH
    is_success "iam-server secrets up to date!"
}

main() {
    prepareIamServerSecrets
}

$@
