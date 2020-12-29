#!/bin/bash


echo "$GITCONFIG" > ~/.gitconfig

cd "CONTEXT_PATH/" || exit 1

pwd
ls -lah

exec "$@"
