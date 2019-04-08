#!/bin/bash
ROOT_DIR=$(pwd)

source $ROOT_DIR/.circleci/utils.sh

installGcloudAndK8s() {
  info "Add the Cloud SDK distribution URI as a package source"
  is_success_or_fail $(echo "deb http://packages.cloud.google.com/apt cloud-sdk-jessie main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list)

  info "Import the Google Cloud Platform public key"
  is_success_or_fail $(curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -)

  info "Update the package list and install the Cloud SDK"
  is_success_or_fail $(sudo apt-get update && sudo apt-get install kubectl google-cloud-sdk)
}

activateServiceAccount() {
    require GCLOUD_SERVICE_KEY $GCLOUD_SERVICE_KEY
    require SERVICE_KEY_PATH $SERVICE_KEY_PATH
    require PROJECT_ID $PROJECT_ID
    require COMPUTE_ZONE $COMPUTE_ZONE
    require CLUSTER_NAME $CLUSTER_NAME

    info "Activate Google Service Account"

    echo $GCLOUD_SERVICE_KEY | base64 --decode > $SERVICE_KEY_PATH
    # setup kubectl auth
    gcloud auth activate-service-account --key-file $SERVICE_KEY_PATH
    gcloud --quiet config set project ${PROJECT_ID}
    gcloud --quiet config set compute/zone ${COMPUTE_ZONE}
    gcloud --quiet container clusters get-credentials ${CLUSTER_NAME}
}

main(){
  installGcloudAndK8s
  activateServiceAccount
}

$@