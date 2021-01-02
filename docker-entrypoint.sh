#!/bin/bash

if [ -z "${INPUT_GITCONFIG}" ]; then
  INPUT_GITCONFIG="[url \"https://git@github.com\"]
        insteadOf = \"ssh://git@github.com\"
"
fi

echo "${INPUT_GITCONFIG}" > ~/.gitconfig

cd "${INPUT_PATH}/" || exit 1

exec "$@"
