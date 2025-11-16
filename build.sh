#!/bin/bash
nix-shell --command "dhall-to-yaml --file docker-compose.dhall --output docker-compose.yml"