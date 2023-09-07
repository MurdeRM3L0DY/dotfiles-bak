#!/usr/bin/env bash

nix run .\#home-manager -- switch --flake ".#$USER.x86_64-linux"
