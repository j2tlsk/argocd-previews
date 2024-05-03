#!/bin/bash

echo -n "Please enter Pull Request number: "
read pr_id
export PR_ID=$pr_id
echo -n "Please enter Git repository name: "
read repo
export REPO=$repo
export APP_ID=pr-$REPO-$PR_ID
echo -n "Please enter Image Tag: "
read image_tag 
export IMAGE_TAG=$image_tag
export HOSTNAME=$APP_ID.localhost

cat preview.yaml \
    | kyml tmpl -e REPO -e APP_ID -e IMAGE_TAG -e HOSTNAME \
    | tee helm/templates/$APP_ID.yaml

git add .
git commit -m "$APP_ID"
git push

echo -n
echo -n "Please enter argocd port number: "
read port

argocd login localhost:$port

argocd app sync previews
