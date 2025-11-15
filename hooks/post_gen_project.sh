#!/bin/bash

set -e

print_step() {
    echo "‍🍪 Cookiecutter ==> $1"
}

# Trust files
print_step "Trusting files"
mise trust -a

# Install dependencies
print_step "Installing dependencies"
mise install

# Initialize git repository
print_step "Initializing git repository"
git init
git add .
git commit -m "Created project" --no-verify

# Initialize trunk
print_step "Initializing trunk"
trunk init -y
trunk check enable swiftformat

git add .trunk
git commit -m "Initialized trunk" --no-verify

# Format code
print_step "Formatting code"
trunk fmt --all
if ! git diff --quiet; then
    git add .
    git commit -m "Formatted code" --no-verify
fi

# Generate project
if [ "{{ cookiecutter.generate_project }}" = "true" ]; then
    print_step "Generating project"
    tuist install
    tuist generate

    git add .
    git commit -m "Generated project" --no-verify
else
    print_step "Skipping project generation"
fi
