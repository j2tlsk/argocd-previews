#!/usr/bin/env bash
set -euo pipefail

APP_ID="${APP_ID:?Error: APP_ID must be set}"
REPO="${REPO:?Error: REPO must be set}"
IMAGE_TAG="${IMAGE_TAG:?Error: IMAGE_TAG must be set}"
HOSTNAME="${HOSTNAME:?Error: HOSTNAME must be set}"

cat preview.yaml \
    | kyml tmpl -e REPO -e APP_ID -e IMAGE_TAG -e HOSTNAME \
    | tee helm/templates/$APP_ID.yaml
