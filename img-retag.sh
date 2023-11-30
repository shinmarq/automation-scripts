#!/bin/bash

AWS_REPO_NAME="my-repo"
AWS_REPO_URL="<account id>.dkr.ecr.<region>.amazonaws.com"
ACR_NAME="<organization>.azurecr.io"
IMAGE_NAME="<image name>"
IMAGE_TAG="build-xxxx"

docker pull $AWS_REPO_URL/$IMAGE_NAME:$IMAGE_TAG
docker tag "$AWS_REPO_URL/$IMAGE_NAME:$IMAGE_TAG" "$ACR_NAME/$IMAGE_NAME:$IMAGE_TAG"
docker push "$ACR_NAME/$IMAGE_NAME:$IMAGE_TAG"

echo "Completed..."

