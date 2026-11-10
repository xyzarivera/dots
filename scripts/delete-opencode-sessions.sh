#!/usr/bin/env zsh

opencode session list --format json | jq -r '.[].id' | xargs -n1 opencode session delete
