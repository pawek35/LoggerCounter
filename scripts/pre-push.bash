#!/bin/bash

echo "Running pre-push hook"
./scripts/run-rspec.bash

# $? stores exit value of the last command
if [ $? -ne 0 ]; then
 echo "Tests must pass before pushing!"
 exit 1
fi