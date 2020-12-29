#!/bin/bash


echo "$INPUT_GITCONFIG" > ~/.gitconfig

cd "${INPUT_PATH}/" || exit 1

exec "$@"
