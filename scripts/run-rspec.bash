#!/bin/bash

set -e

cd "${0%/*}/.."

echo "Running rspec"
bundle exec rspec