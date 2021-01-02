#!/bin/bash

echo "$INPUT_GITCONFIG" > ~/.gitconfig

ls -lah

echo "helloworld"
echo "$INPUT_GITCONFIG"

cd "${INPUT_PATH}/" || exit 1

exec "$@"
