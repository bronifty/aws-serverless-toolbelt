#!/bin/bash
# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Source the scripts using the script directory path
source "$SCRIPT_DIR/variables.sh"



# rm -rf node_modules
# pnpm install --shamefully-hoist --prod
# zip -r lambda-express-server.zip .



#!/bin/bash

# Clean previous installs
rm -rf node_modules
rm -rf .pnpm

# Install production dependencies
pnpm install --prod

# Create a zip file for deployment
zip -r function.zip . -x "*.git*" "node_modules/.pnpm/*"

# Print the size of the zip file
du -h function.zip
