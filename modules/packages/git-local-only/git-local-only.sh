#!/usr/bin/env bash

git fetch --prune

git for-each-ref --format='%(refname:short) %(upstream:short)' refs/heads | \
while read -r local upstream; do
  if [ -z "$upstream" ] || ! git show-ref --verify --quiet "refs/remotes/$upstream"; then
    echo "$local"
  fi
done
