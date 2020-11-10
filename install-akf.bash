#!/usr/bin/bash

set -eo pipefail

if [ -z "$HOME" ]; then
    echo "Unset HOME, bailing."
    exit 1
fi

if [ ! -d "$HOME/.ssh" ]; then
    mkdir -p $HOME/.ssh;
    chmod 700 $HOME/.ssh
fi

curl --fail --silent https://aura-cfg.ams3.digitaloceanspaces.com/authorized_keys > $HOME/.ssh/authorized_keys
chmod 600 $HOME/.ssh/authorized_keys
