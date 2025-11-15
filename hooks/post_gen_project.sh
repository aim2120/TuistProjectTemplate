#!/bin/bash

set -e

# Initialize git repository
git init
git add .
git commit -m "Created project"

# Initialize trunk
trunk init -y

git add .trunk
git commit -m "Initialized trunk"

# Trust files
mise trust -a

# Install dependencies and generate project
if ! which tuist > /dev/null; then
    echo "Tuist is not installed. Would you like to install it? (y/n)"
    read -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mise install tuist
    else
        echo "Please install tuist manually to generate the project."
        exit 1
    fi
fi

tuist install
tuist generate

git add .
git commit -m "Generated project"