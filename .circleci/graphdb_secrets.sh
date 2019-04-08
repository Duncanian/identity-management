#!/bin/bash

ROOT_DIR=$(pwd)

source $ROOT_DIR/.circleci/utils.sh

prepareGraphDbSecrets() {
    require GRAPH_DB_SECRETS $GRAPH_DB_SECRETS
    require GRAPH_DB_SECRETS_PATH $GRAPH_DB_SECRETS_PATH

    info "Prepare graphdb secrets"
    echo $GRAPH_DB_SECRETS | base64 --decode > $GRAPH_DB_SECRETS_PATH
    is_success "Graph db secrets up to date!"
}

main() {
    prepareGraphDbSecrets
}

$@
