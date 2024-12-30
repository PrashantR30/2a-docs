#!/bin/bash
set -e

# Deploy all versions
mike deploy v1.0.0 --update-aliases
mike deploy v2.0.0 --update-aliases latest

# Set the default version
mike set-default latest --push

# Serve locally or deploy to hosting platform based on arguments
if [[ "$1" == "serve" ]]; then
    mike serve
else
    mike deploy --push
fi
