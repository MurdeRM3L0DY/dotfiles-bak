#!/usr/bin/env bash

# install paru

# install nix daemon
NIX_VERSION=v0.15.1
curl --proto '=https' --tlsv1.2 -sSf -L "https://install.determinate.systems/nix/tag/${NIX_VERSION}" | sh -s -- install --diagnostic-endpoint='' --no-confirm
