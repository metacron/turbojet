#!/bin/bash

if [ -z "${GITCONFIG}" ]; then
  GITCONFIG="[url \"https://git@github.com\"]
        insteadOf = \"ssh://git@github.com\"
"
fi

echo "${GITCONFIG}" > ~/.gitconfig

cd "${CHANGE_DIR}/" || exit 1

exec "$@"
