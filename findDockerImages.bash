#!/bin/bash

# Ищем по shb/shb-develop/latest соответствующий ему тэг в shb/shb. Поиск на основе равных digest

REPOSITORY=$1
LATEST_REPOSITORY=$2
USER_LOGIN=$3

# get authorization token
TOKEN=$(curl --silent -u $USER_LOGIN https://dc2.my-bg.ru/service/token?service=harbor-registry\&scope=repository:$REPOSITORY:pull,push | jq -r '.token')

LATEST_REPOSITORY_TOKEN=$(curl --silent -u shb_deploy:MHA2BwyQCrXr5QbF https://dc2.my-bg.ru/service/token?service=harbor-registry\&scope=repository:$LATEST_REPOSITORY:pull,push | jq -r '.token')

# find all tags
ALL_TAGS=$(curl -s -H "Authorization: Bearer $TOKEN" https://dc2.my-bg.ru/v2/$REPOSITORY/tags/list | jq -r .tags[])

target_digest=$(curl -s -D - -H "Authorization: Bearer $LATEST_REPOSITORY_TOKEN" -H "Accept: application/vnd.docker.distribution.manifest.v2+json" https://dc2.my-bg.ru/v2/$LATEST_REPOSITORY/manifests/latest | grep Docker-Content-Digest | cut -d ' ' -f 2)

# get image digest for target
TARGET_DIGEST=$(curl -s -D - -H "Authorization: Bearer $TOKEN" -H "Accept: application/vnd.docker.distribution.manifest.v2+json" https://dc2.my-bg.ru/v2/shb/shb-develop/manifests/latest | grep Docker-Content-Digest | cut -d ' ' -f 2)
# for each tags
for tag in ${ALL_TAGS[@]}; do
  # get image digest
  digest=$(curl -s -D - -H "Authorization: Bearer $TOKEN" -H "Accept: application/vnd.docker.distribution.manifest.v2+json" https://dc2.my-bg.ru/v2/$REPOSITORY/manifests/$tag | grep Docker-Content-Digest | cut -d ' ' -f 2)

  # check digest
  if [[ $target_digest = $digest ]]; then
    echo "$tag"
  fi
done